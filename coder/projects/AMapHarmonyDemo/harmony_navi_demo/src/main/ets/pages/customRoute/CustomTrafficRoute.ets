import {
  AMapNaviComponent,
  AMapNaviFactory,
  AmapNaviType,
  AMapNaviViewOptions,
  CoreEyrieColor,
  CoreRouteDashedLineColor,
  CoreRoutePassLineColor,
  CoreRouteTrafficStatusColor,
  IAMapCalcRouteResult,
  IAMapNavi,
  INaviInfo,
  INaviLatLng,
  INaviPoi,
  NaviType,
  RouteOverlayOptions} from '@amap/amap_lbs_navi'
import { LogUtil } from '@amap/amap_lbs_common';
import { NaviDemoLocationManager } from '../../utils/NaviDemoLocationManager';
import { MockLocationManager } from '../../mock/manger/MockLocationManager';
import { ArrayList } from '@kit.ArkTS';
// 自定义路线: 路线宽度、不同路况的路线颜色、走过路线颜色、车标显隐、marker显隐
@Component
export struct CustomTrafficRoute {
  wayPoints: ArrayList<INaviPoi> = new ArrayList()
  @Consume('pageInfos') pageInfos: NavPathStack;
  options: AMapNaviViewOptions = new AMapNaviViewOptions()
  naviInstance?: IAMapNavi

  @Builder
  titleBuilder() {
    Button('点击修改')
      .width("100%")
      .height('100%')
      .type(ButtonType.Normal)
      .backgroundColor('orange')
  }

  @Builder
  bottomCustomComponentBuilder() {
    Text('底部自定义组件')
      .width('100%')
      .height(60)
      .textAlign(TextAlign.Center)
      .backgroundColor(Color.Orange)
  }
  //生命周期方法
  aboutToAppear(): void {
    this.initTestData()
    this.initNavi()
    this.initViewOption()
  }

  initViewOption() {
    this.setCustomRouteColor()
  }

  setCustomRouteColor() {
    if (this.options) {
      let routeOverlayOption: RouteOverlayOptions = this.options.getRouteOverlayOptions()
      // 虚线颜色
      let dashedLineColor: CoreRouteDashedLineColor = new CoreRouteDashedLineColor()
      dashedLineColor.highlightDay = new CoreEyrieColor(0xFFFF0000,0xFF000000)
      dashedLineColor.backupDay = new CoreEyrieColor(0x1AFFFF00,0x1A000000)
      dashedLineColor.highlightNight = new CoreEyrieColor(0xFFFF0000,0xFF000000)
      dashedLineColor.backupNight = new CoreEyrieColor(0x1AFFFF00,0x1A000000)
      // 设置虚线颜色
      routeOverlayOption.setDashedLineColor(dashedLineColor)

      // 路过置灰颜色
      let routeGreyColor: CoreRoutePassLineColor = new CoreRoutePassLineColor()
      routeGreyColor.colorDay = new CoreEyrieColor(0xFF00FFFF,0xFF000000)
      routeGreyColor.colorNight = new CoreEyrieColor(0xFF00FFFF,0xFF000000)
      //设置置灰颜色
      routeOverlayOption.setRouteGreyColor(routeGreyColor)

      // 不同路况下的路线颜色(畅通)
      let routeColor = new ArrayList<CoreRouteTrafficStatusColor>()
      let openColor = new CoreRouteTrafficStatusColor()
      openColor.status = CoreRouteTrafficStatusColor.TRAFFIC_STATUS_Open
      openColor.highlightDay = new CoreEyrieColor(0xFF000000,0xFF000000)
      openColor.backupDay = new CoreEyrieColor(0x1A000000,0x1A000000)
      routeColor.add(openColor)

      // 不同路况下的路线颜色(极其畅通)
      let fineOpenColor = new CoreRouteTrafficStatusColor()
      fineOpenColor.status = CoreRouteTrafficStatusColor.TRAFFIC_STATUS_FineOpen
      fineOpenColor.highlightDay = new CoreEyrieColor(0xFF0000FF,0xFF000000)
      fineOpenColor.backupDay = new CoreEyrieColor(0x1A0000FF,0x1A000000)
      routeColor.add(fineOpenColor)

      // 不同路况下的路线颜色(拥堵)
      let jamOpenColor = new CoreRouteTrafficStatusColor()
      jamOpenColor.status = CoreRouteTrafficStatusColor.TRAFFIC_STATUS_Jam
      jamOpenColor.highlightDay = new CoreEyrieColor(0xFF00FFFF,0xFF000000)
      jamOpenColor.backupDay = new CoreEyrieColor(0x1A000FFFF,0x1A000000)
      routeColor.add(jamOpenColor)
      //设置不同路况颜色
      routeOverlayOption.setRouteStatusColor(routeColor)

      // 路线宽度
      routeOverlayOption.setLineWidth(30);
      this.options.setRouteOverlayOptions(routeOverlayOption)
      // 开启路过置灰
      this.options.setAfterRouteAutoGray(true)
      // 设置自车、罗盘的显隐，设置为隐藏时会把牵引线一起隐藏，
      this.options.setCarOverlayVisible(false)
      // 设置起终途点\步行轮渡扎点\禁行限行封路icon的显隐
      this.options.setRouteMarkerVisible(false, false, false)
    }
  }

