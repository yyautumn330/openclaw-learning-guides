import {
  AMap,
  AMapNaviFactory,
  AMapNaviPath,
  AmapNaviType,
  AMapTravelInfo,
  BitmapDescriptorFactory,
  CameraUpdate,
  CameraUpdateFactory,
  CancelableCallback,
  IAMapCalcRouteResult,
  IAMapNavi,
  INaviInfo,
  LatLng,
  LatLonPoint,
  MapView,
  MapViewComponent,
  MapViewCreateCallback,
  MapViewManager,
  MarkerOptions,
  NaviLatLng,
  NaviPoi,
  PathPlanningStrategy,
  RouteOverlay,
  TransportType
} from '@amap/amap_lbs_navi';
import { ArrayList, HashMap, JSON } from '@kit.ArkTS';
import { promptAction } from '@kit.ArkUI';

/**
 * 骑步行路径路线规划(单路径)
 */
@Component
export struct WalkRideRouteControllerForLatLng {
  uiContext: UIContext = this.getUIContext()
  context: Context | undefined = this.getUIContext().getHostContext()
  @State private mapLocked: boolean = false;
  @State private mapFixedHeightVp: number = 0;
  private mapView? : MapView;
  private aMap? : AMap;
  @Consume('pageInfos') pageInfos: NavPathStack;
  @Consume('isPageHide') @Watch('pageChange') isPageHide: boolean

  naviInstance?: IAMapNavi;

  // 如果是电动车或者是骑行修改为对应的
  private transportType: number = TransportType.Walk
  private mType: number = AmapNaviType.Walk

  private startLatlng: NaviLatLng | undefined = undefined;
  private endLatlng: NaviLatLng | undefined = undefined;
  /**
   * 途径点坐标集合
   */
  private wayList: ArrayList<NaviLatLng> | null  = null;

  /**
   * 保存当前算好的路线
   */
  private routeOverlays: ArrayList<HashMap<number, RouteOverlay>> = new ArrayList<HashMap<number, RouteOverlay>>();

  /**
   * 路线计算成功标志位
   */
  private calculateSuccess: boolean = false;

  //当前选中的策略值
  @State currentSelectStrategyValue: number = PathPlanningStrategy.TRAVEL_SINGLE_DEFAULT;


  pageChange(changedPropertyName: string) {
    if (this.isPageHide === true) {
      this.onPageHide()
    } else {
      this.onPageShow()
    }
  }

  onPageShow(): void {
    this.mapView?.onResume();
  }

  onPageHide(): void {
    this.mapView?.onPause();
  }

  //开始算路
  startCalculate(){
    this.calculateSuccess = false;
    this.clearRoute();

    if(!this.endLatlng){
      promptAction.showToast({message: "请选择终点"});
      return;
    }

    // const start = new NaviPoi("北京首都机场", new NaviLatLng(40.080525,116.603039), "B000A28DAE");
    const start = new NaviPoi("善各庄地铁", new NaviLatLng(40.027021,116.478391), null);
    //途经点
    const poiList = new ArrayList<NaviPoi>();
    // poiList.add(new NaviPoi("善各庄地铁", new NaviLatLng(40.027021,116.478391), null));
    // poiList.add(new NaviPoi("故宫", new NaviLatLng(39.918058,116.397026), "B000A8UIN8"));
    // poiList.add(new NaviPoi("北京南站", new NaviLatLng(39.867111,116.378099), null));
    // poiList.add(new NaviPoi("北京丰台站", new NaviLatLng(39.85292,116.301781), null));
    //终点
    // const end = new NaviPoi("北京大学", new NaviLatLng(39.992873,116.310918), "B000A816R6");
    const end = new NaviPoi("天安门广场", new NaviLatLng(39.907033, 116.39754), null);


    this.wayList = new ArrayList<NaviLatLng>()
    this.wayList.add(new NaviLatLng(39.918058,116.397026));
    this.wayList.add(new NaviLatLng(39.867111,116.378099));
    this.wayList.add(new NaviLatLng(40.027021,116.478391));
    this.wayList.add(new NaviLatLng(39.907033, 116.39754));




    this.naviInstance!.setTravelInfo(new AMapTravelInfo(this.transportType));


    if(this.startLatlng){
      if(this.transportType === TransportType.Walk) {
        this.naviInstance!.calculateWalkRouteLatLng(this.startLatlng, this.endLatlng, this.wayList);
        //poi
        // this.naviInstance!.calculateWalkRoutePoi(start, end, this.currentSelectStrategyValue ,poiList);
      } else if (this.transportType === TransportType.Ride) {
        this.naviInstance!.calculateRideRouteLatLng(this.startLatlng, this.endLatlng, this.wayList);
        //poi
        //this.naviInstance!.calculateRideRoutePoi(start, end, this.currentSelectStrategyValue ,poiList);
      } else if (this.transportType === TransportType.EleBike) {
        this.naviInstance!.calculateEleBikeRouteLatLng(this.startLatlng, this.endLatlng, this.wayList);
        //poi
        //this.naviInstance!.calculateEleBikeRoutePoi(start, end, this.currentSelectStrategyValue ,poiList);
      }
    } else {
      if(this.transportType === TransportType.Walk) {
        this.naviInstance!.calculateWalkRouteLatLngWithoutStart(this.endLatlng, this.wayList);
      } else if (this.transportType === TransportType.Ride) {
        this.naviInstance!.calculateRideRouteLatLngWithoutStart(this.endLatlng, this.wayList);
      } else if (this.transportType === TransportType.EleBike) {
        this.naviInstance!.calculateEleBikeRouteLatLngWithoutStart(this.endLatlng, this.wayList);
      }
    }
  }

