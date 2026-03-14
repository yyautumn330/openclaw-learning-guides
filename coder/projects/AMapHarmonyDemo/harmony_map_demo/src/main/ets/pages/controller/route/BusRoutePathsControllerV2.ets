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
  BusPathV2,
  BusRouteQueryV2,
  BusRouteResultV2,
  BusStationItem,
  BusStepV2,
  FromAndTo,
  LatLonPoint,
  OnRouteSearchListenerV2,
  RouteBusLineItem,
  RouteRailwayItem,
  RouteSearch,
  RouteSearchV2,
  TaxiItem,
  TaxiItemV2,
} from "@amap/amap_lbs_search";
import { AMapUtil } from "../../utils/AMapUtil";
import { Loading } from "../../utils/Loading";
import { ToastUtil } from "../../utils/ToastUtil";

@Observed
export class BusRoutePathV2 {
  name: string = ''
  railwayName: string = ''
  busStations: string[] = []
  isExpand: boolean = false
  isRailway: boolean = false
}

export interface BusRouteInfoV2 {
  totalRoute: number
  busRoute: number
  walkRoute: number
  totalTime: number
  busRoutePaths: BusRoutePathV2[]
  walkPaths: number[]
  railwayPaths: RouteRailwayItem
  Taxi: TaxiItemV2
}

export interface BusShowInfoV2 {
  taxiCost: number
  busRouteInfo: BusRouteInfoV2[]
}

export interface BusParamInfoV2 {
  taxiCost: number
  busRouteInfo: BusRouteInfoV2
  busPath: BusPathV2
  startPos: LatLonPoint
  targetPos: LatLonPoint
}

