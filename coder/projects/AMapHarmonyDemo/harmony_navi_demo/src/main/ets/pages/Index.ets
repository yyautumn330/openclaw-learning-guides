import { NaviComposite } from './composite/NaviComposite'

import { AMapNaviFactory, MapsInitializer, MapView, MapViewComponent } from "@amap/amap_lbs_navi"
import { NaviSetting } from '@amap/amap_lbs_navi'
import { AMapPrivacyAgreeStatus, AMapPrivacyInfoStatus, AMapPrivacyShowStatus } from '@amap/amap_lbs_common'

import bundleManager from '@ohos.bundle.bundleManager'
import abilityAccessCtrl, { PermissionRequestResult, Permissions } from '@ohos.abilityAccessCtrl'
import { BusinessError } from '@ohos.base'
import common from '@ohos.app.ability.common'
import { RoutePlanComposite } from './composite/RoutePlanComposite'
import { CustomDriveWayView } from './composite/CustomDriveWayView'
import { CustomOverviewButtonView } from './composite/CustomOverviewButtonView'
import { CustomZoomInIntersectionView } from './composite/CustomZoomInIntersectionView'
import { CustomTrafficButtonView } from './composite/CustomTrafficButtonView'
import { CustomTrafficProgressBarView } from './composite/CustomTrafficProgressBarView'
import { CustomMapStylePathView } from './composite/CustomMapStylePathView'
import { CustomOtherOptionsFunction } from './composite/CustomOtherOptionsFunction'
import { CustomTrafficRoute } from './customRoute/CustomTrafficRoute'
import { CustomOtherDrawEle } from './customRoute/CustomOtherDrawEle'
import { SingleRouteControllerForLatLng } from './route/SingleRouteControllerForLatLng'
import { SingleRouteControllerForPoi } from './route/SingleRouteControllerForPoi'
import { RestRouteControllerForLatLng } from './route/RestRouteControllerForLatLng'
import { RestRouteControllerForPoi } from './route/RestRouteControllerForPoi'
import { SearchPoiController } from './route/SearchPoiController'
import { RouteNaviController } from './route/RouteNaviController'
import { IndependentRouteCalculateView } from './composite/IndependentRouteCalculateView'
import { NorthModeView } from './composite/NorthModeView'
import { CustomCarView } from './composite/CustomCarView'
import { OverviewModeView } from './composite/OverviewModeView'
import { NaviCompositeBase } from './composite/NaviCompositeBase'
import { NaviCompositeAdvanced } from './composite/NaviCompositeAdvanced'
import { UseExtraGpsDataComponent } from './composite/UseExtraGpsDataComponent'
import { VoiceBroadcastView } from './tts/VoiceBroadcastView'
import { SmartCruisePage } from './smartcruise/SmartCruisePage'
import { window } from '@kit.ArkUI'

import { WalkRideRouteControllerForLatLng } from './route/WalkRideRouteControllerForLatLng'
import {
  RestWalkRideRouteControllerForLatLng
} from './route/RestWalkRideRouteControllerForLatLng'
import { NaviDemoLocationManager } from '../utils/NaviDemoLocationManager'
import { AMapLocation } from '@amap/amap_lbs_location'

MapsInitializer.setDebugMode(false)

@Entry
@Component
struct Index {
  private context = getContext(this);
  @Provide('pageInfos') pageInfos: NavPathStack = new NavPathStack()
  @Provide('isPageHide') isPageHide: boolean = false
  // pkg
  getPackageName(context: Context): string {

    let flag = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_SIGNATURE_INFO;

    try {
      let bundleInfo = bundleManager.getBundleInfoForSelfSync(flag)
      let appId = bundleInfo.signatureInfo.appId;
      console.error(`appId 路径 ${appId}`)
      return appId
    } catch (e) {

    }
    return '';
  }

  aboutToAppear(): void {
    this.registerInterception();
  }

  onPageShow(): void {
    // 同意隐私协议
    NaviSetting.updatePrivacyShow(AMapPrivacyShowStatus.DidShow, AMapPrivacyInfoStatus.DidContain, getContext(this));
    NaviSetting.updatePrivacyAgree(AMapPrivacyAgreeStatus.DidAgree, getContext(this));
    console.info('获取资源绝对路径1 '+ getContext(this).getApplicationContext().resourceDir)
    console.info('获取资源绝对路径2 '+ getContext(this).resourceDir)
    this.checkPermissions();
    this.getPackageName(getContext(this))
    this.isPageHide = false
  }

  onPageHide(): void {
    this.isPageHide = true
  }

