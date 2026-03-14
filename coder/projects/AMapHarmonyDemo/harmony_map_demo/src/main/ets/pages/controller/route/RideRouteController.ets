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
import {
  AMapException,
  BusRouteResult,
  DriveRouteResult,
  FromAndTo,
  LatLonPoint,
  OnRouteSearchListener,
  RideRouteQuery,
  RideRouteResult,
  RouteSearch,
  WalkRouteResult
} from "@amap/amap_lbs_search";
import { AMapUtil } from "../../utils/AMapUtil";
import { RideRouteOverlay } from "../../overlay/RideRouteOverlay";
import { RideRouteDetail, RideRouteParam } from "./RideRouteDetailController";
import { ToastUtil } from "../../utils/ToastUtil";
import { Loading } from "../../utils/Loading";
import { CustomTitleBar } from "../../utils/CustomTitleBar";
import { LinkedList, taskpool } from "@kit.ArkTS";


@Component
export struct RideRouteController {
  private mapView?: MapView;
  private aMap?: AMap;
  @Consume("pageInfos") pageInfos: NavPathStack
  @Consume('isPageHide') @Watch('pageChange') isPageHide: boolean
  private rideRouteParam?: RideRouteParam = new RideRouteParam() // 传输参数必须先初始化
  private mContext: Context = getContext();
  private mRouteSearch?: RouteSearch;
  private mRideRouteResult?: RideRouteResult;
  private mStartPoint: LatLonPoint = new LatLonPoint(39.909187, 116.397463); //起点，39.942295,116.335891
  private mEndPoint: LatLonPoint = new LatLonPoint(39.995576,116.481288); //起点，39.942295,116.335891
  @State
  private mRotueTimeDes: string = ""
  @State isLoading: boolean = false


  private onRouteSearchListener: OnRouteSearchListener = {
    onDriveRouteSearched: (result: DriveRouteResult, errorCode: number): void => {
      // todo 进度条
    },

    onRideRouteSearched: (result: RideRouteResult, errorCode: number): void => {
      this.isLoading = false
      this.aMap?.clear(); // 清理地图上的所有覆盖物
      if (errorCode == AMapException.CODE_AMAP_SUCCESS) {
          const paths = result.getPaths()
        if (result && paths != undefined) {
          if (paths.length > 0) {
            this.mRideRouteResult = result;
            const ridePath = this.mRideRouteResult.getPaths()?.[0];
            if (!ridePath) {
              return;
            }
            const rideRouteOverlay = new RideRouteOverlay(
              this.mContext, this.aMap, ridePath,
              this.mRideRouteResult.getStartPos(),
              this.mRideRouteResult.getTargetPos());

            rideRouteOverlay.removeFromMap();
            rideRouteOverlay.addToMap();
            rideRouteOverlay.zoomToSpan();

            const dis = ridePath.getDistance();
            const dur = ridePath.getDuration();
            const des = AMapUtil.getFriendlyTime(dur) + "(" + AMapUtil.getFriendlyLength(dis) + ")";
            this.mRotueTimeDes = des;

            if (this.rideRouteParam) {
              this.rideRouteParam.distance = this.mRotueTimeDes
              ridePath.getSteps().forEach((item) => {
                this.rideRouteParam?.routeDetailList.push(new RideRouteDetail(item.getAction() ?? "",
                  item.getInstruction() ?? ""))
              })
            }
          } else if (result && !result.getPaths()) {
            ToastUtil.show(this.getUIContext(), '对不起，没有搜索到相关数据！')
          }

        } else {
          ToastUtil.show(this.getUIContext(), '对不起，没有搜索到相关数据！')
        }

      } else {
        ToastUtil.showError(this.getUIContext(), errorCode)
      }

    },

    onWalkRouteSearched: (Result: WalkRouteResult, errorCode: number) => {
    },
    onBusRouteSearched: (result: BusRouteResult, errorCode: number): void => {
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

  build() {
    NavDestination() {
      Loading({ isLoading: this.isLoading })
      this.buildMapDriveRoute();
    }
    .hideTitleBar(true)
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true;
    })
    .onReady((context: NavDestinationContext) => {
      // mock请求数据
    })
  }

  @Builder
  buildMapDriveRoute() {
    Column() {
      CustomTitleBar({title:Constants.MAP_ROUTERIDE_FUNC,onPopClick:()=>{
        this.pageInfos.pop()
      }})
      MapViewComponent({ mapViewName: Constants.MAP_ROUTERIDE_FUNC }).layoutWeight(1)
      Line()
        .width('100%')
        .height(0.5)
        .backgroundColor(Color.Gray)
        .visibility(this.mRotueTimeDes ? Visibility.Visible : Visibility.None)
      Row() {
        Column() {
          Text(`${this.mRotueTimeDes}`)
        }
        .height("100%")
        .width(100)
        .padding({
          left: 30
        })
        .justifyContent(FlexAlign.SpaceAround)
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Column() {
          Row({ space: 8 }) {
            Text("详情")
              .fontColor('#4C90F9')
              .fontSize(14)
            Image($r('app.media.arrow_right_blue'))
              .width(12)
              .height(21)
          }.onClick(() => {
            this.pageInfos.pushPathByName("RideRouteDetailController", this.rideRouteParam)
          })

        }
        .backgroundColor(Color.White)
        .height("100%")
        .width(100)
        .padding({
          right: 10
        })
        .justifyContent(FlexAlign.Center)
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .height(80)
      .visibility(this.mRotueTimeDes ? Visibility.Visible : Visibility.None)
      .width("100%")
    }.width('100%')
    .height('100%')
  }

  private mapViewCreateCallback: MapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
    if (!mapview || this.mapView) {
      return;
    }

    if (mapViewName != Constants.MAP_ROUTERIDE_FUNC) {
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
    if (this.mStartPoint == undefined) {
      ToastUtil.show(this.getUIContext(), "定位中，稍后再试...")
      return
    }
    if (this.mEndPoint == undefined) {
      ToastUtil.show(this.getUIContext(), "终点未设置")
      return
    }
    this.isLoading = true
    this.mRouteSearch = new RouteSearch(this.mContext)
    this.mRouteSearch.setRouteSearchListener(this.onRouteSearchListener)
    const fromAndTo = new FromAndTo(this.mStartPoint, this.mEndPoint);
    const query = new RideRouteQuery(fromAndTo); // 第一个参数表示路径规划的起点和终点，第二个参数表示驾车模式，第三个参数表示途经点，第四个参数表示避让区域，第五个参数表示避让道路
    query.setExtensions(RouteSearch.EXTENSIONS_ALL);
    this.mRouteSearch.calculateRideRouteAsyn(query)
  }

  async aboutToAppear(): Promise<void> {
    MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
    hilog.info(0xff, Constants.MAP_SHOW_FUNC, "aboutToAppear");
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
