import {
  AMap,
  AMapOptions,
  BitmapDescriptor,
  BitmapDescriptorFactory,
  LatLng,
  MapView,
  MapViewComponent,
  MapViewCreateCallback,
  MapViewManager,
  MarkerOptions
} from "@amap/amap_lbs_map3d";
import { Constants } from "../../utils/Constants"
import { hilog } from "@kit.PerformanceAnalysisKit";
import {
  FromAndTo,
  LatLonPoint,
  OnTruckRouteSearchListener,
  RouteSearch,
  TruckPath,
  TruckRouteQuery,
  TruckRouteRestult,
} from "@amap/amap_lbs_search";

import { ArrayList } from "@kit.ArkTS";
import { TruckRouteColorfulOverLay } from "../../overlay/TruckRouteColorfulOverLay";
import { ToastUtil } from "../../utils/ToastUtil";
import { AMapUtil } from "../../utils/AMapUtil";
import { TruckRouteDetail, TruckRouteParam } from "./TruckRouteDetailController";
import { Loading } from "../../utils/Loading";
import { CustomTitleBar } from "../../utils/CustomTitleBar";

@Component

export struct TruckRouteController {

  private mapView?: MapView;
  private aMap?: AMap;
  @Consume("pageInfos") pageInfos: NavPathStack
  @Consume('isPageHide') @Watch('pageChange') isPageHide: boolean
  private truckRouteParam?: TruckRouteParam = new TruckRouteParam()// 传输参数必须先初始化
  private mContext: Context = getContext();
  private mRouteSearch?: RouteSearch;
  private truckRouteResult?: TruckRouteRestult;
  private mStartPoint: LatLonPoint =  new LatLonPoint(39.902896,116.42792)//起点，39.942295,116.335891
  private mEndPoint: LatLonPoint = new LatLonPoint(39.894914,116.322062) //终点，39.995576,116.481288
  @State
  private mRotueTimeDes: string = ""
  @State
  private mRouteDetailDes: string = ""

  @State isLoading: boolean = false

  private  onTruckRouteSearchListener:OnTruckRouteSearchListener = {

    onTruckRouteSearched:(result: TruckRouteRestult, errorCode: number): void => {
      /**
       * 限行结果
       * 0，未知（未输入完整/正确车牌号信息时候显示）
       * 1，已规避限行
       * 2，起点限行
       * 3，途径点在限行区域内（设置途径点才出现此报错）
       * 4，途径限行区域
       * 5，终点限行
       */
        this.isLoading = false
        if (errorCode === 1000) {
          if (result && result.getPaths() && result.getPaths().length>0) {
            this.truckRouteResult = result
            const path = this.truckRouteResult.getPaths()[0] as TruckPath
            if (!path) {
               return
            }
            this.aMap?.clear()// 清理地图上的所有覆盖物

            let  drivingRouteOverlay = new TruckRouteColorfulOverLay(this.mContext,this.aMap,path,this.truckRouteResult.getStartPos(),this.truckRouteResult.getTargetPos(),undefined)
            drivingRouteOverlay.removeFromMap()
            drivingRouteOverlay.setIsColorfulline(true)
            drivingRouteOverlay.addToMap()
            drivingRouteOverlay.zoomToSpan()

            const dis = path.getDistance()
            const dur = path.getDuration()
            const des = AMapUtil.getFriendlyTime(dur) + "(" + AMapUtil.getFriendlyLength(dis) + ")"
            this.mRotueTimeDes = des

            if(this.truckRouteParam){
              this.truckRouteParam.distance = this.mRotueTimeDes
              path.getSteps().forEach((item)=>{
                this.truckRouteParam?.routeDetailList.push(new TruckRouteDetail(item.getAction() ?? "",item.getInstruction() ?? ""))
              })
            }

          }else {
            ToastUtil.show(this.getUIContext(),'对不起，没有搜索到相关数据！')
          }
          
        }else if (errorCode === 1904){
          ToastUtil.show(this.getUIContext(),'搜索失败,请检查网络连接！')
        }else if (errorCode === 1002){
          ToastUtil.show(this.getUIContext(),'key验证无效！')
        }else {
          ToastUtil.show(this.getUIContext(),'errorCode='+errorCode)
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

  setfromandtoMarker(){
    this.aMap?.addMarker(new MarkerOptions()
      .setPosition(AMapUtil.convertToLatLng(this.mStartPoint)).setIcon(BitmapDescriptorFactory.fromRawfilePathSync(this.mContext,"amap_start.png") as BitmapDescriptor)
      .setTitle("\u8D77\u70B9"));
     this.aMap?.addMarker((new MarkerOptions()).setPosition(AMapUtil.convertToLatLng(this.mEndPoint))
      .setIcon(BitmapDescriptorFactory.fromRawfilePathSync(this.mContext,"amap_end.png") as BitmapDescriptor).setTitle("\u7EC8\u70B9"));
  }

  build() {
    NavDestination() {
      Loading({ isLoading: this.isLoading })
      this.buildMapDriveRoute();
    }
    .hideTitleBar(true)
    // .title(Constants.MAP_ROUTETRUCK_FUNC)
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
      CustomTitleBar({title:Constants.MAP_ROUTETRUCK_FUNC,onPopClick:()=>{
        this.pageInfos.pop()
      }})
      MapViewComponent({ mapViewName: Constants.MAP_ROUTETRUCK_FUNC }).layoutWeight(1)
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
            this.pageInfos.pushPathByName("TruckRouteDetailController", this.truckRouteParam)
          })
        }
        .backgroundColor(Color.White)
        .height("100%")
        .width(100)
        .padding({
          right: 10
        })
        .justifyContent(FlexAlign.Center)
      }.justifyContent(FlexAlign.SpaceBetween)
      .height(80)
      .visibility(this.mRotueTimeDes ? Visibility.Visible : Visibility.None)
      .width("100%")
    }
    .width('100%')
    .height('100%')
  }

  private mapViewCreateCallback: MapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
    if (!mapview || this.mapView) {
      return;
    }

    if (mapViewName != Constants.MAP_ROUTETRUCK_FUNC) {
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
      this.setfromandtoMarker()
      this.searchRouteResult()
    })

  }

  /**
   * 开始搜索路径规划方案
   */
  public async searchRouteResult(){
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
    this.mRouteSearch.setOnTruckRouteSearchListener(this.onTruckRouteSearchListener)
    const fromAndTo = new FromAndTo(this.mStartPoint, this.mEndPoint);
    //设置车牌
    fromAndTo.setPlateNumber("A000XXX");
    fromAndTo.setPlateProvince("京");
    const query = new TruckRouteQuery(fromAndTo,RouteSearch.TRUCK_AVOID_CONGESTION,null,RouteSearch.TRUCK_SIZE_HEAVY); // 第一个参数表示路径规划的起点和终点，第二个参数表示驾车模式，第三个参数表示途经点，第四个参数表示避让区域，第五个参数表示避让道路
    //设置车辆信息
    query.setTruckAxis(6)
    query.setTruckHeight(3.9)
    query.setTruckWidth(3)
    query.setTruckLoad(45)
    query.setTruckWeight(50)

    this.mRouteSearch.calculateTruckRouteAsyn(query)
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