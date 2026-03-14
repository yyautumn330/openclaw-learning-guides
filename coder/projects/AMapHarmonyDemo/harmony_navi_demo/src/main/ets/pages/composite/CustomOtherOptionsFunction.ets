import {
  AMap,
  AMapNaviComponent,
  AMapNaviFactory,
  AmapNaviType,
  AMapNaviViewOptions,
  IAMapCalcRouteResult,
  IAMapNavi,
  INaviInfo,
  INaviPoi,
  NaviType,
  AMapCarInfo,
  INaviLatLng} from '@amap/amap_lbs_navi'
import { LogUtil } from '@amap/amap_lbs_common';
import { NaviDemoLocationManager } from '../../utils/NaviDemoLocationManager';

import { ArrayList } from '@kit.ArkTS';
import { MockLocationManager } from '../../mock/manger/MockLocationManager';

@Component
export struct CustomOtherOptionsFunction {
  wayPoints: ArrayList<INaviPoi> = new ArrayList()
  @Prop isTruck: Boolean = false;
  @Consume('pageInfos') pageInfos: NavPathStack;
  @State  isSettingMenuEnabled:boolean = true
  @State mAMapNaviViewOptions:AMapNaviViewOptions = new AMapNaviViewOptions()
  naviInstance?: IAMapNavi

  //生命周期方法
  aboutToAppear(): void {
    //设置菜单按钮是否在导航界面显示。
    this.mAMapNaviViewOptions.setSettingMenuEnabled(false)
    //设置全览按钮是否展示
    this.mAMapNaviViewOptions.setRouteListButtonShow(false)
    // 设置自车位置锁定在屏幕中的位置，(0, 0)为地图左上角，(1, 1)为地图右下角
    this.mAMapNaviViewOptions.setPointToCenter(0.5,1)
    //设置是否开启动态比例尺 (锁车态下自动进行地图缩放变化)
    this.mAMapNaviViewOptions.setAutoChangeZoom(true)
    //设置导航界面是否显示黑夜模式。
    this.mAMapNaviViewOptions.setNaviNight(true)
    //设置是否开启昼夜模式
    this.mAMapNaviViewOptions.setAutoNaviViewNightMode(true)
    this.initTestData()
    this.initNavi()
  }

  initNavi() {
    //申请地址：https://console.amap.com/dev/key/app，appId在日志中过滤即可获取
    const appkey = '此处替换官网申请的Key'
    this.naviInstance = AMapNaviFactory.getAMapNaviInstance(getContext().getApplicationContext(), appkey)
    this.naviInstance.setIsUseInnerVoice(true)

    if (this.isTruck) {
      // 设置货车信息
      let carInfo: AMapCarInfo = new AMapCarInfo();
      carInfo.mCarType = 1;
      carInfo.mCarNumber = "黑A12222";
      carInfo.mVehicleSize = 1;
      carInfo.mVehicleLoad = 100;
      carInfo.mVehicleWeight = 99;
      carInfo.mVehicleLength = 25;
      carInfo.mVehicleWidth = 2;
      carInfo.mVehicleHeight = 4;
      carInfo.mVehicleAxis = 6;
      carInfo.mVehicleLoadSwitch = true;
      carInfo.isRestriction = true;
      this.naviInstance.setCarInfo(carInfo);
    }

    this.naviInstance.setMockLocationManager(MockLocationManager.getInstance())

    this.naviInstance.addAMapNaviListener({

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

  //红绿灯测试
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
      Stack(){
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
              mRouteStrategy: 2,
              serviceAreaDetailsEnable: true,
              aMapNaviViewOptions:this.mAMapNaviViewOptions,
              goBack: () => {
                this.goback()
              },
            }
          }
        )
      }

    }.title('导航组件')
    .hideTitleBar(true)
    .onBackPressed(() => {
      this.goback()
      return true
    })
  }

  // 显示导航页面
  private showNaviPage() {
    console.info('显示导航页面')
  }
}