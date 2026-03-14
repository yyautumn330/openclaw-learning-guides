import {
  AMap,
  AMapOptions,
  LatLng,
  MapView,
  MapViewComponent,
  MapViewCreateCallback,
  MapViewManager
} from "@amap/amap_lbs_map3d";
import { Constants } from "../../utils/Constants";
import { hilog } from "@kit.PerformanceAnalysisKit";
import {
  AMapException,
  BusRouteResult,
  DriveRouteQuery,
  DriveRouteResult,
  FromAndTo,
  LatLonPoint,
  OnRouteSearchListener,
  RideRouteResult,
  RouteSearch,
  WalkRouteQuery,
  WalkRouteResult
} from "@amap/amap_lbs_search";
import { WalkRouteOverlay } from "../../overlay/WalkRouteOverlay";
import { AMapUtil } from "../../utils/AMapUtil";
import { WalkRouteDetail, WalkRouteParam } from "./WalkRouteDetailController";
import { promptAction } from "@kit.ArkUI";
import { ToastUtil } from "../../utils/ToastUtil";

const tag = 'WalkRouteController'

@Component
export struct WalkRouteController {
  @Consume("pageInfos") pageInfos: NavPathStack
  @Consume('isPageHide') @Watch('pageChange') isPageHide: boolean
  @State mRotueTimeDes: string = ''
  @State hasResult: boolean = false
  private walkRouteParam: WalkRouteParam = new WalkRouteParam() // 传输参数必须先初始化
  private mapView?: MapView;
  private aMap?: AMap;
  private mContext: Context = getContext();
  private mRouteSearch?: RouteSearch;
  private mWalkRouteResult?: WalkRouteResult;
  private mStartPoint: LatLonPoint = new LatLonPoint(39.942295, 116.335891); //起点，39.942295,116.335891
  private mEndPoint: LatLonPoint = new LatLonPoint(39.995576, 116.481288); //终点，39.995576,116.481288
  private onRouteSearchListener: OnRouteSearchListener = {
    onDriveRouteSearched: (result: DriveRouteResult, errorCode: number): void => {
    },
    onRideRouteSearched: (result: RideRouteResult, errorCode: number): void => {
    },
    onBusRouteSearched: (result: BusRouteResult, errorCode: number): void => {
    },
    onWalkRouteSearched: (result: WalkRouteResult, errorCode: number) => {
      this.aMap?.clear(); // 清理地图上的所有覆盖物
      if (errorCode == AMapException.CODE_AMAP_SUCCESS) {
        if (result) {
          const paths = result.getPaths()
          if (paths && paths.length > 0) {
            this.hasResult = true
            this.mWalkRouteResult = result;
            const walkPath = this.mWalkRouteResult.getPaths()?.[0];
            if (walkPath == null) {
              return;
            }
            const walkRouteOverlay = new WalkRouteOverlay(
              this.mContext, this.aMap, walkPath,
              this.mWalkRouteResult.getStartPos(),
              this.mWalkRouteResult.getTargetPos());
            walkRouteOverlay.removeFromMap();
            walkRouteOverlay.addToMap();
            walkRouteOverlay.zoomToSpan();
            // mBottomLayout.setVisibility(View.VISIBLE);
            let dis = walkPath.getDistance();
            let dur = walkPath.getDuration();
            let des = AMapUtil.getFriendlyTime(dur) + "(" + AMapUtil.getFriendlyLength(dis) + ")";
            this.mRotueTimeDes = des;

            if (this.walkRouteParam) {
              this.walkRouteParam.distance = this.mRotueTimeDes
              this.walkRouteParam.routeDetailList = []
              walkPath.getSteps().forEach((item) => {
                this.walkRouteParam.routeDetailList.push(new WalkRouteDetail(item.getAction() ?? "",
                  item.getInstruction() ?? ""))
              })
            }
          } else if (result != null && result.getPaths() == null) {
            ToastUtil.show(this.getUIContext(), '对不起，没有搜索到相关数据！')
          }
        } else {
          ToastUtil.show(this.getUIContext(), '对不起，没有搜索到相关数据！')
        }
      } else {
        ToastUtil.showError(this.getUIContext(), errorCode)
      }
    }
  }

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

  @Builder
  buildMapWalkRoute() {
    Column() {
      MapViewComponent({ mapViewName: Constants.MAP_ROUTEWALK_FUNC }).layoutWeight(1)
      if (this.hasResult) {
        Row() {
          Column() {
            Text(`${this.mRotueTimeDes}`)
          }
          .backgroundColor(Color.White)
          .height("100%")
          .width(100)
          .padding({
            left: 30
          })
          .justifyContent(FlexAlign.SpaceAround)
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)

          Row() {
            Text("详情")
              .fontColor('#4C90F9')
              .margin({ right: 5 })

            Image($r('app.media.arrow_right_blue'))
              .width(10)
          }
          .backgroundColor(Color.White)
          .height("100%")
          .width(100)
          .padding({
            right: 10
          })
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            this.pageInfos.pushPathByName("WalkRouteDetailController", this.walkRouteParam)
          })
        }.justifyContent(FlexAlign.SpaceBetween)
        .height(80)
        .width("100%")
      }
    }.width('100%')
    .height('100%')
  }

  build() {
    NavDestination() {
      this.buildMapWalkRoute();
    }
    .title(Constants.MAP_ROUTEWALK_FUNC)
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true;
    })
    .onReady((context: NavDestinationContext) => {
      // mock请求数据
    })
  }

  async aboutToAppear(): Promise<void> {
    MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
    hilog.info(0xff, Constants.MAP_SHOW_FUNC, "aboutToAppear");
  }

  private mapViewCreateCallback: MapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
    if (!mapview || this.mapView) {
      return;
    }

    if (mapViewName != Constants.MAP_ROUTEWALK_FUNC) {
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
      this.searchRouteResult()
      this.aMap?.getUiSettings()?.setZoomControlsEnabled(true)
    })
  }

  /**
   * 开始搜索路径规划方案
   */
  public async searchRouteResult() {
    this.mRouteSearch = new RouteSearch(this.mContext)
    this.mRouteSearch.setRouteSearchListener(this.onRouteSearchListener)
    const fromAndTo = new FromAndTo(this.mStartPoint, this.mEndPoint);
    const query = new WalkRouteQuery(fromAndTo); // 第一个参数表示路径规划的起点和终点
    query.setExtensions(RouteSearch.EXTENSIONS_ALL);
    this.mRouteSearch.calculateWalkRouteAsyn(query)
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