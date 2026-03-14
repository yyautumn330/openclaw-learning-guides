import {
  AMapNaviComponent,
  AMapNaviFactory,
  AmapNaviType,
  AMapNaviViewOptions,
  IAMapCalcRouteResult,
  IAMapNavi,
  INaviInfo,
  INaviLatLng,
  INaviPoi,
  NaviType} from '@amap/amap_lbs_navi'
import { LogUtil } from '@amap/amap_lbs_common';
import { NaviDemoLocationManager } from '../../utils/NaviDemoLocationManager';
import { MockLocationManager } from '../../mock/manger/MockLocationManager';
import { ArrayList } from '@kit.ArkTS';

// 自定义其他图面元素（转向箭头、电子眼、牵引线、红绿灯显隐）
@Component
export struct CustomOtherDrawEle {
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
    this.initNavi()
    this.initCustomViewOptions()
  }

  initCustomViewOptions() {
    let overlayOptions = this.options.getRouteOverlayOptions()
    // 显示转弯箭头
    this.options.setNaviArrowVisible(true)
    // 转弯箭头3D
    overlayOptions.setTurnArrowIs3D(true)
    // 3D转弯箭头侧边颜色
    overlayOptions.setArrowSideColor(0xff00ff00)
    // 转弯箭头颜色
    overlayOptions.setArrowColor(0xffff0000)
    // 路线宽度
    overlayOptions.setLineWidth(20)
    // 转弯箭头宽度
    overlayOptions.setArrowWidth(20)
    // 隐藏电子眼
    overlayOptions.setOnRouteCameShow(false)
    // 不显示电子眼距离
    this.options.setShowCameraDistance(false)
    // 显示牵引线
    this.options.setLeaderLineEnabled(0xffff0000)

    this.options.setRouteOverlayOptions(overlayOptions)
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
            aMapNaviViewOptions: this.options
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