@Component
export struct BusRoutePathsControllerV2 {
  private mapView?: MapView;
  private aMap?: AMap;
  @Consume("pageInfos") pageInfos: NavPathStack
  @Consume('isPageHide') @Watch('pageChange') isPageHide: boolean
  private mContext: Context = getContext();
  private mCurrentCityName: string = '010'; //北京
  private mRouteSearch?: RouteSearchV2;
  private mStartPoint: LatLonPoint = new LatLonPoint(39.942295, 116.335891); //起点，39.942295,116.335891
  private mEndPoint: LatLonPoint = new LatLonPoint(39.995576, 116.481288); //终点，39.995576,116.481288
  private mBusPathList: BusPathV2[] = []
  private mStartPos?: LatLonPoint
  private mTargetPos?: LatLonPoint
  @State busShowInfo: BusShowInfoV2 = {} as BusShowInfoV2
  @State isLoading: boolean = false
  private onRouteSearchListener: OnRouteSearchListenerV2 = {
    onBusRouteSearched: (result: BusRouteResultV2, errorCode: number): void => {
      this.isLoading = false
      this.aMap?.clear(); // 清理地图上的所有覆盖物
      if (errorCode === AMapException.CODE_AMAP_SUCCESS) {
        if (result.getPaths().length < 1) {
          ToastUtil.show(this.getUIContext(), '没有搜索到路径')
          return
        }
        this.busShowInfo.taxiCost = result.getTaxiCost() ?? 0
        this.busShowInfo.busRouteInfo = []
        result.getPaths().forEach((item: BusPathV2, index) => {
          //传给公交路线地图的参数
          this.mBusPathList.push(item)
          this.mStartPos = result.getStartPos()
          this.mTargetPos = result.getTargetPos()

          //存取demo需要展示的数据
          let busRouteInfo = {} as BusRouteInfoV2
          busRouteInfo.walkPaths = []
          busRouteInfo.busRoutePaths = []
          busRouteInfo.totalRoute = item.getDistance()
          busRouteInfo.busRoute = item.getBusDistance() ?? 0
          busRouteInfo.walkRoute = item.getWalkDistance() ?? 0
          busRouteInfo.totalTime = item.getDuration()
          item.getSteps().forEach((item1: BusStepV2) => {
            //步行数据
            if (item1.getWalk()) {
              busRouteInfo.walkPaths.push(item1.getWalk()?.getDistance() ?? 0)
            } else {
              busRouteInfo.walkPaths.push(0)
            }
            //公交数据
            if (item1.getBusLines().length > 0) {
              let busRoutePaths = new BusRoutePathV2()
              item1.getBusLines().forEach((item2: RouteBusLineItem, index2) => {
                if (index2 === 0) {
                  busRoutePaths.name = item2.getBusLineName() ?? ''
                  busRoutePaths.busStations.push(item2.getDepartureBusStation()?.getBusStationName() ?? '')
                  item2.getPassStations().forEach((item3: BusStationItem) => {
                    busRoutePaths.busStations.push(item3.getBusStationName() ?? '')
                  })
                  busRoutePaths.busStations.push(item2.getArrivalBusStation()?.getBusStationName() ?? '')
                } else {
                  busRoutePaths.name += '/' + (item2.getBusLineName() ?? '')
                }
              })
              busRouteInfo.busRoutePaths.push(busRoutePaths)
            } else if (item1.getRailway()) {
              //铁路数据
              let railway = item1.getRailway()
              let startName = railway?.getDeparturestop()?.getName() ?? ''
              let endName = railway?.getArrivalstop()?.getName() ?? ''
              let busRoutePaths = new BusRoutePathV2()
              busRoutePaths.name = railway?.getName() ?? ''
              busRoutePaths.railwayName = railway?.getTrip() + '(' + startName + ' - ' + endName + ')'
              busRoutePaths.busStations.push(startName + ' ' +
              AMapUtil.getRailwayTime(railway?.getDeparturestop()?.getTime() ?? ''))
              busRoutePaths.busStations.push(endName + ' ' +
              AMapUtil.getRailwayTime(railway?.getArrivalstop()?.getTime() ?? ''))
              busRoutePaths.isRailway = true
              busRouteInfo.busRoutePaths.push(busRoutePaths)
            } else {
              //和步行index对应起来后续渲染
              let busRoutePaths = new BusRoutePathV2()
              busRouteInfo.busRoutePaths.push(busRoutePaths)
            }
            //打车信息
            busRouteInfo.Taxi = item1.getTaxi() as TaxiItemV2
          })
          this.busShowInfo.busRouteInfo.push(busRouteInfo)
        })
      } else {
        ToastUtil.showError(this.getUIContext(), errorCode)
      }
    },
    onRideRouteSearched: (): void => {
    },
    onWalkRouteSearched: () => {
    },
    onDriveRouteSearched: () => {
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

  getPathName(busPaths: BusRouteInfoV2) {
    let busName = ''
    busPaths.busRoutePaths.forEach(item => {
      if (item && item.name) {
        if (item.isRailway) {
          busName += item.railwayName + ' > '
        } else {
          let busList = item.name.split('/')
          busList.forEach(item2 => {
            busName += item2.split('(')[0] + '/'
          })
          busName = busName.slice(0, -1)
          busName += ' > '
        }
      }
    })

    // if (busPaths.Taxi) {
    //   busName += '打车到终点'
    // } else {
    //   busName = busName.slice(0, -3)
    // }

    busName = busName.slice(0, -3)

    return busName
  }

  getPathInfo(busRouteInfo: BusRouteInfoV2) {
    let pathInfo = AMapUtil.getFriendlyTime(busRouteInfo.totalTime) + ' | '
      + AMapUtil.getFriendlyLength(busRouteInfo.totalRoute) + ' | ' + '步行' +
    AMapUtil.getFriendlyLength(busRouteInfo.walkRoute)
    return pathInfo
  }

  build() {
    NavDestination() {
      Loading({ isLoading: this.isLoading })
      this.buildMapBusRoute();
    }
    .title(Constants.MAP_ROUTEBUS_FUNC)
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
  buildMapBusRoute() {
    Column() {
      MapViewComponent({ mapViewName: Constants.MAP_ROUTEBUS_FUNC })
        .visibility(Visibility.Hidden)
        .height(1)
      List() {
        ForEach(this.busShowInfo.busRouteInfo, (item: BusRouteInfoV2, index: number) => {
          ListItem() {
            Row() {
              Column() {
                Text(this.getPathName(item))
                  .fontSize(15)
                  .lineHeight(18)
                  .width('100%')
                  .margin({ top: 15, bottom: 20 })

                Text(this.getPathInfo(item))
                  .fontSize(12)
                  .width('100%')
                  .fontColor('#999999')
                  .margin({ bottom: 20 })
              }
              .width('90%')

              Image($r('app.media.arrow_right_blue'))
                .width(10)
            }
            .width('100%')
            .padding({ left: 10, right: 10 })
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .backgroundColor(Color.White)
          .onClick(() => {
            this.pageInfos.pushPath({
              name: 'BusRouteDetailControllerV2', param: {
                busRouteInfo: item,
                taxiCost: this.busShowInfo.taxiCost,
                busPath: this.mBusPathList[index],
                startPos: this.mStartPos,
                targetPos: this.mTargetPos
              } as BusParamInfoV2
            })
          })
        })
      }
      .width('100%')
      .divider({ strokeWidth: 1, color: '#999999' })
      .layoutWeight(1)
      .backgroundColor('#eeeeee')
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
      this.searchRouteResult()
    })

  }

  /**
   * 开始搜索路径规划方案
   */
  public async searchRouteResult() {
    this.isLoading = true
    this.mRouteSearch = new RouteSearchV2(this.mContext)
    this.mRouteSearch.setRouteSearchListener(this.onRouteSearchListener)
    const fromAndTo = new FromAndTo(this.mStartPoint, this.mEndPoint);
    const query = new BusRouteQueryV2(fromAndTo, RouteSearch.BusDefault, this.mCurrentCityName,
      0); // 第一个参数表示路径规划的起点和终点，第二个参数表示公交查询模式，第三个参数表示公交查询城市区号，第四个参数表示是否计算夜班车，0表示不计算
    query.setCityd('010')
    query.setShowFields(0b0010101)
    this.mRouteSearch.calculateBusRouteAsyn(query) // 异步路径规划公交模式查询
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