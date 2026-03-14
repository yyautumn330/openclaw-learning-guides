import { AMapNaviComponent,
  AMapNaviFactory,
  AmapNaviType,
  IAMapCalcRouteResult,
  IAMapNavi,
  INaviInfo,
  NaviType} from '@amap/amap_lbs_navi'
import { LogUtil } from '@amap/amap_lbs_common';
import { NaviDemoLocationManager } from '../../utils/NaviDemoLocationManager';
import { INaviLatLng } from '@amap/amap_lbs_navi';
import { MockLocationManager } from '../../mock/manger/MockLocationManager';
 
@Component
export struct VoiceBroadcastView {
  @Prop isTruck: Boolean = false;
  @Consume('pageInfos') pageInfos: NavPathStack;
  @State isUseInnerVoice: boolean = true;
  customText: string = "我是自定义语音内容"
  naviInstance?: IAMapNavi
 
  //生命周期方法
  aboutToAppear(): void {
    this.initNavi()
  }
 
  initNavi() {
    //申请地址：https://console.amap.com/dev/key/app，appId在日志中过滤即可获取
    const appkey = '此处替换官网申请的Key'
    this.naviInstance = AMapNaviFactory.getAMapNaviInstance(getContext().getApplicationContext(), appkey)
    this.naviInstance.setIsUseInnerVoice(true)
 
    this.naviInstance.setMockLocationManager(MockLocationManager.getInstance())
 
    this.naviInstance.addAMapNaviListener({
      onGetNavigationTextAndType: (text: string | null, type: number) => {
        console.info("onGetNavigationTextAndType text: " + text + " type: " + type)
      },
 
      onNaviInfoUpdate: (naviInfo: INaviInfo) => {
        LogUtil.i('Navi_Demo','naviListener', 'onNaviInfoUpdate: ' + naviInfo.mRouteRemainDis + ' onUpdateNaviInfo curRouteName: ' + naviInfo.mCurRoadName)
      },
 
      onCalculateRouteSuccess: (routeResult: IAMapCalcRouteResult | null) => {
        console.info('demo 算路成功')
        // 开启模拟定位
        if(routeResult?.calcRouteType == 1) {
        this.naviInstance?.startMockLocation();
        }
      },
 
      onStartNavi: (type: number) => {
        console.info('onStartNavi: ' + type)
      }
    })
  }
 
  //红绿灯测试
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
      Stack({alignContent:Alignment.Start}){
        AMapNaviComponent(
          {
            appCustomerConfig: {
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
            }
          }
        )
        Column({ space: 12 }) {
          Row(){
            Checkbox()
              .select(this.isUseInnerVoice)
              .shape(CheckBoxShape.ROUNDED_SQUARE)
              .selectedColor(0x39a2db)
              .onChange((checked: boolean) => {
                this.isUseInnerVoice = checked
                this.naviInstance?.setUseInnerVoice(this.isUseInnerVoice)
              })
            Button('内部语音播报')
              .fontSize(14)
              .border({ width: 1, color: Color.White })
              .backgroundColor('#4D0000FF')
          }
 
          if (this.isUseInnerVoice) {
            Button('开始语音播报')
              .fontSize(14)
              .border({ width: 1, color: Color.White })
              .backgroundColor('#4D0000FF')
              .onClick(() => {
                this.naviInstance?.startSpeak()
              })
            Button('停止语音播报')
              .fontSize(14)
              .border({ width: 1, color: Color.White })
              .backgroundColor('#4D0000FF')
              .onClick(() => {
                this.naviInstance?.stopSpeak()
              })
            Button('播放自定义语音')
              .fontSize(14)
              .border({ width: 1, color: Color.White })
              .backgroundColor('#4D0000FF')
              .onClick(() => {
                this.naviInstance?.playTTS(this.customText, true)
              })
          }
        }
        .alignItems(HorizontalAlign.Start)
      }
    }.title('语音播报')
    .hideTitleBar(true)
    .onBackPressed(() => {
      this.goback()
      return true
    })
  }
}