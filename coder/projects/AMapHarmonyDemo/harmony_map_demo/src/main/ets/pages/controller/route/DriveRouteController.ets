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
import { DriveRouteParam, RouteDetail } from "./DriveRouteDetailController";
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
  WalkRouteResult
} from "@amap/amap_lbs_search";
import { DrivingRouteOverlay } from "../../overlay/DrivingRouteOverlay";
import { AMapUtil } from "../../utils/AMapUtil";
import { ArrayList } from "@kit.ArkTS";
import { ToastUtil } from "../../utils/ToastUtil";


@Component
export struct DriveRouteController {
  private mapView?: MapView;
  private aMap?: AMap;
  @Consume("pageInfos") pageInfos: NavPathStack
  @Consume('isPageHide') @Watch('pageChange') isPageHide: boolean
  private driveRouteParam?: DriveRouteParam = new DriveRouteParam() // 传输参数必须先初始化
  private mContext: Context = getContext();
  private mRouteSearch?: RouteSearch;
  private mDriveRouteResult?: DriveRouteResult;
  private mStartPoint: LatLonPoint = new LatLonPoint(39.942295, 116.335891); //起点，39.942295,116.335891
  private mEndPoint: LatLonPoint = new LatLonPoint(39.995576, 116.481288); //终点，39.995576,116.481288
  private readonly ROUTE_TYPE_DRIVE = 2;
  @State
  private mRotueTimeDes: string = ""
  @State
  private mRouteDetailDes: string = ""

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

  private onRouteSearchListener: OnRouteSearchListener = {
    onDriveRouteSearched: (result: DriveRouteResult | undefined, errorCode: number): void => {
      if (!this.mStartPoint) {
        ToastUtil.show(this.getUIContext(), "定位中，稍后再试...")
        return
      }
      if (!this.mEndPoint) {
        ToastUtil.show(this.getUIContext(), "终点未设置")
        return
      }
      // todo 进度条
      // dissmissProgressDialog();
      this.aMap?.clear(); // 清理地图上的所有覆盖物
      if (errorCode === AMapException.CODE_AMAP_SUCCESS) {
        const paths = result?.getPaths()
        if (result && paths) {
          if (paths.length > 0) {
            this.mDriveRouteResult = result;
            const drivePath = this.mDriveRouteResult.getPaths()?.[0];
            if (!drivePath) {
              return;
            }
            const drivingRouteOverlay = new DrivingRouteOverlay(
              this.mContext, this.aMap, drivePath,
              this.mDriveRouteResult.getStartPos(),
              this.mDriveRouteResult.getTargetPos(), new ArrayList());
            drivingRouteOverlay.setNodeIconVisibility(false); //设置节点marker是否显示
            drivingRouteOverlay.setIsColorfulline(true); //是否用颜色展示交通拥堵情况，默认true
            drivingRouteOverlay.removeFromMap();
            drivingRouteOverlay.addToMap();
            drivingRouteOverlay.zoomToSpan();
            const dis = drivePath.getDistance();
            const dur = drivePath.getDuration();
            const des = AMapUtil.getFriendlyTime(dur) + "(" + AMapUtil.getFriendlyLength(dis) + ")";
            this.mRotueTimeDes = des;
            const taxiCost = Math.floor(this.mDriveRouteResult.getTaxiCost())
            this.mRouteDetailDes = "打车约" + taxiCost + "元";
            if (this.driveRouteParam) {
              this.driveRouteParam.distance = this.mRotueTimeDes
              this.driveRouteParam.time = this.mRouteDetailDes
              this.driveRouteParam.routeName = Constants.MAP_ROUTEDRIVE_DETAIL_FUNC
              drivePath.getSteps().forEach((item) => {
                this.driveRouteParam?.routeDetailList.push(new RouteDetail(item.getAction() ?? "",
                  item.getInstruction() ?? ""))
              })
            }
          } else if (result && result.getPaths()) {
            ToastUtil.show(this.getUIContext(), "对不起，没有搜索到相关数据！");
          }
        } else {
          ToastUtil.show(this.getUIContext(), "对不起，没有搜索到相关数据！");
        }
      } else {
        ToastUtil.showError(this.getUIContext(), errorCode);
      }
    },
    onRideRouteSearched: (result: RideRouteResult, errorCode: number): void => {
    },
    onWalkRouteSearched: (walkRouteResult: WalkRouteResult, errorCode: number) => {
    },
    onBusRouteSearched: (result: BusRouteResult, errorCode: number): void => {
    }
  }

  build() {
    NavDestination() {
      this.buildMapDriveRoute();
    }
    .title(Constants.MAP_ROUTEDRIVE_FUNC)
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
      MapViewComponent({ mapViewName: Constants.MAP_ROUTEDRIVE_FUNC }).layoutWeight(1)
      Row() {
        Column() {
          Text(`${this.mRotueTimeDes}`)
          Text(`${this.mRouteDetailDes}`)
        }
        .backgroundColor(Color.Pink)
        .height("100%")
        .width(100)
        .padding({
          left: 30
        })
        .justifyContent(FlexAlign.SpaceAround)
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Column() {
          Text("详情").onClick(() => {
            this.pageInfos.pushPathByName("DriveRouteDetailController", this.driveRouteParam)
          })
        }
        .backgroundColor(Color.Pink)
        .height("100%")
        .width(100)
        .padding({
          right: 10
        })
        .justifyContent(FlexAlign.Center)
      }.justifyContent(FlexAlign.SpaceBetween)
      .height(80)
      .width("100%")
    }.width('100%')
    .height('100%')
  }

  private mapViewCreateCallback: MapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
    if (!mapview || this.mapView) {
      return;
    }

    if (mapViewName != Constants.MAP_ROUTEDRIVE_FUNC) {
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
    const query = new DriveRouteQuery(fromAndTo, RouteSearch.DrivingDefault, undefined,
      undefined, ""); // 第一个参数表示路径规划的起点和终点，第二个参数表示驾车模式，第三个参数表示途经点，第四个参数表示避让区域，第五个参数表示避让道路
    query.setExtensions(RouteSearch.EXTENSIONS_ALL);
    // this.mRouteSearch.calculateDriveRouteAsyn(query); // 异步路径规划驾车模式查询
    const driveRoute: DriveRouteResult = await this.mRouteSearch.calculateDriveRoute(query) ?? new DriveRouteResult()
    this.onRouteSearchListener.onDriveRouteSearched(driveRoute, AMapException.CODE_AMAP_SUCCESS); // 同步路径规划驾车模式查询
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