  registerInterception() {
    this.pageInfos.setInterception({
      // 页面跳转前拦截，允许操作栈，在当前跳转中生效。
      willShow: async (from: NavDestinationContext | "navBar", to: NavDestinationContext | "navBar",
        operation: NavigationOperation, animated: boolean) => {
        if (typeof to === "string" && to === "navBar") {
          // 子页面跳回目录页面时，提前设置为非沉浸式页面，避免目录页面抖动
          let windowClass = await window.getLastWindow(getContext())
          windowClass.setWindowLayoutFullScreen(false)
        }
        if (typeof from === "string" && from === "navBar") {
          const appkey = '此处替换官网申请的Key'
          let naviInstance = AMapNaviFactory.getAMapNaviInstance(getContext().getApplicationContext(), appkey)

          // 使用车辆限行功能时，etau获取到限行信息后引擎会进行一次限行算路，在算路前需要执行方法触发onLocationChange，不然会报起点不在支持范围内
          const location: AMapLocation = await NaviDemoLocationManager.getCurrentLocation();
          naviInstance.setIsUseExtraGPSData(true)
          naviInstance.setExtraGPSData(1, location)
          naviInstance.setIsUseExtraGPSData(false)
        }
        return;
      }
    })
  }

  async checkPermissions(): Promise<void> {
    const permissions: Array<Permissions> = ['ohos.permission.LOCATION'];
    let grantStatus: abilityAccessCtrl.GrantStatus = await this.checkAccessToken(permissions[0]);

    if (grantStatus === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
      // 已经授权，可以继续访问目标操作
    } else {
      // 申请日历权限
      const permissions: Array<Permissions> = ['ohos.permission.LOCATION'];

      this.reqPermissionsFromUser([
        'ohos.permission.APPROXIMATELY_LOCATION',
        'ohos.permission.LOCATION',
      ]);
    }
  }

  async checkAccessToken(permission: Permissions): Promise<abilityAccessCtrl.GrantStatus> {
    let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
    let grantStatus: abilityAccessCtrl.GrantStatus = abilityAccessCtrl.GrantStatus.PERMISSION_DENIED;

    // 获取应用程序的accessTokenID
    let tokenId: number = 0;
    try {
      let bundleInfo: bundleManager.BundleInfo = await bundleManager.getBundleInfoForSelf(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION);
      let appInfo: bundleManager.ApplicationInfo = bundleInfo.appInfo;
      tokenId = appInfo.accessTokenId;
    } catch (error) {
      let err: BusinessError = error as BusinessError;
      console.error(`Failed to get bundle info for self. Code is ${err.code}, message is ${err.message}`);
    }

    // 校验应用是否被授予权限
    try {
      grantStatus = await atManager.checkAccessToken(tokenId, permission);
    } catch (error) {
      let err: BusinessError = error as BusinessError;
      console.error(`Failed to check access token. Code is ${err.code}, message is ${err.message}`);
    }

    return grantStatus;
  }

  reqPermissionsFromUser(permissions: Array<Permissions>): void {
    let context: Context = getContext(this) as common.UIAbilityContext;
    let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
    // requestPermissionsFromUser会判断权限的授权状态来决定是否唤起弹窗
    atManager.requestPermissionsFromUser(context, permissions).then((data: PermissionRequestResult) => {
      let grantStatus: Array<number> = data.authResults;
      let length: number = grantStatus.length;
      for (let i = 0; i < length; i++) {
        if (grantStatus[i] === 0) {
          // 用户授权，可以继续访问目标操作
        } else {
          // 用户拒绝授权，提示用户必须授权才能访问当前页面的功能，并引导用户到系统设置中打开相应的权限
          // this.openPermissionsInSystemSettings()
          return;
        }
      }
      // 授权成功
    }).catch((err: BusinessError) => {
      console.error(`Failed to request permissions from user. Code is ${err.code}, message is ${err.message}`);
    })
  }

