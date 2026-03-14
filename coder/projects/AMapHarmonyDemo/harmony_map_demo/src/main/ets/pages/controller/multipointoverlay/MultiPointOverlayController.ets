import {
  AMap,
  BitmapDescriptor,
  BitmapDescriptorFactory,
  CameraUpdateFactory,
  LatLng,
  MapView,
  MapViewComponent,
  MapViewManager,
  Marker,
  MarkerOptions,
  MultiPointItem,
  MultiPointOverlay,
  MultiPointOverlayOptions
} from '@amap/amap_lbs_map3d';
import { Constants } from '../../utils/Constants';
import util from '@ohos.util';
import { common } from '@kit.AbilityKit';

let globalContext: Context;

interface PointData {
  desc: string;
}

@Component
export struct MultiPointOverlayController {
  private mapView?: MapView;
  private aMap?: AMap;
  private marker?: Marker;
  private multiPointOverlay?: MultiPointOverlay;
  private isDestroy: boolean = false;
  private allPointItems: MultiPointItem[] = [];

  @Consume('pageInfos') pageInfos: NavPathStack;
  @Consume('isPageHide') @Watch('pageChange') isPageHide: boolean

  onPageShow(): void {
    this.mapView?.onResume();
  }

  onPageHide(): void {
    this.mapView?.onPause();
  }

  pageChange(changedPropertyName: string) {
    if (this.isPageHide === true) {
      this.onPageHide()
    } else {
      this.onPageShow()
    }
  }

  aboutToAppear(): void {
    globalContext = getContext().getApplicationContext();
    MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
  }

  aboutToDisappear(): void {
    this.isDestroy = true;
    MapViewManager.getInstance().unregisterMapViewCreatedCallback(this.mapViewCreateCallback);

    if (this.marker) {
      this.marker.destroy();
      this.marker = undefined;
    }

    this.allPointItems = [];
    if (this.mapView) {
      this.mapView.onDestroy();
      this.mapView = undefined;
      this.aMap = undefined;
    }
  }

  private async loadPointItemsFromFile(): Promise<MultiPointItem[]> {
    const context = getContext() as common.Context;
    try {
      const rawData: Uint8Array = await context.resourceManager.getRawFileContent('point10w.dat');
      const byteLength = rawData.length;
      const float32Array = new Float32Array(
        rawData.buffer,
        rawData.byteOffset,
        byteLength / 4
      );
      const totalCount = float32Array.length / 2;
      const result: MultiPointItem[] = new Array(totalCount);
      const data: PointData = { desc: 'this is custom object' };
      for (let i = 0; i < float32Array.length; i += 2) {
        const lat = float32Array[i];
        const lon = float32Array[i + 1];
        const item = new MultiPointItem(new LatLng(lat, lon));
        item.setObject(data);
        result[i / 2] = item;
      }
      return result;
    } catch (err) {
      console.error('Failed to load point data', err);
      return [];
    }
  }

  private mapClickListener = async (latLng: LatLng) => {
    if (this.isDestroy || this.allPointItems.length === 0) return;

    let closestItem: MultiPointItem | null = null;
    let minDistSq = 0.1;

    for (const item of this.allPointItems) {
      const dLat = item.getLatLng().latitude - latLng.latitude;
      const dLon = item.getLatLng().longitude - latLng.longitude;
      const distSq = dLat * dLat + dLon * dLon;
      if (distSq < minDistSq) {
        minDistSq = distSq;
        closestItem = item;
      }
    }

    if (closestItem && !this.isDestroy) {
      if (!this.marker) {
        try {
          const redIcon = await BitmapDescriptorFactory.defaultMarkerASync(
            globalContext,
            BitmapDescriptorFactory.HUE_RED
          );
          const options = new MarkerOptions();
          options.setIcon(redIcon);
          this.marker = this.aMap?.addMarker(options);
          this.marker?.setPosition(closestItem.getLatLng());
          this.marker?.setZIndex(1000);
        } catch (e) {
          console.error('Failed to create marker', e);
        }
      } else {
        this.marker.setPosition(closestItem.getLatLng());
        this.marker.setZIndex(1000);
      }
    }
  };

  // 图层初始化延迟到 onMapReadyDelay 中执行
  private async setupMultiPointOverlay(): Promise<void> {
    if (!this.aMap) return;

    let bitmapDescriptor: BitmapDescriptor;
    try {
      bitmapDescriptor = await BitmapDescriptorFactory.fromRawfilePath(
        globalContext,
        "common/SmallPoint.png"
      ) as BitmapDescriptor;
    } catch (e) {
      console.error('Failed to load bitmap descriptor', e);
      return;
    }

    const overlayOptions = new MultiPointOverlayOptions();
    overlayOptions.icon(bitmapDescriptor);
    overlayOptions.anchor(0.5, 0.5);

    // 创建图层
    this.multiPointOverlay = this.aMap.addMultiPointOverlay(overlayOptions);
    // this.multiPointOverlay.setEnable(true); // 激活,暂时不需要

    // 设置 UI
    const uiSettings = this.aMap.getUiSettings();
    if (uiSettings) {
      uiSettings.setZoomControlsEnabled(true);
    }

    // 设置点击监听
    this.aMap.setOnMapClickListener(this.mapClickListener);

    // 加载并渲染点
    await this.loadAndRenderPoints();
  }

  private async loadAndRenderPoints(): Promise<void> {
    if (!this.multiPointOverlay || this.isDestroy) return;

    try {
      const array = await this.loadPointItemsFromFile();
      if (array.length === 0 || this.isDestroy) return;

      this.allPointItems = array;
      this.multiPointOverlay.setItems(array);
      console.log(`成功渲染 ${array.length} 个点`);
    } catch (err) {
      console.error('加载点数据失败', err);
    }
  }

  private mapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
    if (!mapview || this.mapView) return;
    if (mapViewName !== Constants.MAP_MULTIPOINTOVERLAY_FUNC) return;

    this.mapView = mapview;
    this.mapView.onCreate();

    this.mapView.getMapAsync((map: AMap) => {
      this.aMap = map;

      // 立即 moveCamera 到中国中心
      const chinaCenter = new LatLng(39.909186, 116.397411);
      this.aMap?.moveCamera(CameraUpdateFactory.newLatLngZoom(chinaCenter, 0));

      // 设置背景色，防白屏

      // 注册地图完全稳定后的回调
      this.aMap.addOnMapReadyDelayListener(() => {
        console.log('地图完全稳定，开始初始化海量点图层');
        this.setupMultiPointOverlay(); //
      });
    });
  };

  build(): void {
    Stack({ alignContent: Alignment.Center }) {
      NavDestination() {
        //  直接内联，尽早触发渲染
        MapViewComponent({ mapViewName: Constants.MAP_MULTIPOINTOVERLAY_FUNC })
          .width('100%')
          .height('100%')
      }
      .title(Constants.MAP_MULTIPOINTOVERLAY_FUNC)
      .onBackPressed(() => {
        this.pageInfos.pop();
        return true;
      })
    }
  }
}
