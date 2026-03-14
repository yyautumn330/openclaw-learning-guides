import {
  AMap,
  BitmapDescriptorFactory,
  LatLng,
  MapView,
  MapViewComponent,
  MapViewManager,
  Marker,
  MarkerOptions,
  OnMarkerDragListener,
  Point,
  Projection} from '@amap/amap_lbs_map3d'
import hilog from '@ohos.hilog';
import { Constants } from '../../utils/Constants';
import { promptAction } from '@kit.ArkUI';

let globalContext: Context;

/**
 * marker点击回调功能
 */
@Component
export struct MapMarkerClickController {
  private mapView?: MapView;
  private aMap?: AMap;
  private aId: number = 0;
  @Consume('pageInfos') pageInfos: NavPathStack;
  @Consume('isPageHide') @Watch('pageChange') isPageHide: boolean
  private latLng: LatLng = new LatLng(39.91746, 116.396481);

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

  //marker功能
  @Builder
  buildMapMarker() {
    Stack() {
      MapViewComponent({ mapViewName: Constants.MAP_MARKER_CLICK_FUNC }).zIndex(0)
      Flex({ wrap: FlexWrap.Wrap }) {
        Button("clear")
          .onClick(() => {
            this.aMap?.clear();
          })
        Button("Reset")
          .onClick(() => {
            //重新标注所有的marker
            this.aMap?.clear();
            this.addMarkersToMap();
          })
      }.position({ x: 10, y: 10 })
    }.width('100%')
    .height('100%')
  }

  /**
   * 在地图上添加marker
   */
  addMarkersToMap() {
    let markerOption: MarkerOptions = new MarkerOptions()
      .setIcon(BitmapDescriptorFactory.defaultMarker(BitmapDescriptorFactory.HUE_AZURE))
      .setPosition(this.latLng)
      .setDraggable(true);
    this.aMap?.addMarker(markerOption)
  }

  /**
   * marker点击时跳动一下
   */
  jumpPoint(marker: Marker) {
    let start: number = Date.now();
    let proj: Projection | undefined = this.aMap?.getProjection();
    let markerLatlng: LatLng = marker.getPosition()
    let markerPoint: Point | undefined = proj?.toScreenLocationSync(markerLatlng);
    if (markerPoint) {
      markerPoint.y = markerPoint.y - 100;
      let startLatLng: LatLng | undefined = proj?.fromScreenLocationSync(markerPoint);
      let duration: number = 1500;

      const interpolator: ICurve = {
        interpolate: (input: number) => {
          // 模拟弹跳插值器
          if (input < 4 / 11.0) {
            return (121 * input * input) / 16.0;
          } else if (input < 8 / 11.0) {
            return (363 / 40.0 * input * input) - (99 / 10.0 * input) + 17 / 5.0;
          } else if (input < 9 / 10.0) {
            return (4356 / 361.0 * input * input) - (35442 / 1805.0 * input) + 16061 / 1805.0;
          } else {
            return (54 / 5.0 * input * input) - (513 / 25.0 * input) + 268 / 25.0;
          }
        }
      };
      const animate = () => {
        const elapsed = Date.now() - start;
        let fraction = elapsed / duration;

        if (fraction > 1) {
          fraction = 1;
        }

        const t = interpolator.interpolate(fraction);

        const lng = t * markerLatlng.longitude + (1 - t) * (startLatLng?.longitude ?? 0);
        const lat = t * markerLatlng.latitude + (1 - t) * (startLatLng?.latitude ?? 0);
        marker.setPosition(new LatLng(lat, lng));

        if (fraction < 1) {
          // 继续下一帧
          // 若框架支持requestAnimationFrame，请优先用它，替代setTimeout
          setTimeout(animate, 16);
        }
      };
      animate();
    }

  }

  private mapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
    if (!mapview || this.mapView) {
      return;
    }

    if (mapViewName != Constants.MAP_MARKER_CLICK_FUNC) {
      return;
    }

    this.mapView = mapview;

    this.mapView.onCreate();
    this.mapView.getMapAsync(async (map) => {
      this.aMap = map;

      hilog.info(0xff, Constants.MAP_MARKER_CLICK_FUNC, 'get map ' + this.aMap?.getCameraPosition()?.zoom);

      this.aMap?.getUiSettings()?.setZoomControlsEnabled(true);
      this.aMap.setOnMarkerDragListener(new OnMarkerDragListener(
        // start
        (marker: Marker) => {
          let position = marker.getPosition();
          hilog.info(0xff, Constants.MAP_MARKER_CLICK_FUNC,
            `marker drag start ${marker.getId()} ${marker.getTitle()} ${position.latitude} ${position.longitude}`);
        },
        // drap
        (marker: Marker) => {
          let position = marker.getPosition();
          hilog.info(0xff, Constants.MAP_MARKER_CLICK_FUNC,
            `marker drag move ${marker.getId()} ${marker.getTitle()} ${position.latitude} ${position.longitude}`);
        },
        // end
        (marker: Marker) => {
          let position = marker.getPosition();
          hilog.info(0xff, Constants.MAP_MARKER_CLICK_FUNC,
            `marker drag end ${marker.getId()} ${marker.getTitle()} ${position.latitude} ${position.longitude}`);
        }

      ));
      this.aMap?.setOnMarkerClickListener((marker: Marker): boolean => {
        hilog.info(0xff, Constants.MAP_MARKER_CLICK_FUNC, `marker click ${marker.getId()} ${marker.getTitle()}`);
        promptAction.showToast({ message: "您点击了Marker" })
        this.jumpPoint(marker); //跳动动画
        return true;
      });
      this.addMarkersToMap();

    })

  }

  aboutToAppear(): void {
    globalContext = getContext().getApplicationContext();
    MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
    hilog.info(0xff, Constants.MAP_MARKER_CLICK_FUNC, "aboutToAppear");
  }

  aboutToDisappear(): void {
    if (this.mapViewCreateCallback) {
      MapViewManager.getInstance().unregisterMapViewCreatedCallback(this.mapViewCreateCallback);
    }

    if (this.mapView) {
      this.mapView.onDestroy();
      this.mapView = undefined;
      this.aMap = undefined;
    }

    hilog.info(0xff, Constants.MAP_MARKER_CLICK_FUNC, "aboutToDisappear");
  }

  build() {
    NavDestination() {
      this.buildMapMarker();
    }
    .title(Constants.MAP_MARKER_CLICK_FUNC)
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true;
    })

  }
}

