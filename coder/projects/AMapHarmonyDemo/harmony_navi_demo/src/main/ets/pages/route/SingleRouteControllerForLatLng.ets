import { TextUtils } from "@amap/amap_lbs_common";
import { AMap,
  AMapCarInfo,
  AMapNaviFactory,
  AMapNaviPath,
  BitmapDescriptorFactory,
  CameraUpdate,
  CameraUpdateFactory,
  CancelableCallback,
  IAMapCalcRouteResult,
  IAMapNavi,
  INaviInfo,
  LatLng,
  LatLonPoint,
  MapView, MapViewComponent, MapViewCreateCallback,
  MapViewManager,
  MarkerOptions,
  NaviLatLng,
  PathPlanningStrategy,
  RouteOverlay } from "@amap/amap_lbs_navi";
import { ArrayList, HashMap,JSON } from "@kit.ArkTS";
import { promptAction } from "@kit.ArkUI";

/**
 * 驾车路线规划(单路径)-根据经纬度
 */
@Component
export struct SingleRouteControllerForLatLng {
  uiContext: UIContext = this.getUIContext()
  context: Context | undefined = this.getUIContext().getHostContext()
  @State private mapLocked: boolean = false;
  @State private mapFixedHeightVp: number = 0;
  private mapView? : MapView;
  private aMap? : AMap;
  @Consume('pageInfos') pageInfos: NavPathStack;
  @Consume('isPageHide') @Watch('pageChange') isPageHide: boolean

  naviInstance?: IAMapNavi;

  private startLatlng: NaviLatLng | undefined = undefined;
  private endLatlng: NaviLatLng | undefined = undefined;
  private startList: ArrayList<NaviLatLng> = new ArrayList<NaviLatLng>();
  /**
   * 途径点坐标集合
   */
  private wayList: ArrayList<NaviLatLng> | null  = null;
  /**
   * 终点坐标集合［建议就一个终点］
   */
  private endList: ArrayList<NaviLatLng> = new ArrayList<NaviLatLng>();
  /**
   * 保存当前算好的路线
   */
  private routeOverlays: ArrayList<HashMap<number, RouteOverlay>> = new ArrayList<HashMap<number, RouteOverlay>>();

  /**
   * 路线计算成功标志位
   */
  private calculateSuccess: boolean = false;

  //当前选中的策略值
  @State currentSelectStrategyValue: number = 0;

  //车牌号
  carNumber: string = "京KAD057";
  carInfo: AMapCarInfo | null = null;

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

    if(this.carNumber.length > 0){
      this.carInfo = new AMapCarInfo();
      //设置车牌
      this.carInfo.mCarNumber = this.carNumber;

      //设置车辆类型， 0-燃油客车，1-燃油货车，2-纯电动客车，3-纯电动货车，4-插电式混动汽车，5-插电式混动货车，11-摩托车
      this.carInfo.mCarType = 1;
      // //设置货车的轴数，mCarType = 1时候生效，取值[0-255]，默认为2
      // this.carInfo.mVehicleAxis = 2;
      // //设置货车的高度，单位：米，mCarType = 1时候生效，取值[0-25.5] 如:1.8，1.5等等。
      // this.carInfo.mVehicleHeight = 2;
      // //设置货车的最大宽度，单位：米，mCarType = 1时候生效，取值[0-25.5] 如:1.8，1.5等等。
      // this.carInfo.mVehicleWidth = 2;
      // //设置货车的核定载重，单位：吨，mCarType = 1时候生效，取值[0-6553.5]
      // this.carInfo.mVehicleWeight = 2;
      // //设置货车的最大长度，单位：米，mCarType = 1时候生效，取值[0-25] 如:1.8，1.5等等，默认6米
      // this.carInfo.mVehicleLength = 6;
      // //设置货车大小， 1-微型货车 2-轻型/小型货车 3-中型货车 4-重型货车
      // this.carInfo.mVehicleSize = 2;
      // //设置货车的总重，即车重+核定载重，单位：吨，mCarType = 1时候生效，取值[0-6553.5]
      // this.carInfo.mVehicleLoad = 4.5;
      // //设置是否躲避车辆限行， true代表躲避车辆限行，false代表不躲避车辆限行。默认为true
      // this.carInfo.isRestriction = true;
      // //设置货车重量是否参与算路， true-重量会参与算路；false-重量不会参与算路。默认为false
      // this.carInfo.mVehicleLoadSwitch = true;

      this.naviInstance!.setCarInfo(this.carInfo);
    }

    //途经点
    // this.wayList = new ArrayList<NaviLatLng>();
    // this.wayList.add(new NaviLatLng(40.071562,116.465318));
    // this.wayList.add(new NaviLatLng(40.04449,116.31321));

    // this.naviInstance!.calculateDriveRoute(this.startList, this.endList, this.wayList, this.strategy);
    this.naviInstance!.calculateDriveRoute(this.startList, this.endList, this.wayList, this.currentSelectStrategyValue);
  }

  private mapViewCreateCallback: MapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
    if (!mapview || this.mapView) {
      return;
    }

    if (mapViewName != "SingleRouteForLatLng") {
      return;
    }

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
      let latLngBounds = path.getBoundsForPath();
      let cameraUpdate: CameraUpdate = CameraUpdateFactory.newLatLngBoundsRect(latLngBounds!, vp2px(100),vp2px(100),vp2px(100),vp2px(100));
      this.aMap?.animateCamera(cameraUpdate, new CancelableCallback(
        () => {},
        () => {}
      ), 1000)

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
    this.startList.clear();
    this.endList.clear();

    this.aMap?.clear();

    if(this.startLatlng){
      this.startList.add(this.startLatlng);
      this.aMap?.addMarker(new MarkerOptions().setPosition(this.convertToLatLng(this.startLatlng)).setIcon(BitmapDescriptorFactory.fromRawfilePathSync(this.context!, "start.png")!))
    }
    if(this.endLatlng){
      this.endList.add(this.endLatlng);
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
    // if(!this.chooseRouteSuccess){
    //   promptAction.showToast({message: "请选择路径"})
    //   return;
    // }
    const params: object = new Object({
      "gps": isGPS,
      "strategy": this.currentSelectStrategyValue,
      "carInfo": this.carInfo
    });
    this.pageInfos.pushPathByName('RouteNavi', params);
  }

  //顶部视图
  @Builder
  buildTopView() {
    Column(){
      Flex({
        direction: FlexDirection.Row,
        wrap: FlexWrap.Wrap
      }){
        this.buildCheckItemView(0, "速度优先")
        this.buildCheckItemView(1, "费用优先")
        this.buildCheckItemView(2, "距离优先")
        this.buildCheckItemView(3, "普通路优先")
        this.buildCheckItemView(4, "时间优先")
        this.buildCheckItemView(5, "速度优先&费用优先&距离优先")
        this.buildCheckItemView(6, "不走高速")
        this.buildCheckItemView(7, "不走高速&躲避收费")
        this.buildCheckItemView(8, "躲避收费&躲避拥堵")
        this.buildCheckItemView(9, "不走高速&躲避收费&躲避拥堵")
      }
      .width("100%")

      Row({space: 5}){
        TextInput({
          placeholder: '车牌',
          text: $$this.carNumber
        })
          .width(115)
          .height(30)
          .padding(0)
          .borderRadius(0)

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
    MapViewComponent({ mapViewName: "SingleRouteForLatLng", soName: 'AMapOpenNaviJNI' })
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
    MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
    this.mapLocked = false;
    this.mapFixedHeightVp = 0;
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
    .title("驾车路线规划(单路径)-根据经纬度")
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

