import {
  AMap,
  AMapOptions,
  LatLng,
  MapView,
  MapViewComponent,
  MapViewCreateCallback,
  MapViewManager,
} from "@amap/amap_lbs_map3d";
import { Constants } from "../../utils/Constants"
import { hilog } from "@kit.PerformanceAnalysisKit";
import { BusPathV2 } from "@amap/amap_lbs_search";
import { BusRouteOverlayV2 } from "../../overlay/BusRouteOverlayV2";
import { BusParamInfoV2 } from "./BusRoutePathsControllerV2";

@Builder
export function BusRouteControllerV2Builder(name: string, param: Object) {
  BusRouteControllerV2()
}

@Component
export struct BusRouteControllerV2 {
  private mapView?: MapView;
  private aMap?: AMap;
  @Consume("pageInfos") pageInfos: NavPathStack
  private mContext: Context = getContext();
  private busParamInfo: BusParamInfoV2 = {} as BusParamInfoV2

  build() {
    NavDestination() {
      this.buildMapBusRoute();
    }
    .title(Constants.MAP_ROUTEBUS_FUNC)
    .onBackPressed(() => {
      let popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      popDestinationInfo = this.pageInfos.pop()
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true;
    })
    .onReady(async (context: NavDestinationContext) => {
      this.pageInfos = context.pathStack
      this.busParamInfo = this.pageInfos.getParamByIndex(1) as BusParamInfoV2

      MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
      hilog.info(0xff, Constants.MAP_SHOW_FUNC, "aboutToAppear");
    })
  }

  @Builder
  buildMapBusRoute() {
    Column() {
      MapViewComponent({ mapViewName: Constants.MAP_ROUTEBUS_FUNC }).layoutWeight(1)
    }.width('100%')
    .height('100%')
  }

  private mapViewCreateCallback: MapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
    if (!mapview || this.mapView) {
      return;
    }

    if (mapViewName != Constants.MAP_ROUTEBUS_FUNC) {
      return;
    }

    this.mapView = mapview;

    this.mapView.onCreate();
    this.mapView.getMapAsync((map) => {
      this.aMap = map;

      hilog.info(0xff, Constants.MAP_SHOW_FUNC, 'get map ' + this.aMap?.getCameraPosition()?.zoom);

      this.aMap?.setOnMapClickListener((point: LatLng) => {
        hilog.info(0xff, Constants.MAP_SHOW_FUNC, `map click ${point.longitude} ${point.latitude}`);
      });
      this.aMap.getUiSettings()?.setScaleControlsEnabled(true)
      this.aMap.getUiSettings()?.setZoomControlsEnabled(true)
      this.aMap.getUiSettings()?.setZoomPosition(AMapOptions.ZOOM_POSITION_RIGHT_BUTTOM)
      this.mapAddPath(this.busParamInfo.busPath)
    })
  }

  mapAddPath(busPathV2: BusPathV2) {
    this.aMap?.clear(); // 清理地图上的所有覆盖物

    const busRouteOverlay = new BusRouteOverlayV2(
      this.mContext, this.aMap as AMap, busPathV2,
      this.busParamInfo.startPos,
      this.busParamInfo.targetPos);
    busRouteOverlay.removeFromMap();
    busRouteOverlay.addToMap();
    busRouteOverlay.zoomToSpan();
  }

  aboutToDisappear(): void {
    if (this.mapViewCreateCallback) {
      MapViewManager.getInstance().unregisterMapViewCreatedCallback(this.mapViewCreateCallback);
    }

    if (this.mapView) {
      this.mapView.onDestroy();
      this.mapView = undefined;
      this.aMap = undefined;
      hilog.info(0xff, Constants.MAP_SHOW_FUNC, "aboutToDisappear");
    }
  }
}