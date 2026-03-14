import { AMapNaviComponent,
  AMapNaviFactory,
  AmapNaviType,
  AMapNaviViewOptions,
  IAMapCalcRouteResult,
  IAMapNavi,
  IAMapNaviLocation,
  INaviInfo,
  INaviLatLng,
  INaviPoi,
  NaviLatLng,
  NaviType} from '@amap/amap_lbs_navi'
import { LogUtil } from '@amap/amap_lbs_common';
import { ArrayList } from '@kit.ArkTS';
import { MockLocationManager } from '../../mock/manger/MockLocationManager';
import { AMapNaviViewListener } from '@amap/amap_lbs_navi';
import { AMapLocation } from '@amap/amap_lbs_location';
import virtualUtil from '../../mock/VirtualUtil'

@Component
export struct UseExtraGpsDataComponent{
  wayPoints: ArrayList<INaviPoi> = new ArrayList()
  @Prop isTruck: Boolean = false;
  @Consume('pageInfos') pageInfos: NavPathStack;
  i:number = 0

  context = getContext().getApplicationContext()

  naviInstance?: IAMapNavi
  aMapNaviViewOptions: AMapNaviViewOptions = new AMapNaviViewOptions();

  aMapNaviSettingListener: AMapNaviViewListener = {
    onNaviSetting:()=>{
      this.setExtraGPSData()
    }
  }

  /**
   * GPS
   */
  setExtraGPSData(){
    const  points = this.naviInstance?.getNaviPath()?.getCoordList()
    if (points && this.i < points.length-1){
      const naviLatLng = points[this.i]
      const nexLatlng = points[this.i+1]
      const location:AMapLocation = {
        provider: 'gps',
        longitude: naviLatLng.longitude,
        latitude: naviLatLng.latitude,
        speed: 15,
        accuracy: 1,
        bearing: virtualUtil.angleBetweenCoordinates(virtualUtil.simpleLocationVirtual(naviLatLng.latitude,
          naviLatLng.longitude), virtualUtil.simpleLocationVirtual(nexLatlng.latitude,
          nexLatlng.longitude)),
        timeStamp: new Date().getTime(),
        direction: -1,
        isOffset: false,
        timeSinceBoot: -1,
        altitude: 0
      }
      this.naviInstance?.setExtraGPSData(2, location)
      if (this.i == points.length-2) {
        const nexLatlng = points[this.i+1]
        const location:AMapLocation = {
          provider: 'gps',
          longitude: nexLatlng.longitude,
          latitude: nexLatlng.latitude,
          speed: 15,
          accuracy: 1,
          bearing: 5,
          timeStamp: new Date().getTime(),
          direction: -1,
          isOffset: false,
          timeSinceBoot: -1,
          altitude: 0
        }
        this.naviInstance?.setExtraGPSData(2, location)
      }

      this.i++
      this.getUIContext().getPromptAction().showToast({ message: JSON.stringify(location)})
    }

  }

  //生命周期方法
  aboutToAppear(): void {
    this.initNavi()
  }

  initNavi() {
    //申请地址：https://console.amap.com/dev/key/app，appId在日志中过滤即可获取
    const appkey = '此处替换官网申请的Key'
    this.naviInstance = AMapNaviFactory.getAMapNaviInstance(getContext().getApplicationContext(), appkey)
    this.naviInstance.setIsUseInnerVoice(true)

    this.naviInstance.setIsUseExtraGPSData(true)

    this.naviInstance.setMockLocationManager(MockLocationManager.getInstance())

    this.naviInstance.addAMapNaviListener({

      onNaviInfoUpdate: (naviInfo: INaviInfo) => {
        LogUtil.i('Navi_Demo','naviListener', 'onNaviInfoUpdate: ' + naviInfo.mRouteRemainDis + ' onUpdateNaviInfo curRouteName: ' + naviInfo.mCurRoadName)
      },

      onCalculateRouteSuccess: (routeResult: IAMapCalcRouteResult | null) => {
        // 开启模拟定位
        this.naviInstance?.startMockLocation();
      },

      onStartNavi: (type: number) => {
        console.info('onStartNavi: ' + type)
      }
    })

    this.aMapNaviViewOptions.setSettingMenuEnabled(true)

    this.getUIContext().getPromptAction().showToast({ message: '点击右下角menu按钮实现设置外部GPS' })

  }


  //红绿灯测试
  startLatLng: INaviLatLng = new NaviLatLng(39.825934,116.342972);
  endLatLng: INaviLatLng = new NaviLatLng(40.084894,116.603039);


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
            mRouteStrategy: 2,
            serviceAreaDetailsEnable: true,
            goBack: () => {
              this.goback()
            },
            aMapNaviViewOptions: this.aMapNaviViewOptions,
          },
          aMapNaviSettingListener: this.aMapNaviSettingListener
        }
      )
    }.title('导航组件')
    .hideTitleBar(true)
    .onBackPressed(() => {
      this.goback()
      return true
    })
  }
}


