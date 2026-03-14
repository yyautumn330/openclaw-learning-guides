import {
  AMap,
  MapView,
  MapViewComponent,
  MapViewManager,
  CameraUpdateFactory,
  LatLng,
  IndoorFloorSwitchAdapter,
  IndoorBuildingInfo
} from '@amap/amap_lbs_map3d'
import { Constants } from '../../utils/Constants'

@Component
export struct IndoorMapController {
  private mMapView?: MapView;
  private mAMap?: AMap

  @State floorSwitch: IndoorFloorSwitchAdapter = new IndoorFloorSwitchAdapter();
  @Consume('isPageHide') @Watch('pageChange') isPageHide: boolean

  pageChange(changedPropertyName: string) {
    if (this.isPageHide === true) {
      this.onPageHide()
    } else {
      this.onPageShow()
    }
  }

  aboutToAppear(): void {
    MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
  }

  aboutToDisappear(): void {
    MapViewManager.getInstance().unregisterMapViewCreatedCallback(this.mapViewCreateCallback);
    this.mMapView?.onDestroy()
  }

  private mapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
    if (!mapview || this.mMapView) {
      return;
    }

    if (mapViewName != Constants.MAP_INDOOR_FUNC) {
      return;
    }

    this.mMapView = mapview;

    this.mMapView.onCreate();
    this.mMapView.getMapAsync((map) => {

      this.mAMap = map;
      this.init();
    })
  }

  init(): void {
    this.mAMap?.getUiSettings()?.setScaleControlsEnabled(true);
    this.mAMap?.getUiSettings()?.setZoomControlsEnabled(true);

    // 设置室内地图回调监听
    // 由于鸿蒙组件使用状态变量，许多监听器可以去掉，这里沿用监听接口，实际用状态变量替代
    this.mAMap?.setIndoorFloorSwitchAdapter(this.floorSwitch);

    // init
    this.mAMap?.showIndoorMap(true);
    this.mAMap?.getUiSettings()?.setIndoorSwitchEnabled(false);
    this.mAMap?.moveCamera(CameraUpdateFactory.newLatLngZoom(new LatLng(39.91095, 116.37296), 19));

  }

  onPageShow(): void {
    this.mMapView?.onResume();
  }
  onPageHide(): void {
    this.mMapView?.onPause();
  }

  OnPicker(valueName: string): void {
    let indoorBuildingInfo: IndoorBuildingInfo = this.floorSwitch.mIndoorBuildingInfo;
    let offset: number = indoorBuildingInfo.floor_names.findIndex((value: string) => value === valueName);
    if (offset >= indoorBuildingInfo.floor_names.length || offset < 0) {
      return
    }
    let index = indoorBuildingInfo.floor_indexs[offset];
    this.floorSwitch.offset = offset;
    indoorBuildingInfo.activeFloorIndex = index;
    indoorBuildingInfo.activeFloorName = valueName;
    this.mAMap?.setIndoorBuildingInfo(indoorBuildingInfo);
  }

  build() {
    NavDestination() {
      Stack(){
        MapViewComponent({ mapViewName: Constants.MAP_INDOOR_FUNC })
        TextPicker({range: this.floorSwitch?.mIndoorBuildingInfo.floor_names, selected: this.floorSwitch?.offset})
          .position({left:0, top: 0})
          .width(45)
          .height(140)
          .defaultPickerItemHeight(35)
          .backgroundColor(Color.White)
          .gradientHeight(0)
          .margin(5)
          .visibility(this.floorSwitch.visible)
          .onScrollStop((value: string | string[], index: number | number[]) => {
            this.OnPicker(value as string);
          })
          .opacity(1)
          .canLoop(false)
          .disappearTextStyle({color: Color.Red, font: {size: 10, weight: FontWeight.Lighter}})
          .textStyle({color: Color.Black, font: {size: 15, weight: FontWeight.Normal}})
          .selectedTextStyle({color: Color.Blue, font: {size: 20, weight: FontWeight.Bolder}})
          .divider({
            strokeWidth: 2,
            color: Color.Grey,
            startMargin: 8,
            endMargin: 8
          } as DividerOptions)
      }
      .width('100%')
      .height('100%')
    }
    .title(Constants.MAP_INDOOR_FUNC)
  }
}