  initNavi() {
    //申请地址：https://console.amap.com/dev/key/app，appId在日志中过滤即可获取
    const appkey = '此处替换官网申请的Key'
    this.naviInstance = AMapNaviFactory.getAMapNaviInstance(getContext().getApplicationContext(), appkey)
    this.naviInstance.setIsUseInnerVoice(true)

    this.naviInstance.setMockLocationManager(MockLocationManager.getInstance())

    this.naviInstance.addAMapNaviListener({

      onInitNaviSuccess: ()=>{

      },

      onNaviInfoUpdate: (naviInfo: INaviInfo) => {
        LogUtil.i('Navi_Demo','naviListener', 'onNaviInfoUpdate: ' + naviInfo.mRouteRemainDis + ' onUpdateNaviInfo curRouteName: ' + naviInfo.mCurRoadName)
      },

      onCalculateRouteSuccess: (routeResult: IAMapCalcRouteResult | null) => {
        console.info('demo 算路成功')
        // 开启模拟定位
        this.naviInstance?.startMockLocation();
      },

      onStartNavi: (type: number) => {
        console.info('onStartNavi: ' + type)
      }
    })
  }

  startLatLng: INaviLatLng = NaviDemoLocationManager.getInstance().getLocation().start
  endLatLng: INaviLatLng = NaviDemoLocationManager.getInstance().getLocation().end

  initTestData() {
    let arr = new ArrayList<INaviPoi>()

    //途径点
    let location1: INaviLatLng = { latitude: 39.833187, longitude: 116.458887 }
    let location2: INaviLatLng = { latitude: 39.945834, longitude: 116.397056 }

    let test1: INaviPoi = {
      coordinate: location1
    }
    let test2: INaviPoi = {
      coordinate: location2
    }
    arr.add(test1)
    arr.add(test2)

    this.wayPoints = arr
  }

  goback() {
    //其他操作
    console.info('退出导航页面')
    // >>>>>>>> 导航反初始化时序 <<<<<<<<<<<<<<

    // 停止mock定位信息
    this.naviInstance?.stopMockLocation();

    // 移除外部监听
    this.naviInstance?.removeAMapNaviListener({})

    // 停止导航
    this.naviInstance?.stopNavi()

    // 销毁导航单例对象
    AMapNaviFactory.destroyAMapNaviInstance()

    this.pageInfos.pop()
  }

  build() {
    NavDestination() {
      AMapNaviComponent(
        {
          appCustomerConfig:{
            isNeedCalculateRouteWhenPresent: true,
            mType: AmapNaviType.Driver,
            //默认模拟导航
            mNaviType: NaviType.GPS,
            start: {
              coordinate: this.startLatLng
            },
            end: {
              coordinate: this.endLatLng
            },
            mRouteStrategy: 10,
            wayPoints: this.wayPoints,
            serviceAreaDetailsEnable: true,
            // leftTopCustomComponent: this.titleBuilder,
            // bottomCustomComponent: this.bottomCustomComponentBuilder,
            goBack: () => {
              this.goback()
            },
            aMapNaviViewOptions: this.options,
          }
        }
      )
    }.title('导航组件')
    .hideTitleBar(true)
    .onBackPressed(() => {
      this.goback() // 弹出路由栈栈顶元素
      return true
    })
  }
}