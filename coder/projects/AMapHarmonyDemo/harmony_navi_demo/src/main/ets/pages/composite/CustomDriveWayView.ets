import {
  AMap,
  AMapNaviComponent,
  AMapNaviFactory,
  AmapNaviType,
  AMapNaviViewOptions,
  IAMapCalcRouteResult,
  IAMapLaneInfo,
  IAMapNavi, IAmapNaviParams,
  INaviInfo,
  INaviPoi,
  NaviType,DriveWay,
  AMapCarInfo,
  INaviLatLng} from '@amap/amap_lbs_navi'
import { LogUtil } from '@amap/amap_lbs_common';
import { NaviDemoLocationManager } from '../../utils/NaviDemoLocationManager';

import { ArrayList } from '@kit.ArkTS';
import { MockLocationManager } from '../../mock/manger/MockLocationManager';


@Component
export struct CustomDriveWayView {
  wayPoints: ArrayList<INaviPoi> = new ArrayList()
  @Prop isTruck: Boolean = false;
  @Consume('pageInfos') pageInfos: NavPathStack;
  @State  isSettingMenuEnabled:boolean = true
  @State mAMapNaviViewOptions:AMapNaviViewOptions = new AMapNaviViewOptions()
  naviInstance?: IAMapNavi

  array = [
    "直行车道"
  , "左转车道"
  , "左转或直行车道"
  , "右转车道"
  , "右转或直行车道"
  , "左掉头车道"
  , "左转或者右转车道"
  , " 左转或右转或直行车道"
  , "右转掉头车道"
  , "直行或左转掉头车道"
  , "直行或右转掉头车道"
  , "左转或左掉头车道"
  , "右转或右掉头车道"
  , "直行并且车道扩展"
  , "左转+左掉头+扩展"
  , "不可以选择该车道"
  , "直行+左转+左掉头车道"
  , "右转+左掉头"
  , "左转+右转+左掉头"
  , "直行+右转+左掉头"
  , "左转+右掉头"
  , "公交车道"
  , "空车道"
  , "可变车道"
  ]

  actions = [
    "直行"
  , "左转"
  , "左转或直行"
  , "右转"
  , "右转或这行"
  , "左掉头"
  , "左转或者右转"
  , " 左转或右转或直行"
  , "右转掉头"
  , "直行或左转掉头"
  , "直行或右转掉头"
  , "左转或左掉头"
  , "右转或右掉头"
  , "直行并且车道扩展"
  , "左转+左掉头+扩展"
  , "不可以选择"
  , "直行+左转+左掉头"
  , "右转+左掉头"
  , "左转+右转+左掉头"
  , "直行+右转+左掉头"
  , "左转+右掉头"
  , "公交车道"
  , "空车道"
  , "可变车道"
  ]

  @Builder
  setLazyDriveWayView() {
    DriveWay()
      .alignRules( {
        bottom: { anchor: "__container__", align: VerticalAlign.Bottom },
        middle: { anchor: "__container__", align: HorizontalAlign.Center },
      })
  }

  //生命周期方法
  aboutToAppear(): void {
    this.mAMapNaviViewOptions.setLayoutVisible(false)
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
      },

      showLaneInfo:(aMapLaneInfo:IAMapLaneInfo|null)=>{
        let sb = ''
        if (aMapLaneInfo) {
          sb+= "共" + aMapLaneInfo.frontLane.length + "车道"
          for (let index = 0; index < aMapLaneInfo.frontLane.length; index++) {
            const background = aMapLaneInfo.backgroundLane[index];
            const recommend = aMapLaneInfo.frontLane[index];
            try {
              sb += "，第" + (index + 1) + "车道为" + this.array[background]
              if (recommend != 255) {
                sb += "，当前车道可 " + this.actions[recommend]
              }
            }catch (e) {
              e.printStackTrace();
            }
          }

          this.getUIContext().getPromptAction().showToast({ message: sb })
        }
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
              setLazyDriveWayView:this.setLazyDriveWayView,
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