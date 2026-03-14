import { AMap,
  Arc,
  ArcOptions,
  CameraUpdateFactory,
  LatLng, MapView, MapViewComponent, MapViewManager } from "@amap/amap_lbs_map3d";
import { Constants } from "../../utils/Constants"
import { hilog } from "@kit.PerformanceAnalysisKit";
import { ColorUtil } from "../../utils/ColorUtil";

@Component
export struct MapArcController {
  private mapView? : MapView;
  private aMap? : AMap;
  @Consume('pageInfos') pageInfos: NavPathStack;
  @Consume('isPageHide') @Watch('pageChange') isPageHide: boolean

  private arcList: (Arc | undefined) [] = [];

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

  //polyline功能
  @Builder
  buildMapArc() {
    Stack(){
      MapViewComponent({ mapViewName: Constants.MAP_ARC_FUNC }).width('100%').height('100%')
      Button("changeColor").onClick(()=>{
        this.arcList.forEach((item: Arc | undefined) =>{
          const colorNow = item?.getStrokeColor()
          if(colorNow == ColorUtil.colorStringToNumber('#00ff00')){
            item?.setStrokeColor(ColorUtil.colorStringToNumber('#ff0000'))
          }else{
            item?.setStrokeColor(ColorUtil.colorStringToNumber('#00ff00'))
          }
        })
      }).position({ x: 10, y: 10 })
    }
    .width('100%')
    .height('100%')
  }

  private mapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
    if (!mapview || this.mapView) {
      return;
    }

    if (mapViewName != Constants.MAP_ARC_FUNC) {
      return;
    }

    this.mapView = mapview;

    this.mapView.onCreate();
    this.mapView.getMapAsync(async (map) => {
      this.aMap = map;

      hilog.info(0xff, Constants.MAP_ARC_FUNC, 'get map ' + this.aMap?.getCameraPosition()?.zoom);
      let x = 39.904979;
      let y = 116.40964;
      for (let i = 0; i < 10; i++) {
        let x_ = 0;
        let y_ = 0;
        x_ = Math.random() * 0.5 - 0.25;
        y_ = Math.random() * 0.5 - 0.25;
        let x_2 = 0;
        let y_2 = 0;
        x_2 = Math.random() * 0.5 - 0.25;
        y_2 = Math.random() * 0.5 - 0.25;
        let x_3 = 0;
        let y_3 = 0;
        x_3 = Math.random() * 0.5 - 0.25;
        y_3 = Math.random() * 0.5 - 0.25;
        let arcOptions: ArcOptions = new ArcOptions().point(
          new LatLng(x+x_, y+y_), new LatLng(x+x_3,y+y_3),
          new LatLng(x+x_2, y+y_2)).setStrokeColor(ColorUtil.colorStringToNumber("#ff0000"))
        this.arcList.push(this.aMap.addArc(arcOptions));
      }
      this.aMap?.moveCamera(CameraUpdateFactory.newLatLngZoom(new LatLng(39.904979, 116.40964), 8));
      this.aMap?.setMapTextZIndex(2);
      this.aMap?.getUiSettings()?.setZoomControlsEnabled(true)

    })

  }

  aboutToAppear(): void {
    // globalContext = getContext().getApplicationContext();
    MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
    hilog.info(0xff, Constants.MAP_ARC_FUNC, "aboutToAppear");
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

    hilog.info(0xff, Constants.MAP_ARC_FUNC, "aboutToDisappear");
  }



  build() {
    NavDestination() {
      this.buildMapArc();
    }
    .title(Constants.MAP_ARC_FUNC)
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true;
    })

  }
}