  @Builder
  PageMap(name: string) {
    if (name === 'NaviComposite') {
      NaviComposite()
    } else if (name === 'NaviCompositeBase') {
      NaviCompositeBase()
    }else if(name === 'NaviCompositeAdvanced'){
      NaviCompositeAdvanced()
    } else if (name === 'TruckNaviComposite') {
      NaviComposite({ isTruck: true })
    } else if (name === 'RoutePlanComposite') {
      RoutePlanComposite()
    } else if (name === 'CustomTrafficRoute') {
      CustomTrafficRoute()
    } else if (name === 'CustomOtherDrawEle') {
      CustomOtherDrawEle()
    } else if (name === 'SingleRouteForLatLng'){
      SingleRouteControllerForLatLng()
    } else if (name === 'SingleRouteForPOI'){
      SingleRouteControllerForPoi()
    } else if (name === 'RestRouteForLatLng') {
      RestRouteControllerForLatLng()
    }  else if (name === 'RestRouteForPoi') {
      RestRouteControllerForPoi()
    } else if (name === 'WalkRideRouteControllerForLatLng') {
      WalkRideRouteControllerForLatLng()
    } else if (name === 'RestWalkRideRouteControllerForLatLng') {
      RestWalkRideRouteControllerForLatLng()
    } else if(name === 'SearchPoi'){
      SearchPoiController();
    } else if(name === 'RouteNavi'){
      RouteNaviController();
    } else if (name === 'CustomDriveWayView') {
      CustomDriveWayView()
    } else if (name === 'CustomOverviewButtonView') {
      CustomOverviewButtonView()
    } else if (name === 'CustomZoomInIntersectionView') {
      CustomZoomInIntersectionView()
    } else if (name === 'CustomTrafficButtonView') {
      CustomTrafficButtonView()
    } else if (name === 'CustomTrafficProgressBarView') {
      CustomTrafficProgressBarView()
    } else if (name === 'CustomMapStylePathView') {
      CustomMapStylePathView()
    } else if (name === 'CustomOtherOptionsFunction') {
      CustomOtherOptionsFunction()
    }else if (name === 'IndependentRouteCalculateView') {
      IndependentRouteCalculateView()
    } else if (name === 'NorthModeView') {
      NorthModeView()
    } else if (name === 'CustomCarView') {
      CustomCarView()
    } else if (name === 'OverviewModeView') {
      OverviewModeView()
    } else if (name === 'VoiceBroadcastView') {
      VoiceBroadcastView()
    } else if (name === 'SmartCruisePage') {
      SmartCruisePage()
    } else if (name === 'UseExtraGpsDataComponent') {
      UseExtraGpsDataComponent()
    }
  }

  //显示地图
  @Builder
  buildMapShow() {
    Column() {
      MapViewComponent({ type: 'native', soName: 'AMapOpenNaviJNI' })
    }.width('100%')
    .height('10%')
  }