  private mapViewCreateCallback: MapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
    if (!mapview || this.mapView) return;

    this.mapView = mapview;

    this.mapView.onCreate();
    this.mapView.getMapAsync((map) => {
      this.aMap = map;
      this.aMap.getUiSettings()?.setZoomControlsEnabled(true);
    })

  }

  private drawRoutes(routeId: number, path: AMapNaviPath) {
    this.aMap!.moveCamera(CameraUpdateFactory.changeTilt(0));
    const routeOverLay = new RouteOverlay(this.context!, this.aMap!, path);
    setTimeout(async () => {
      await routeOverLay.build();
      //设置是否显示路况，不显示则为蓝色线路
      routeOverLay.setTrafficLine(false);
      //是否显示红绿灯
      routeOverLay.setIsDrawLight(true);
      routeOverLay.addToMap();
      routeOverLay.zoomToSpan();

      const data: HashMap<number, RouteOverlay> = new HashMap();
      data.set(routeId, routeOverLay);
      this.routeOverlays.add(data);
    })
  }

  /**
   * 清除当前地图上算好的路线
   */
  private clearRoute() {
    for (let i = 0; i < this.routeOverlays.length; i++) {
      const routeOverlayMap = this.routeOverlays[i];
      if(routeOverlayMap.length === 0) continue;
      const key = routeOverlayMap.keys().next().value as number;
      const routeOverlay = routeOverlayMap.get(key) as RouteOverlay;
      routeOverlay.removeFromMap();
    }
  }

  convertToLatLng(point: NaviLatLng): LatLng {
    return new LatLng(point.getLatitude(), point.getLongitude());
  }

  //设置起点和终点
  setupStartEndPoint(){
    this.aMap?.clear();
    if(this.startLatlng){
      this.aMap?.addMarker(new MarkerOptions().setPosition(this.convertToLatLng(this.startLatlng)).setIcon(BitmapDescriptorFactory.fromRawfilePathSync(this.context!, "start.png")!))
    }
    if(this.endLatlng){
      this.aMap?.addMarker(new MarkerOptions().setPosition(this.convertToLatLng(this.endLatlng)).setIcon(BitmapDescriptorFactory.fromRawfilePathSync(this.context!, "end.png")!))
    }

  }


  //单选框视图
  @Builder
  buildCheckItemView(value: number, title: string){
    Row(){
      Radio({value: `${value}`, group: 'Single'}).checked(this.currentSelectStrategyValue === value)
        .onChange((isChecked: boolean) => {
          if(isChecked){
            this.currentSelectStrategyValue = value;
          }
        })
      Text(title)
    }
    .height(30)
  }

  @Builder
  buildButtonItemView(title: string, onClick: () => void){
    Row(){
      Text(title)
    }
    .height(30)
    .padding({left: 3, right: 3})
    .backgroundColor("#C0C0C0")
    .onClick(onClick)
  }

  jump2RouteNavi(isGPS: boolean){
    if(!this.calculateSuccess){
      promptAction.showToast({message: "请先算路"})
      return;
    }
    const params: object = new Object({
      "gps": isGPS,
      "strategy": this.currentSelectStrategyValue,
      "carInfo": undefined,
      "mType" : this.mType
    });
    this.pageInfos.pushPathByName('RouteNavi', params);
  }

  //顶部视图
  @Builder
  buildTopView() {
    Column(){
      Row({space: 5}){
        this.buildButtonItemView("选起点", () => {
          this.pageInfos.pushPathByName("SearchPoi", null,  (popInfo: PopInfo) => {
            const resultObj = popInfo.result as object;
            if(JSON.has(resultObj, "position")){
              const point = resultObj["position"] as LatLonPoint;
              this.startLatlng = new NaviLatLng(point.getLatitude(), point.getLongitude());

              //设置起点和终点
              this.setupStartEndPoint();
            }
          })
        })
        this.buildButtonItemView("选终点", () => {
          this.pageInfos.pushPathByName("SearchPoi", null,  (popInfo: PopInfo) => {
            const resultObj = popInfo.result as object;
            if(JSON.has(resultObj, "position")){
              const point = resultObj["position"] as LatLonPoint;
              this.endLatlng = new NaviLatLng(point.getLatitude(), point.getLongitude());

              //设置起点和终点
              this.setupStartEndPoint();
            }
          })
        })
        this.buildButtonItemView("开始算路", () => {
          this.startCalculate();
        })
      }
      .justifyContent(FlexAlign.Start)
      .height(40)

      Row({space: 5}){
        this.buildButtonItemView("开始导航", () => {
          this.jump2RouteNavi(true);
        })
        this.buildButtonItemView("模拟导航", () => {
          this.jump2RouteNavi(false);
        })
      }
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)
      .height(40)

    }
    .padding(5)
    .width("100%")
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
    .backgroundColor("#F0F0F0")
  }

  //显示地图
  @Builder
  buildMapShow() {
    MapViewComponent({ mapViewName: "WalkRideRouteControllerForLatLng", soName: 'AMapOpenNaviJNI' })
      .width('100%')
      .height(this.mapLocked ? this.mapFixedHeightVp : '100%')
      .layoutWeight(this.mapLocked ? 0 : 1)
      .onAreaChange((oldValue: Area, newValue: Area) => {
        const h = newValue.height as number; // vp
        if (!this.mapLocked && h > 0) {
          this.mapFixedHeightVp = h;
          this.mapLocked = true;
        }
      })
  }

  aboutToAppear(): void {
    this.mapLocked = false;
    this.mapFixedHeightVp = 0;
    MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);

    const appkey = '此处替换官网申请的Key';
    this.naviInstance =  AMapNaviFactory.getAMapNaviInstance(getContext().getApplicationContext(), appkey)

    this.naviInstance?.addAMapNaviListener({

      onNaviInfoUpdate: (naviInfo: INaviInfo) => {
      },

      onCalculateRouteSuccess: (routeResult: IAMapCalcRouteResult | null) => {
        //清空上次计算的路径列表。
        this.routeOverlays.clear();
        this.aMap?.clear();

        this.calculateSuccess = false;

        if(routeResult !== null && routeResult.routeId){
          const routeIds: Int32Array = routeResult.routeId;

          const paths: HashMap<number, AMapNaviPath> | null = this.naviInstance!.getNaviPaths();
          if(paths === null || paths.length === 0){
            promptAction.showToast({message: "未获取到路径"});
            return;
          }
          for (let i = 0; i < routeIds.length; i++) {
            const path = paths.get(routeIds[i]);
            if (path !== null) {
              this.drawRoutes(routeIds[i], path);
            }
          }
          this.calculateSuccess = true;
        }
      },
      onCalculateRouteFailureForResult: (routeResult: IAMapCalcRouteResult| null) => {
        promptAction.showToast({message: routeResult?.errorDetail})
        this.calculateSuccess = false;
      }
    })
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

    if (this.naviInstance) {
      // 移除外部监听
      this.naviInstance.removeAMapNaviListener({})

      // 销毁导航单例对象
      AMapNaviFactory.destroyAMapNaviInstance()

      this.naviInstance = undefined
    }
  }

  build() {
    NavDestination() {
      this.buildTopView();
      this.buildMapShow();
    }
    .title("骑步行路径规划(单路径)-根据经纬度")
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true;
    })
    .onWillDisappear(() => {
      if (this.mapViewCreateCallback) {
        MapViewManager.getInstance().unregisterMapViewCreatedCallback(this.mapViewCreateCallback);
      }

      if (this.mapView) {
        this.mapView.onDestroy();
        this.mapView = undefined;
        this.aMap = undefined;
      }

      if (this.naviInstance) {
        // 移除外部监听
        this.naviInstance.removeAMapNaviListener({})

        // 销毁导航单例对象
        AMapNaviFactory.destroyAMapNaviInstance()

        this.naviInstance = undefined
      }
    })

  }
}

