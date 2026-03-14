import { AMapNaviComponent,
  AMapNaviFactory,
  AmapNaviType,
  AMapNaviViewOptions,
  AMapNaviViewTrackingMode,
  CoreEyrieColor,
  CoreRoutePassLineColor,
  IAMapCalcRouteResult,
  IAMapNavi,
  IAMapNaviRouteNotifyData,
  INaviInfo,
  NaviType,
  PathPlanningStrategy,
  RouteOverlayOptions,
  TrafficButtonView} from '@amap/amap_lbs_navi'
import { LogUtil } from '@amap/amap_lbs_common';
import { MockLocationManager } from '../../mock/manger/MockLocationManager';
import { AMapCarInfo } from '@amap/amap_lbs_navi'
import { NaviInfo } from '@amap/amap_lbs_navi';
import { window } from '@kit.ArkUI';

@Component
export struct RouteNaviController {
  @Consume('pageInfos') pageInfos: NavPathStack;

  isGPS: boolean = false;
  naviInstance?: IAMapNavi

  //规划路线策略
  routeStrategy: PathPlanningStrategy = PathPlanningStrategy.DRIVING_MULTIPLE_ROUTES_DEFAULT;

  carInfo: AMapCarInfo | null = null;

  options: AMapNaviViewOptions = new AMapNaviViewOptions()

  mType: AmapNaviType|undefined = undefined;

  //生命周期方法
  aboutToAppear(): void {
    this.options.setSettingMenuEnabled(true);
    this.initData();
    this.initNavi()
    this.registerInterception()
  }

  registerInterception() {
    this.pageInfos.setInterception({
      willShow: async (from: NavDestinationContext | "navBar", to: NavDestinationContext | "navBar",
        operation: NavigationOperation, animated: boolean) => {
        let windowClass = await window.getLastWindow(getContext())
        windowClass.setWindowLayoutFullScreen(false)
        return;
      }
    })
  }

  initData(){

  }

  initNavi() {
    const appkey = '此处替换官网申请的Key'
    this.naviInstance = AMapNaviFactory.getAMapNaviInstance(getContext().getApplicationContext(), appkey)

    this.naviInstance.setIsUseInnerVoice(true)

    let routeOverlayOption: RouteOverlayOptions = this.options.getRouteOverlayOptions();
    // 路过置灰颜色
    routeOverlayOption.setRouteGreyColor(new CoreRoutePassLineColor())
    this.options.setRouteOverlayOptions(routeOverlayOption)
    // 开启路过置灰
    this.options.setAfterRouteAutoGray(true)
    // 开启自动切换昼夜模式
    this.options.setAutoNaviViewNightMode(true)

    this.options.setAutoChangeZoom(true);
    this.naviInstance.setViewOption(this.options);


    //设置模拟导航的行车速度
    this.naviInstance.setEmulatorNaviSpeed(100);

    this.naviInstance.setMockLocationManager(MockLocationManager.getInstance())

    this.naviInstance.addAMapNaviListener({

      onNaviInfoUpdate: (naviInfo: INaviInfo) => {
        console.log('addAMapNaviListener --- onNaviInfoUpdate: ' + naviInfo.mRouteRemainDis + ' onUpdateNaviInfo curRouteName: ' + naviInfo.mCurRoadName
          + '; 禁行限制信息：' + naviInfo.notAvoidInfo + ';' + naviInfo.notAvoidInfo?.type);

        // LogUtil.i('Navi_Demo','naviListener', 'onNaviInfoUpdate: ' + naviInfo.mRouteRemainDis + ' onUpdateNaviInfo curRouteName: ' + naviInfo.mCurRoadName)
      },

      onCalculateRouteSuccess: (routeResult: IAMapCalcRouteResult | null) => {
        console.info('addAMapNaviListener --- demo 算路成功')
      },

      onStartNavi: (type: number) => {
        console.info('addAMapNaviListener --- onStartNavi: ' + type)
      },
      onNaviRouteNotify: (notifyData: IAMapNaviRouteNotifyData| null) => {
        console.log(`addAMapNaviListener --- onNaviRouteNotify --- ${JSON.stringify(notifyData)}`);
      }
    })
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

    this.pageInfos.pop()
  }

  build() {
    NavDestination() {
      AMapNaviComponent(
        {
          appCustomerConfig:{
            isNeedCalculateRouteWhenPresent: false,
            mType: this.mType ?? AmapNaviType.Driver,
            //默认模拟导航
            mNaviType: this.isGPS ? NaviType.GPS : NaviType.EMULATOR,
            mRouteStrategy: this.routeStrategy,
            carInfo: this.carInfo ?? new AMapCarInfo(),
            goBack: () => {
              this.goback()
            },
            aMapNaviViewOptions: this.options,
          }
        }
      )
    }.title('导航组件')
    .onReady((context: NavDestinationContext) => {
      const params = context.pathInfo.param as object;
      this.isGPS = params["gps"] as boolean;
      //规划策略
      this.routeStrategy = params["strategy"] as number;
      this.carInfo = params["carInfo"] as AMapCarInfo;
      this.mType = params['mType'] as AmapNaviType

      //开始导航
      if (this.mType === AmapNaviType.Walk) {
        this.naviInstance!.setNaviMode(AMapNaviViewTrackingMode.MapNorth)
      }
      if (this.mType != AmapNaviType.Driver) {
        this.options.setAutoLockCar(true)
      }
      //开始导航
      this.naviInstance?.startNavi(this.isGPS ? NaviType.GPS : NaviType.EMULATOR);
    })
    .hideTitleBar(true)
    .onBackPressed(() => {
      this.goback();
      // const popDestinationInfo = this.pageInfos.pop() // 弹出路由栈栈顶元素
      // console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true
    })
  }
}