  build() {
    Navigation(this.pageInfos) {
      Scroll() {
        Column() {
          //初始化地图
          // this.buildMapShow()

          Divider()
          Button('智能巡航')
            .ButtonCommonStyle()
            .onClick(() => {
              this.pageInfos.pushPath({ name: 'SmartCruisePage' })
            })
          Divider()

          Button('导航组件')
            .ButtonCommonStyle()
            .padding(16)
          Divider()

          Column(){
            Button('导航组件', { stateEffect: true, type: ButtonType.Capsule })
              .ButtonCommonStyle()
              .onClick(() => {
                this.pageInfos.pushPath({ name: 'NaviComposite' })
              })
            Divider()

            Button('导航组件-基础功能', { stateEffect: true, type: ButtonType.Capsule })
              .ButtonCommonStyle()
              .onClick(() => {
                this.pageInfos.pushPath({ name: 'NaviCompositeBase' })
              })
            Divider()

            Button('导航组件-高级功能', { stateEffect: true, type: ButtonType.Capsule })
              .ButtonCommonStyle()
              .onClick(() => {
                this.pageInfos.pushPath({ name: 'NaviCompositeAdvanced' })
              })
            Divider()
          }

          Divider()

          Button('导航组件(货车)', { stateEffect: true, type: ButtonType.Capsule })
            .ButtonCommonStyle()
            .padding(16)
            .onClick(() => {
              this.pageInfos.pushPath({ name: 'TruckNaviComposite' })
            })

          Divider()

          Button('路径规划组件', { stateEffect: true, type: ButtonType.Capsule })
            .ButtonCommonStyle()
            .padding(16)
            .onClick(() => {
              this.pageInfos.pushPath({ name: 'RoutePlanComposite' })
            })

          Divider()

          Button('路径规划')
            .ButtonCommonStyle()
            .padding(16)

          Divider()

          Column() {
            Button('驾车路线规划(单路径)-根据经纬度', { stateEffect: true, type: ButtonType.Capsule })
              .ButtonCommonStyle()
              .onClick(() => {
                this.pageInfos.pushPath({ name: 'SingleRouteForLatLng' })
              })
            Divider()

            Button('驾车路线规划(单路径)-根据POI', { stateEffect: true, type: ButtonType.Capsule })
              .ButtonCommonStyle()
              .onClick(() => {
                this.pageInfos.pushPath({ name: 'SingleRouteForPOI' })
              })
            Divider()

            Button('驾车路线规划(多路径)-根据经纬度', { stateEffect: true, type: ButtonType.Capsule })
              .ButtonCommonStyle()
              .onClick(() => {
                this.pageInfos.pushPath({ name: 'RestRouteForLatLng' })
              })
            Divider()

            Button('驾车路线规划(多路径)-根据POI', { stateEffect: true, type: ButtonType.Capsule })
              .ButtonCommonStyle()
              .onClick(() => {
                this.pageInfos.pushPath({ name: 'RestRouteForPoi' })
              })
            Divider()

            Button('骑步行路线规划（单路径）', { stateEffect: true, type: ButtonType.Capsule })
              .ButtonCommonStyle()
              .onClick(() => {
                this.pageInfos.pushPath({ name: 'WalkRideRouteControllerForLatLng' })
              })
            Divider()

            Button('骑步行路线规划（多路径）', { stateEffect: true, type: ButtonType.Capsule })
              .ButtonCommonStyle()
              .onClick(() => {
                this.pageInfos.pushPath({ name: 'RestWalkRideRouteControllerForLatLng' })
              })
            Divider()

            Button('独立路径规划')
              .ButtonCommonStyle()
              .onClick(() => {
                this.pageInfos.pushPath({ name: 'IndependentRouteCalculateView' })
              })
            Divider()
          }

          Button('导航UI自定义')
            .ButtonCommonStyle()
            .padding(16)

          Divider()

          Column(){
            Button('显示模式')
              .ButtonCommonStyle()
              .onClick(() => {
                this.pageInfos.pushPath({ name: 'OverviewModeView' })
              })

            Divider()

            Button('跟随模式')
              .ButtonCommonStyle()
              .onClick(() => {
                this.pageInfos.pushPath({ name: 'NorthModeView' })
              })

            Divider()

            Button('自定义标注')
              .ButtonCommonStyle()
              .onClick(() => {
                this.pageInfos.pushPath({ name: 'CustomCarView' })
              })

            Divider()

            Button('自定义交通路线', { stateEffect: true, type: ButtonType.Capsule })
              .ButtonCommonStyle()
              .onClick(() => {
                this.pageInfos.pushPath({ name: 'CustomTrafficRoute' })
              })

            Divider()

            Button('自定义其他图面元素', { stateEffect: true, type: ButtonType.Capsule })
              .ButtonCommonStyle()
              .onClick(() => {
                this.pageInfos.pushPath({ name: 'CustomOtherDrawEle' })
              })

            Divider()

            Button('自定义车道线')
              .ButtonCommonStyle()
              .onClick(() => {
                this.pageInfos.pushPath({ name: 'CustomDriveWayView' })
              })

            Divider()

            Button('自定义全览按钮')
              .ButtonCommonStyle()
              .onClick(() => {
                this.pageInfos.pushPath({ name: 'CustomOverviewButtonView' })
              })

            Divider()

            Button('自定义路口放大图')
              .ButtonCommonStyle()
              .onClick(() => {
                this.pageInfos.pushPath({ name: 'CustomZoomInIntersectionView' })
              })


            Divider()

            Button('自定义路况按钮')
              .ButtonCommonStyle()
              .onClick(() => {
                this.pageInfos.pushPath({ name: 'CustomTrafficButtonView' })
              })

            Divider()

            Button('自定义导航光柱')
              .ButtonCommonStyle()
              .onClick(() => {
                this.pageInfos.pushPath({ name: 'CustomTrafficProgressBarView' })
              })

            Divider()

            Button('其他自定义能力')
              .ButtonCommonStyle()
              .onClick(() => {
                this.pageInfos.pushPath({ name: 'CustomOtherOptionsFunction' })
              })

            Divider()

            Button('设置地图自定义样式文件的路径')
              .ButtonCommonStyle()
              .onClick(() => {
                this.pageInfos.pushPath({ name: 'CustomMapStylePathView' })
              })
 
            Divider()
 
            Button('语音播报')
              .ButtonCommonStyle()
              .padding(16)
            Divider()
 
            Column(){
              Button('语音合成')
                .ButtonCommonStyle()
                .onClick(() => {
                  this.pageInfos.pushPath({ name: 'VoiceBroadcastView' })
                })
            }
          }
          Divider()

          Button('导航扩展')
            .ButtonCommonStyle()
            .padding(16)
          Divider()

          Column(){
            Button('传入GPS数据导航')
              .ButtonCommonStyle()
              .onClick(() => {
                this.pageInfos.pushPath({ name: 'UseExtraGpsDataComponent' })
              })
          }
        }
      }
    }
    .title('导航Demo')
    .navDestination(this.PageMap)
    .mode(NavigationMode.Stack)
    .titleMode(NavigationTitleMode.Full)
  }


}


@Extend(Button)
function ButtonCommonStyle() {
  .stateEffect(true)
  .type( ButtonType.Normal )
  .width('100%')
  .backgroundColor(Color.Transparent)
  .align(Alignment.Start)
  .fontColor(Color.Black)
  .padding({ left:32,top:16,bottom:16,right:16})
  .backgroundColor(Color.White)
}