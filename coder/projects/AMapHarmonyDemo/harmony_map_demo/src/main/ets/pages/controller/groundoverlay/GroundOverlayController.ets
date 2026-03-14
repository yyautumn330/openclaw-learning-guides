import {
  AMap,
  BitmapDescriptorFactory,
  CameraPosition,
  CameraUpdateFactory,
  LatLng,
  LatLngBounds,
  MapView,
  MapViewComponent,
  MapViewManager,
  OnCameraChangeListener,
} from '@amap/amap_lbs_map3d'
import hilog from '@ohos.hilog';
import { Constants } from '../../utils/Constants';
import { GroundOverlayOptions } from '@amap/amap_lbs_map3d';

let globalContext: Context;

@Component
export struct MapGroundOverlayController {
  private mapView? : MapView;
  private aMap? : AMap;
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

  //GroundOverlay功能
  @Builder
  buildMapGroundOverlay() {
    Stack() {
      MapViewComponent({mapViewName: Constants.MAP_GROUNDOVERLAY_FUNC }).zIndex(0)
      Button("新建GroundOverlay")
        .position({ x: 10, y: 10 })
        .zIndex(1)
        .onClick(async () => {
          let amap = this.aMap;

          if (amap) {
            // 设置当前地图显示为北京市恭王府
            amap.moveCamera(CameraUpdateFactory.newLatLngZoom(new LatLng(39.936713,116.386475), 18));
            let options: GroundOverlayOptions = new GroundOverlayOptions();

            let texture = await BitmapDescriptorFactory.fromRawfilePath(globalContext, 'groundoverlay.png');

            if (texture) {
              options.image(texture);
            }
            options.position(new LatLng(39.936713,116.386475), 1);
            let southwest: LatLng = new LatLng(39.935029, 116.384377)
            let northeast: LatLng = new LatLng(39.939577, 116.388331)
            let bounds: LatLngBounds = new LatLngBounds(southwest, northeast)
            options.positionFromBounds(bounds);
            options
              .anchor(0.5, 0.5)
              .setTransparency(0.7)
            // 添加一个groundOverlay
            this.aMap?.addGroundOverlay(options);
          }
        });
      Button("clear")
        .position({ x: 10, y: 50 })
        .onClick(()=> {
          this.aMap?.clear(true);
        })

    }.width('100%')
    .height('100%')
  }

  private mapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
    if (!mapview || this.mapView) {
      return;
    }

    if (mapViewName != Constants.MAP_GROUNDOVERLAY_FUNC) {
      return;
    }

    this.mapView = mapview;

    this.mapView.onCreate();
    this.mapView.getMapAsync(async (map) => {
      this.aMap = map;

      hilog.info(0xff, Constants.MAP_GROUNDOVERLAY_FUNC, 'get map ' + this.aMap?.getCameraPosition()?.zoom);

      this.aMap?.setOnMapClickListener((point: LatLng) => {
        hilog.info(0xff, Constants.MAP_GROUNDOVERLAY_FUNC, `map click ${point.longitude} ${point.latitude}`);
      });

      this.aMap?.setOnCameraChangeListener(new OnCameraChangeListener(
        (position: CameraPosition) => {
          hilog.info(0xff, Constants.MAP_GROUNDOVERLAY_FUNC,
            `map change ${position.target.longitude} ${position.target.latitude}`);
        },
        (position: CameraPosition) => {
          hilog.info(0xff, Constants.MAP_GROUNDOVERLAY_FUNC,
            `map finish ${position.target.longitude} ${position.target.latitude}`);
        }));

      this.aMap?.setOnMapTouchListener((event: TouchEvent) => {
        hilog.info(0xff, Constants.MAP_GROUNDOVERLAY_FUNC, `map touch ${event.touches[0].x} ${event.touches[0].y}`);
      });

      this.aMap?.setAMapGestureListener((event: GestureEvent) => {
        hilog.info(0xff, Constants.MAP_GROUNDOVERLAY_FUNC, `map gesture ${event.offsetX} ${event.offsetY}`);
      });

      this.aMap?.setOnMapLongClickListener((point: LatLng) => {
        hilog.info(0xff, Constants.MAP_GROUNDOVERLAY_FUNC, `map long click ${point.longitude} ${point.latitude}`);
      });

      this.aMap?.getUiSettings()?.setZoomControlsEnabled(true)
    })

  }

  aboutToAppear(): void {
    globalContext = getContext().getApplicationContext();
    hilog.info(0xff, Constants.MAP_GROUNDOVERLAY_FUNC, "aboutToAppear");
    MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
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

    hilog.info(0xff, Constants.MAP_GROUNDOVERLAY_FUNC, "aboutToDisappear");
  }



  build() {
    NavDestination() {
      this.buildMapGroundOverlay();
    }
    .title(Constants.MAP_GROUNDOVERLAY_FUNC)
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true;
    })

  }
}

