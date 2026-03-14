import {
  AMap,
  AMapNaviComponent,
  AMapNaviFactory,
  AmapNaviType,
  AMapNaviViewOptions,
  CrossImage,
  IAMapCalcRouteResult,
  IAMapNavi, IAmapNaviParams,
  INaviInfo,
  INaviLatLng,
  INaviPoi,
  NaviType} from '@amap/amap_lbs_navi'
import { LogUtil } from '@amap/amap_lbs_common';
import { MockLocationManager } from '../../mock/manger/MockLocationManager';
import { ArrayList } from '@kit.ArkTS';



@Component
export struct CustomZoomInIntersectionView {
  wayPoints: ArrayList<INaviPoi> = new ArrayList()
  @Prop isTruck: Boolean = false;
  @Consume('pageInfos') pageInfos: NavPathStack;
  @State  isSettingMenuEnabled:boolean = true
  @State mAMapNaviViewOptions:AMapNaviViewOptions = new AMapNaviViewOptions()
  naviInstance?: IAMapNavi


  @Builder
  setLazyZoomInIntersectionView(){
    CrossImage()
      .alignRules( {
        bottom: { anchor: "__container__", align: VerticalAlign.Bottom },
        middle: { anchor: "__container__", align: HorizontalAlign.Center },
      })
  }

  //生命周期方法
  aboutToAppear(): void {
    this.mAMapNaviViewOptions.setLayoutVisible(false)

    this.initNavi()
  }

  initNavi() {
    //申请地址：https://console.amap.com/dev/key/app，appId在日志中过滤即可获取
    const appkey = '此处替换官网申请的Key'
    this.naviInstance = AMapNaviFactory.getAMapNaviInstance(getContext().getApplicationContext(), appkey)
    this.naviInstance.setIsUseInnerVoice(true)

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
    })
  }

  //红绿灯测试
  endLatLng: INaviLatLng = {latitude:40.084894,longitude:116.603039} //NaviDemoLocationManager.getInstance().getLocation().start
  startLatLng : INaviLatLng = {latitude:39.825934,longitude:116.342972}//NaviDemoLocationManager.getInstance().getLocation().end

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
              mNaviType: NaviType.NONE,
              start: {
                coordinate: this.startLatLng
              },
              end: {
                coordinate: this.endLatLng
              },
              mRouteStrategy: 2,
              serviceAreaDetailsEnable: true,
              setLazyZoomInIntersectionView: this.setLazyZoomInIntersectionView,
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