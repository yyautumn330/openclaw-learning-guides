import { ArrayList } from '@kit.ArkTS';
import {
  AMapNaviComponent,
  AMapNaviFactory,
  AmapNaviType,
	AMapNaviViewOptions,
  IAMapCalcRouteResult,
  IAMapNavi,
  INaviPoi,
  INaviInfo,
  NaviType,
  IAMapNaviCameraInfo,
  IAMapServiceAreaInfo,
  IAMapNaviCross,
  IAMapModelCross,
  IAMapLaneInfo,
  IAMapNaviTrafficFacilityInfo,
  IAMapNaviRouteNotifyData,
  IAMapNaviLocation,
  IAMapNaviListener,
  AMapNaviToViaInfo,
  INaviLatLng,
} from '@amap/amap_lbs_navi'
import { AMapCarInfo } from '@amap/amap_lbs_navi';
import {
  IAMapNaviParallelRoadStatus
} from '@amap/amap_lbs_navi';
import { LogUtil } from '@amap/amap_lbs_common';
import { MockLocationManager } from '../../mock/manger/MockLocationManager';

@Component
export struct NaviComposite {
  @State wayPoints: ArrayList<INaviPoi> = new ArrayList()
  @Prop isTruck: Boolean = false;
  @Consume('pageInfos') pageInfos: NavPathStack;
  naviInstance?: IAMapNavi
  listener?: IAMapNaviListener
	private options: AMapNaviViewOptions = new AMapNaviViewOptions()

  @Builder
  titleBuilder() {
    Button('按钮')
      .width(100)
      .height('100%')
      .type(ButtonType.Normal)
      .backgroundColor('orange')
  }

  @Builder
  bottomCustomComponentBuilder() {
    Text('底部自定义组件')
      .width('100%')
      .height(200)
      .textAlign(TextAlign.Center)
      .backgroundColor(Color.Orange)
  }

  //生命周期方法
  aboutToAppear(): void {
    this.initNavi()
    this.initTestData()
  }

  initNavi() {
    //申请地址：https://console.amap.com/dev/key/app，appId在日志中过滤即可获取
    const appkey = '此处替换官网申请的Key'
    this.naviInstance = AMapNaviFactory.getAMapNaviInstance(getContext().getApplicationContext(), appkey)
    LogUtil.i('Navi_Demo', 'naviListener', '获取版本号getVersion=========: ' + this.naviInstance.getVersion()) // 获取版本号
    this.naviInstance.setIsUseInnerVoice(true) // 是否开启内置语音，默认true

    this.naviInstance.startGPS()

    //驾车设置
    /*let carInfo: AMapCarInfo = new AMapCarInfo();
    carInfo.mCarType = 0;
    carInfo.mCarNumber = "晋A12225";
    carInfo.isRestriction = true;
    this.naviInstance.setCarInfo(carInfo);*/

    //货车设置
    if (this.isTruck) {
      // 设置货车信息
      let carInfo: AMapCarInfo = new AMapCarInfo();
      carInfo.mCarType = 1;
      carInfo.mCarNumber = "京A12225";
      carInfo.mVehicleSize = 4;
      carInfo.mVehicleLoad = 100;
      carInfo.mVehicleWeight = 45;
      carInfo.mVehicleLength = 15;
      carInfo.mVehicleWidth = 50;
      carInfo.mVehicleHeight = 3.9;
      // carInfo.mVehicleAxis = 255;
      carInfo.mVehicleLoadSwitch = false;
      carInfo.isRestriction = false;
      this.naviInstance.setCarInfo(carInfo);
    }
    this.naviInstance.setMockLocationManager(MockLocationManager.getInstance())

		this.options.setSettingMenuEnabled(true)
		this.options.setShowSettingsPanel(true)
    this.options.setAutoChangeZoom(true);

    let listener: IAMapNaviListener = {
      onInitNaviFailure: this.onInitNaviFailure,
      onInitNaviSuccess: this.onInitNaviSuccess,
      onStartNavi: this.onStartNavi,
      onTrafficStatusUpdate: this.onTrafficStatusUpdate,
      onLocationChange: this.onLocationChange,
      onGetNavigationTextAndType: this.onGetNavigationTextAndType,
      onEndEmulatorNavi: this.onEndEmulatorNavi,
      onArriveDestination: this.onArriveDestination,
      onReCalculateRouteForYaw: this.onReCalculateRouteForYaw,
      onReCalculateRouteForTrafficJam: this.onReCalculateRouteForTrafficJam,
      onArrivedWayPoint: this.onArrivedWayPoint,
      onGpsOpenStatus: this.onGpsOpenStatus,
      onNaviInfoUpdate: this.onNaviInfoUpdate,
      updateCameraInfo: this.updateCameraInfo,
      updateIntervalCameraInfo: this.updateIntervalCameraInfo,
      onServiceAreaUpdate: this.onServiceAreaUpdate,
      showCross: this.showCross,
      hideCross: this.hideCross,
      showModeCross: this.showModeCross,
      hideModeCross: this.hideModeCross,
      showLaneInfo: this.showLaneInfo,
      hideLaneInfo: this.hideLaneInfo,
      notifyParallelRoad: this.notifyParallelRoad,
      // OnUpdateTrafficFacility: this.OnUpdateTrafficFacility,
      onPlayRing: this.onPlayRing,
      onTTSIsPlaying: this.onTTSIsPlaying,
      onCalculateRouteSuccess: this.onCalculateRouteSuccess,
      onCalculateRouteFailureForResult: this.onCalculateRouteFailureForResult,
      onNaviRouteNotify: this.onNaviRouteNotify,
      onUpdateGPSSignalStrength: this.onUpdateGPSSignalStrength,
      onGpsSignalWeak: this.onGpsSignalWeak,
    }
    this.listener = listener
    //添加导航事件回调监听。
    this.naviInstance.addAMapNaviListener(this.listener)
  }

  /**
   * 导航初始化失败时的回调函数。
   */
  onInitNaviFailure = () => {
    LogUtil.i('Navi_Demo', 'naviListener', 'onInitNaviFailure:导航初始化失败')
  }
  /**
   * 导航初始化成功时的回调函数。
   */
  onInitNaviSuccess = () => {
    LogUtil.i('Navi_Demo', 'naviListener', 'onInitNaviSuccess:导航初始化成功')
  }
  /**
   * 启动导航后的回调函数
   *
   * @param type 导航类型参见{@link com.amap.api.navi.enums.NaviType}
   */
  onStartNavi = (type: number) => {
    //this.naviInstance?.removeAMapNaviListener({});//移除导航对象的监听。
    LogUtil.i('Navi_Demo', 'naviListener', 'onStartNavi:启动导航' + type)
  }
  /**
   * 当前方路况光柱信息有更新时回调函数。
   * 注意：<font color='red'>该接口仅驾车模式有效</font>
   */
  onTrafficStatusUpdate = () => {
    LogUtil.i('Navi_Demo', 'naviListener', 'onTrafficStatusUpdate:前方路况光柱信息有更新时的回调')
  }
  /**
   * 当位置信息有更新时的回调函数。
   *
   * @param location 当前位置的定位信息。
   */
  onLocationChange = (location: IAMapNaviLocation | null) => {
    LogUtil.i('Navi_Demo', 'naviListener', 'onLocationChange:当位置信息有更新:accuracy = ' + location?.accuracy)
    LogUtil.i('Navi_Demo', 'naviListener', 'onLocationChange:当位置信息有更新:altitude = ' + location?.altitude)
    LogUtil.i('Navi_Demo', 'naviListener', 'onLocationChange:当位置信息有更新:bearing = ' + location?.bearing)
    LogUtil.i('Navi_Demo', 'naviListener', 'onLocationChange:当位置信息有更新:roadBearing = ' + location?.roadBearing)
    LogUtil.i('Navi_Demo', 'naviListener', 'onLocationChange:当位置信息有更新:speed = ' + location?.speed)
    LogUtil.i('Navi_Demo', 'naviListener', 'onLocationChange:当位置信息有更新:time = ' + location?.time)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onLocationChange:当位置信息有更新:coord.latitude = ' + location?.coord?.latitude)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onLocationChange:当位置信息有更新:coord.longitude = ' + location?.coord?.longitude)
    LogUtil.i('Navi_Demo', 'naviListener', 'onLocationChange:当位置信息有更新:type = ' + location?.locationType)
    LogUtil.i('Navi_Demo', 'naviListener', 'onLocationChange:当位置信息有更新:locationType = ' + location?.locationType)
    LogUtil.i('Navi_Demo', 'naviListener', 'onLocationChange:当位置信息有更新:curStepIndex = ' + location?.curStepIndex)
    LogUtil.i('Navi_Demo', 'naviListener', 'onLocationChange:当位置信息有更新:curLinkIndex = ' + location?.curLinkIndex)
    LogUtil.i('Navi_Demo', 'naviListener', 'onLocationChange:当位置信息有更新:curStepIndex = ' + location?.curStepIndex)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onLocationChange:当位置信息有更新:curPointIndex = ' + location?.curPointIndex)
  }
  /**
   * 导航播报信息回调函数。
   * @param type 播报类型枚举，详情见 {@link com.amap.api.navi.enums.NaviTTSType}
   * @param text 播报文案
   */
  onGetNavigationTextAndType = (text: string | null, type: number) => {
    LogUtil.i('Navi_Demo', 'naviListener', 'onGetNavigationTextAndType:导航播报信息:' + text + type)
  }
  /**
   * 模拟导航停止后回调函数。
   */
  onEndEmulatorNavi = () => {
    LogUtil.i('Navi_Demo', 'naviListener', 'onEndEmulatorNavi:模拟导航停止')
  }
  /**
   * 到达目的地后回调函数。
   */
  onArriveDestination = () => {
    LogUtil.i('Navi_Demo', 'naviListener', 'onArriveDestination:到达目的地')
  }
  /**
   * 偏航后准备重新规划路线前的通知回调。<br/>
   * 此方法只是通知准备重算事件，开发者不需要在方法中触发算路逻辑，SDK内部会进行算路。
   */
  onReCalculateRouteForYaw = () => {
    LogUtil.i('Navi_Demo', 'naviListener', 'onReCalculateRouteForYaw:偏航后准备重新规划路线前的通知回调')
  }
  /**
   * 驾车导航时，当前方遇到拥堵时准备重新规划路线前的通知回调。<br/>
   * 此方法只是通知准备重算事件，开发者不需要在方法中触发算路逻辑，SDK内部会进行算路。
   */
  onReCalculateRouteForTrafficJam = () => {
    LogUtil.i('Navi_Demo', 'naviListener',
      'onReCalculateRouteForTrafficJam:驾车导航时，当前方遇到拥堵时准备重新规划路线前的通知回调')
  }
  /**
   * 驾车路径导航到达某个途经点的回调函数。
   * 注意：<font color='red'>该接口仅驾车模式有效</font>
   * @param wayID 到达途径点的编号，标号从0开始，依次累加。
   *
   */
  onArrivedWayPoint = (wayID: number) => {
    LogUtil.i('Navi_Demo', 'naviListener', 'onArrivedWayPoint:驾车路径导航到达某个途经点' + wayID)
  }
  /**
   * 用户手机位置信息设置是否开启的回调函数。
   *
   * @param enabled true,开启;false,未开启。
   */
  onGpsOpenStatus = (enabled: boolean) => {
    LogUtil.i('Navi_Demo', 'naviListener', 'onGpsOpenStatus:用户手机位置信息设置是否开启' + enabled)
  }
  /**
   * 导航引导信息回调。
   *
   * @param naviInfo 导航信息类对象。
   */
  onNaviInfoUpdate = (naviInfo: INaviInfo) => {
    //isTtsPlaying
    LogUtil.i('Navi_Demo', 'naviListener',
      'isTtsPlaying:当前SDK内置语音的是否正在播报=========:' + this.naviInstance?.isTtsPlaying())
    //onNaviInfoUpdate
    LogUtil.i('Navi_Demo', 'naviListener', 'onNaviInfoUpdate:导航引导信息--线路ID:pathID = ' + naviInfo.pathID)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onNaviInfoUpdate:导航引导信息--导航类型  1-实时导航 2-模拟导航:mType = ' + naviInfo.mType)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onNaviInfoUpdate:导航引导信息--当前道路名称:mCurRoadName = ' + naviInfo.mCurRoadName)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onNaviInfoUpdate:导航引导信息--下条道路名称:mNextRoadName = ' + naviInfo.mNextRoadName)
    LogUtil.i('Navi_Demo', 'naviListener', 'onNaviInfoUpdate:导航引导信息--导航段转向图标:mIcon = ' + naviInfo.mIcon)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onNaviInfoUpdate:导航引导信息--路径剩余距离（单位米）:mRouteRemainDis = ' + naviInfo.mRouteRemainDis)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onNaviInfoUpdate:导航引导信息--路径剩余时间（单位秒）:mRouteRemainTime = ' + naviInfo.mRouteRemainTime)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onNaviInfoUpdate:导航引导信息--当前导航段剩余距离（单位米）:mSegRemainDis = ' + naviInfo.mSegRemainDis)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onNaviInfoUpdate:导航引导信息--当前导航段剩余时间（单位秒）:mSegRemainTime = ' + naviInfo.mSegRemainTime)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onNaviInfoUpdate:导航引导信息--当前自车所在segment段，从0开始:mCurSegIndex = ' + naviInfo.mCurSegIndex)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onNaviInfoUpdate:导航引导信息--当前自车所在Link，从0开始:mCurLinkIndex = ' + naviInfo.mCurLinkIndex)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onNaviInfoUpdate:导航引导信息--当前位置的前一个形状点号，从0开始:mCurPointIndex = ' + naviInfo.mCurPointIndex)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onNaviInfoUpdate:导航引导信息--当前车速:currentSpeed = ' + naviInfo.currentSpeed)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onNaviInfoUpdate:导航引导信息--限制、禁止图标信息-类型：1-限高，2-限宽，3-限重，4-禁行:type = ' +
        naviInfo.notAvoidInfo?.type)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onNaviInfoUpdate:导航引导信息--限制、禁止图标信息-禁行类型 0：禁止左转 1：禁止右转 2：禁止左掉头 3：禁止右掉头 4：禁止直行 :forbidType = ' +
        naviInfo.notAvoidInfo?.forbidType)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onNaviInfoUpdate:导航引导信息--限制、禁止图标信息-到自车的距离:distToCar = ' + naviInfo.notAvoidInfo?.distToCar)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onNaviInfoUpdate:导航引导信息--限制、禁止图标信息-二维位置:coord2D.latitude = ' +
        naviInfo.notAvoidInfo?.coord2D?.latitude)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onNaviInfoUpdate:导航引导信息--限制、禁止图标信息-二维位置:coord2D.longitude = ' +
        naviInfo.notAvoidInfo?.coord2D?.longitude)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onNaviInfoUpdate:导航引导信息--限制、禁止图标信息-三维位置:coord3D.latitude = ' +
        naviInfo.notAvoidInfo?.coord3D?.latitude)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onNaviInfoUpdate:导航引导信息--限制、禁止图标信息-三维位置:coord3D.longitude = ' +
        naviInfo.notAvoidInfo?.coord3D?.longitude)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onNaviInfoUpdate:导航引导信息--限制、禁止图标信息-是否有效:valid = ' + naviInfo.notAvoidInfo?.valid)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onNaviInfoUpdate:导航引导信息--限制、禁止图标信息-限高，值为1:LIMIT_HEIGHT = ' +
        naviInfo.notAvoidInfo?.LIMIT_HEIGHT)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onNaviInfoUpdate:导航引导信息--限制、禁止图标信息-限宽，值为2:LIMIT_WIDTH = ' + naviInfo.notAvoidInfo?.LIMIT_WIDTH)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onNaviInfoUpdate:导航引导信息--限制、禁止图标信息-限重 ，值为3:LIMIT_WEIGHT = ' +
        naviInfo.notAvoidInfo?.LIMIT_WEIGHT)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onNaviInfoUpdate:导航引导信息--限制、禁止图标信息-禁行，值为4:LIMIT_RUN = ' + naviInfo.notAvoidInfo?.LIMIT_RUN)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onNaviInfoUpdate:导航引导信息--限制、禁止图标信息-禁止左转，值为0:FORBID_TURN_LEFT = ' +
        naviInfo.notAvoidInfo?.FORBID_TURN_LEFT)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onNaviInfoUpdate:导航引导信息--限制、禁止图标信息-禁止右转，值为1:FORBID_TURN_RIGHT = ' +
        naviInfo.notAvoidInfo?.FORBID_TURN_RIGHT)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onNaviInfoUpdate:导航引导信息--限制、禁止图标信息-禁止左掉头，值为2:FORBID_TURN_LEFT_ROUND = ' +
        naviInfo.notAvoidInfo?.FORBID_TURN_LEFT_ROUND)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onNaviInfoUpdate:导航引导信息--限制、禁止图标信息-禁止右掉头，值为3:FORBID_TURN_RIGHT_ROUND = ' +
        naviInfo.notAvoidInfo?.FORBID_TURN_RIGHT_ROUND)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onNaviInfoUpdate:导航引导信息--限制、禁止图标信息-禁止直行，值为4:FORBID_GO_STRAIGHT = ' +
        naviInfo.notAvoidInfo?.FORBID_GO_STRAIGHT)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onNaviInfoUpdate:导航引导信息--转向图标:iconBitmap = ' + naviInfo.iconBitmap)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onNaviInfoUpdate:导航引导信息--出口方向信息-获取出口方向信息:mExitDirectionInfo = ' +
      naviInfo.mExitDirectionInfo?.getDirectionInfo())
    LogUtil.i('Navi_Demo', 'naviListener',
      'onNaviInfoUpdate:导航引导信息--出口方向信息-获取出口名称信息:mExitDirectionInfo = ' +
      naviInfo.mExitDirectionInfo?.getExitNameInfo())
    LogUtil.i('Navi_Demo', 'naviListener',
      'onNaviInfoUpdate:导航引导信息--路径剩余红绿灯数量:routeRemainLightCount = ' + naviInfo.routeRemainLightCount)
    let length: number = naviInfo.toViaInfos?.length!
    for (let i = 0; i < length; i++) {
      let toViaInfo: AMapNaviToViaInfo = naviInfo.toViaInfos?.[i]!
      LogUtil.i('Navi_Demo', 'naviListener',
        'onNaviInfoUpdate:导航引导信息--到途经点的信息-获取途经点的索引:getViaIndex = ' + toViaInfo.getViaIndex())
      LogUtil.i('Navi_Demo', 'naviListener',
        'onNaviInfoUpdate:导航引导信息--到途经点的信息-获取自车到该途经点的剩余距离，单位：米:getDistance = ' +
        toViaInfo.getDistance())
      LogUtil.i('Navi_Demo', 'naviListener',
        'onNaviInfoUpdate:导航引导信息--到途经点的信息-获取自车到该途经点的剩余时间，单位：秒:getTime = ' +
        toViaInfo.getTime())
      LogUtil.i('Navi_Demo', 'naviListener',
        'onNaviInfoUpdate:导航引导信息--到途经点的信息-获取自车位置到前方第一个途径点的红绿灯数量:getTrafficlightNum = ' +
        toViaInfo.getTrafficlightNum())
    }
  }
  /**
   * 导航过程中的摄像头信息回调函数
   * 注意：<font color='red'>该接口仅驾车模式有效</font>
   * @param infoArray 摄像头对象数组
   * @since 5.0.0
   */
  updateCameraInfo = (infoArray: IAMapNaviCameraInfo[] | null) => {
    let length: number = infoArray?.length!
    for (let i = 0; i < length; i++) {
      let item: IAMapNaviCameraInfo = infoArray?.[i]!
      LogUtil.i('Navi_Demo', 'naviListener',
        'updateCameraInfo: + longitude:' + item.longitude + " latitude:" + item.latitude + " cameraDistance: " +
        item.cameraDistance + " cameraType: " + item.cameraType + " cameraSpeed: " + item.cameraSpeed +
          " averageSpeed: " + item.averageSpeed + " intervalLength: " + item.intervalLength +
          " reasonableSpeedInRemainDist: " + item.reasonableSpeedInRemainDist + " intervalRemainDistance: " +
        item.intervalRemainDistance)
    }
  }
  /**
   * 导航过程中的区间测速信息回调函数
   * 注意：<font color='red'>该接口仅驾车模式有效</font>
   * @param startCameraInfo  区间测速起点信息
   * @param endCameraInfo    区间测速终点信息
   * @param status           具体类型可参考{@link com.amap.api.navi.enums.CarEnterCameraStatus}
   * @since 6.0.0
   */
  updateIntervalCameraInfo =
    (startCameraInfo: IAMapNaviCameraInfo | null, endCameraInfo: IAMapNaviCameraInfo | null, status: number) => {
      LogUtil.i('Navi_Demo', 'naviListener', 'updateIntervalCameraInfo + type：' + status);
      LogUtil.i('Navi_Demo', 'naviListener',
        'updateIntervalCameraInfo + startCameraInfo + cameraSpeed：' + startCameraInfo?.cameraSpeed);
      LogUtil.i('Navi_Demo', 'naviListener',
        'updateIntervalCameraInfo + startCameraInfo + averageSpeed：' + startCameraInfo?.averageSpeed);
      LogUtil.i('Navi_Demo', 'naviListener',
        'updateIntervalCameraInfo + startCameraInfo + cameraDistance：' + startCameraInfo?.cameraDistance);
      LogUtil.i('Navi_Demo', 'naviListener',
        'updateIntervalCameraInfo + startCameraInfo + cameraType：' + startCameraInfo?.cameraType);
      LogUtil.i('Navi_Demo', 'naviListener', 'updateIntervalCameraInfo + startCameraInfo + intervalRemainDistance：' +
        startCameraInfo?.intervalRemainDistance);
      LogUtil.i('Navi_Demo', 'naviListener',
        'updateIntervalCameraInfo + startCameraInfo + reasonableSpeedInRemainDist：' +
          startCameraInfo?.reasonableSpeedInRemainDist);
      LogUtil.i('Navi_Demo', 'naviListener',
        'updateIntervalCameraInfo + startCameraInfo + latitude：' + startCameraInfo?.latitude);
      LogUtil.i('Navi_Demo', 'naviListener',
        'updateIntervalCameraInfo + startCameraInfo + longitude：' + startCameraInfo?.longitude);
      LogUtil.i('Navi_Demo', 'naviListener',
        'updateIntervalCameraInfo + startCameraInfo + intervalLength：' + startCameraInfo?.intervalLength);

      LogUtil.i('Navi_Demo', 'naviListener',
        'updateIntervalCameraInfo + endCameraInfo + cameraSpeed：' + endCameraInfo?.cameraSpeed);
      LogUtil.i('Navi_Demo', 'naviListener',
        'updateIntervalCameraInfo + endCameraInfo + averageSpeed：' + endCameraInfo?.averageSpeed);
      LogUtil.i('Navi_Demo', 'naviListener',
        'updateIntervalCameraInfo + endCameraInfo + cameraDistance：' + endCameraInfo?.cameraDistance);
      LogUtil.i('Navi_Demo', 'naviListener',
        'updateIntervalCameraInfo + endCameraInfo + cameraType：' + endCameraInfo?.cameraType);
      LogUtil.i('Navi_Demo', 'naviListener',
        'updateIntervalCameraInfo + endCameraInfo + intervalRemainDistance：' + endCameraInfo?.intervalRemainDistance);
      LogUtil.i('Navi_Demo', 'naviListener', 'updateIntervalCameraInfo + endCameraInfo + reasonableSpeedInRemainDist：' +
        endCameraInfo?.reasonableSpeedInRemainDist);
      LogUtil.i('Navi_Demo', 'naviListener',
        'updateIntervalCameraInfo + endCameraInfo + latitude：' + endCameraInfo?.latitude);
      LogUtil.i('Navi_Demo', 'naviListener',
        'updateIntervalCameraInfo + endCameraInfo + longitude：' + endCameraInfo?.longitude);
      LogUtil.i('Navi_Demo', 'naviListener',
        'updateIntervalCameraInfo + endCameraInfo + intervalLength：' + endCameraInfo?.intervalLength);
    }
  /**
   * 服务区信息回调函数
   * 注意：<font color='red'>该接口仅驾车模式有效</font>
   * @param infoArray 服务区对象数组
   * @since 5.0.0
   */
  onServiceAreaUpdate = (infoArray: IAMapServiceAreaInfo[] | null) => {
    let infoArrayLength: number = infoArray?.length!
    for (let i = 0; i < infoArrayLength; i++) {
      let info: IAMapServiceAreaInfo = infoArray?.[i]!
      LogUtil.i('Navi_Demo', 'naviListener', 'onServiceAreaUpdate:服务区信息回调:remainDist = ' + info.remainDist)
      LogUtil.i('Navi_Demo', 'naviListener', 'onServiceAreaUpdate:服务区信息回调:type = ' + info.type)
      LogUtil.i('Navi_Demo', 'naviListener', 'onServiceAreaUpdate:服务区信息回调:name = ' + info.name)
      LogUtil.i('Navi_Demo', 'naviListener',
        'onServiceAreaUpdate:服务区信息回调:coordinate.latitude = ' + info.coordinate.latitude)
      LogUtil.i('Navi_Demo', 'naviListener',
        'onServiceAreaUpdate:服务区信息回调:coordinate.longitude = ' + info.coordinate.longitude)
      LogUtil.i('Navi_Demo', 'naviListener', 'onServiceAreaUpdate:服务区信息回调:detail = ' + info.detail)
    }
  }
  /**
   * 显示路口放大图回调(实景图)。
   * 注意：<font color='red'>该接口仅驾车模式有效</font>
   * @param aMapNaviCross 路口放大图类，可以获得此路口放大图bitmap
   * @since 1.5.0
   */
  showCross = (aMapNaviCross: IAMapNaviCross | null) => {
    LogUtil.i('Navi_Demo', 'naviListener', 'IAMapNaviCross + backgroundLane：' + aMapNaviCross);
  }
  /**
   * 关闭路口放大图回调(实景图)。
   * 注意：<font color='red'>该接口仅驾车模式有效</font>
   * @since 1.5.0
   */
  hideCross = () => {
    LogUtil.i('Navi_Demo', 'naviListener', 'hideCross + 关闭路口放大图回调(实景图)');
  }
  /**
   * 显示路口放大图回调(模型图)。
   * 注意：<font color='red'>该接口仅驾车模式有效</font>
   * @param modelCross 模型图数据类,可以获取绘制模型图需要的矢量数据
   * @since 5.0.0
   */
  showModeCross = (modelCross: IAMapModelCross | null) => {
    LogUtil.i('Navi_Demo', 'naviListener', 'showModeCross + 显示路口放大图回调(模型图)：' + modelCross?.picBuf1?.length);
  }
  /**
   * 关闭路口放大图回调(模型图)。
   * 注意：<font color='red'>该接口仅驾车模式有效</font>
   */
  hideModeCross = () => {
    LogUtil.i('Navi_Demo', 'naviListener', 'hideModeCross + 关闭路口放大图回调(模型图)');
  }
  /**
   * 显示道路信息回调。
   * 注意：<font color='red'>该接口仅驾车模式有效</font>
   * @param laneInfo  道路信息，可获得当前道路信息，可用于用户使用自己的素材完全自定义显示。
   * @since 6.0.0
   */
  showLaneInfo = (laneInfo: IAMapLaneInfo | null) => {
    LogUtil.i('Navi_Demo', 'naviListener', 'showLaneInfo:显示道路信息:laneCount = ' + laneInfo?.laneCount)
    let backgroundLaneLength: number = laneInfo?.backgroundLane.length!!
    for (let i = 0; i < backgroundLaneLength; i++) {
      let backgroundLane: number = laneInfo?.backgroundLane?.[i]!
      LogUtil.i('Navi_Demo', 'naviListener', 'showLaneInfo:显示道路信息:backgroundLane = ' + backgroundLane)
    }
    let frontLaneLength: number = laneInfo?.frontLane.length!
    for (let i = 0; i < frontLaneLength; i++) {
      let frontLane: number = laneInfo?.frontLane?.[i]!
      LogUtil.i('Navi_Demo', 'naviListener', 'showLaneInfo:显示道路信息:frontLane = ' + frontLane)
    }
  }
  /**
   * 关闭道路信息回调。
   * 注意：<font color='red'>该接口仅驾车模式有效</font>
   * @since 1.5.0
   */
  hideLaneInfo = () => {
    LogUtil.i('Navi_Demo', 'naviListener', 'hideLaneInfo:关闭道路信息')
  }
  /**
   * 通知当前是否显示平行路切换。
   * 注意：<font color='red'>该接口仅驾车模式有效</font>
   * @param parallelRoadType 0表示隐藏 1 表示显示主路 2 表示显示辅路
   * @since 1.7.0
   * @deprecated 已过期，请使用{@link ParallelRoadListener#notifyParallelRoad(AMapNaviParallelRoadStatus)}
   *
   * if (aMapNaviParallelRoadStatus.getmElevatedRoadStatusFlag() == 1) {
   * // 当前在高架上
   * } else if (aMapNaviParallelRoadStatus.getmElevatedRoadStatusFlag() == 2) {
   * // 当前在高架下
   * }

   * if (aMapNaviParallelRoadStatus.getmParallelRoadStatusFlag() == 1) {
   * // 当前在主路
   * } else if (aMapNaviParallelRoadStatus.getmParallelRoadStatusFlag() == 2) {
   * // 当前在辅路
   * }

   */
  notifyParallelRoad = (parallelRoadType: IAMapNaviParallelRoadStatus | null) => {
    LogUtil.i('Navi_Demo', 'naviListener',
      'IAMapNaviParallelRoadStatus + 无主辅路（无高架）态：' + parallelRoadType?.STATUS_NONE);
    LogUtil.i('Navi_Demo', 'naviListener',
      'IAMapNaviParallelRoadStatus +  在主路（高架上）态：' + parallelRoadType?.STATUS_MAIN_ROAD);
    LogUtil.i('Navi_Demo', 'naviListener',
      'IAMapNaviParallelRoadStatus + 在辅路（高架下）态：' + parallelRoadType?.STATUS_SIDE_ROAD);
    /**
     * 主辅路标识（默认0）
     * 0：无主辅路（车标所在道路旁无主辅路）
     * 1：车标在主路（车标所在道路旁有辅路）
     * 2：车标在辅路（车标所在道路旁有主路）
     */
    LogUtil.i('Navi_Demo', 'naviListener',
      'IAMapNaviParallelRoadStatus + 主辅路标识（默认0）：' + parallelRoadType?.mParallelRoadStatusFlag);
    /**
     * 高架上下标识（默认0）
     * 0：无高架
     * 1：车标在高架上（车标所在道路有对应高架下）
     * 2：车标在高架下（车标所在道路有对应高架上）
     */
    LogUtil.i('Navi_Demo', 'naviListener',
      'IAMapNaviParallelRoadStatus + 高架上下标识（默认0）：' + parallelRoadType?.mElevatedRoadStatusFlag);
    /**
     * 道路切换状态
     * 0：非路线切换期间
     * 1：道路切换期间
     */
    LogUtil.i('Navi_Demo', 'naviListener', 'IAMapNaviParallelRoadStatus + 道路切换状态 ：' + parallelRoadType?.status);
  }
  /**
   * 巡航模式（无路线规划）下，道路设施信息更新回调。
   * 注意：<font color='red'>该接口仅驾车模式有效</font>
   * @param infos 道路设施信息
   * @since 1.8.0
   * @deprecated 已过期，建议使用{@link AimlessModeListener#onUpdateTrafficFacility(AMapNaviTrafficFacilityInfo[])}
   */
  OnUpdateTrafficFacility = (infos: IAMapNaviTrafficFacilityInfo[] | null) => {
    LogUtil.i('Navi_Demo', 'naviListener', 'OnUpdateTrafficFacility:巡航模式（无路线规划）下，道路设施信息更新')
  }
  /**
   * 回调各种类型的提示音，类似高德导航"叮".
   * 注意：<font color='red'>该接口仅驾车模式有效</font>
   * @param type 提示音类型，可以根据类型自定义播放声音
   *             <p>
   *             从<b>5.5.0</b>版本开始，提示音类型使用常量表示，具体类型可参考{@link com.amap.api.navi.enums.AMapNaviRingType}
   *             </p>
   * @since 5.5.0
   * @see com.amap.api.navi.enums.AMapNaviRingType
   */
  onPlayRing = (type: number) => {
    LogUtil.i('Navi_Demo', 'naviListener', 'onPlayRing：' + type);
  }
  /**
   * 开发者请根据实际情况返回是否正在播报语音，如果正在播报语音，请返回YES, 如果没有在播报语音，请返回NO
   * @return 如一直返回YES，SDK内部会认为外界声道较忙，导致部分文字无法吐出; 如一直返回NO，文字吐出的频率可能会过快，会出现打断的情况，所以请根据实际情况返回。
   */
  onTTSIsPlaying = () => {
    return true
  }
  /**
   * 路线规划成功回调，包括算路、导航中偏航、用户改变算路策略、行程点等触发的重算，具体算路结果可以通过{@link com.amap.api.navi.model.AMapCalcRouteResult}获取
   * 可以通过CalcRouteResult获取算路错误码、算路类型以及路线id
   * @param routeResult {@link com.amap.api.navi.model.AMapCalcRouteResult}
   * @since 6.1.0
   */
  onCalculateRouteSuccess = (routeResult: IAMapCalcRouteResult | null) => {
    LogUtil.i('Navi_Demo', 'naviListener', 'onCalculateRouteSuccess:路线规划成功errorCode = ' + routeResult?.errorCode)
    LogUtil.i('Navi_Demo', 'naviListener', 'onCalculateRouteSuccess:路线规划成功routeId = ' + routeResult?.routeId)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onCalculateRouteSuccess:路线规划成功calcRouteType = ' + routeResult?.calcRouteType)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onCalculateRouteSuccess:路线规划成功errorDetail = ' + routeResult?.errorDetail)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onCalculateRouteSuccess:路线规划成功errorDescription = ' + routeResult?.errorDescription)
    console.info('demo 算路成功')
    // 开启GPS模拟定位
    // this.naviInstance?.startMockLocation()
  }
  /**
   * 路线规划失败回调，包括算路、导航中偏航、用户改变算路策略、行程点等触发的重算，具体算路结果可以通过{@link com.amap.api.navi.model.AMapCalcRouteResult}获取
   * 可以通过CalcRouteResult获取算路错误码、算路类型以及路线id
   * @param routeResult {@link com.amap.api.navi.model.AMapCalcRouteResult}
   * @since 6.1.0
   */
  onCalculateRouteFailureForResult = (routeResult: IAMapCalcRouteResult | null) => {
    LogUtil.i('Navi_Demo', 'naviListener',
      'onCalculateRouteFailureForResult:路线规划失败errorCode = ' + routeResult?.errorCode)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onCalculateRouteFailureForResult:路线规划失败routeId = ' + routeResult?.routeId)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onCalculateRouteFailureForResult:路线规划失败calcRouteType = ' + routeResult?.calcRouteType)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onCalculateRouteFailureForResult:路线规划失败errorDetail = ' + routeResult?.errorDetail)
    LogUtil.i('Navi_Demo', 'naviListener',
      'onCalculateRouteFailureForResult:路线规划失败errorDescription = ' + routeResult?.errorDescription)
  }
  /**
   * 导航过程中道路信息通知
   * 注意：<font color='red'>该接口仅驾车模式有效</font>startMockLocation
   * <p>
   *     导航过程中针对拥堵区域、限行区域、禁行区域、道路封闭等情况的躲避通知。<br/>
   *     通知和避让信息结果可以通过{@link com.amap.api.navi.model.AMapNaviRouteNotifyData}获取
   * </p>
   * @param notifyData 通知和避让信息，详细信息请参考{@link com.amap.api.navi.model.AMapNaviRouteNotifyData}
   * @since 6.2.0
   */
  onNaviRouteNotify = (notifyData: IAMapNaviRouteNotifyData | null) => {
    LogUtil.i('Navi_Demo', 'naviListener',
      'IAMapNaviRouteNotifyData:导航过程中道路信息通知 + notifyType = ' + notifyData?.notifyType)
    LogUtil.i('Navi_Demo', 'naviListener',
      'IAMapNaviRouteNotifyData:导航过程中道路信息通知 + success = ' + notifyData?.success)
    LogUtil.i('Navi_Demo', 'naviListener',
      'IAMapNaviRouteNotifyData:导航过程中道路信息通知 + distance = ' + notifyData?.distance)
    LogUtil.i('Navi_Demo', 'naviListener',
      'IAMapNaviRouteNotifyData:导航过程中道路信息通知 + latitude = ' + notifyData?.latitude)
    LogUtil.i('Navi_Demo', 'naviListener',
      'IAMapNaviRouteNotifyData:导航过程中道路信息通知 + longitude = ' + notifyData?.longitude)
    LogUtil.i('Navi_Demo', 'naviListener',
      'IAMapNaviRouteNotifyData:导航过程中道路信息通知 + roadName = ' + notifyData?.roadName)
    LogUtil.i('Navi_Demo', 'naviListener',
      'IAMapNaviRouteNotifyData:导航过程中道路信息通知 + reason = ' + notifyData?.reason)
    LogUtil.i('Navi_Demo', 'naviListener',
      'IAMapNaviRouteNotifyData:导航过程中道路信息通知 + subTitle = ' + notifyData?.subTitle)
  }

  /**
   * 手机卫星定位信号强弱变化的回调
   *
   * @param isWeak true: 信号弱;false：信号强
   * @since 2.2.4
   */
  onGpsSignalWeak = (isWeak: boolean) => {
    LogUtil.i('Navi_Demo', 'naviListener', 'onGpsSignalWeak:' + isWeak)
  }

  /**
   * 手机卫星定位信号强弱变化的回调
   *
   * @param strength 0-未知 1-信号强 2-信号弱 3-智能定位
   * @since 7.5.0
   */
  onUpdateGPSSignalStrength = (strength: number) => {
    LogUtil.i('Navi_Demo', 'naviListener', 'onUpdateGPSSignalStrength:' + strength)
  }

  // 三端统一经纬度
  // 短导航，有路口图
  startLatLng: INaviLatLng = { latitude: 40.075248, longitude: 116.41289 }
  endLatLng: INaviLatLng = { latitude: 40.052987, longitude: 116.412316 }

  // 桥上桥下，主辅路
  // startLatLng: INaviLatLng = { latitude: 39.924132, longitude: 116.274781}
  // endLatLng: INaviLatLng = { latitude: 39.926424, longitude: 116.242812}

  // 区间测速，收费站
  // startLatLng: INaviLatLng = { latitude: 39.945486, longitude: 116.587389 }
  // endLatLng: INaviLatLng = { latitude: 40.080213, longitude: 116.602545 }

  // 京承高速
  // startLatLng: INaviLatLng = { latitude: 40.027547, longitude: 116.437898 }
  // endLatLng: INaviLatLng = { latitude: 39.90283, longitude: 116.427354 }

  // 京藏高速
  // startLatLng: INaviLatLng = { latitude: 40.125094 , longitude: 116.265117 }
  // endLatLng: INaviLatLng = { latitude: 39.90283, longitude: 116.427354 }

  // 跨省导航，服务区
  // startLatLng: INaviLatLng = { latitude: 40.027547, longitude: 116.437898 }
  // endLatLng: INaviLatLng = { latitude: 34.258731 , longitude: 108.893025 }

  //【货车——限高、禁行——横屏】设置起终点：北京站 116.427354,39.90283 —— 故宫博物院 116.397029,39.917839
  // startLatLng: INaviLatLng = { latitude: 39.90283, longitude: 116.427354 }
  // endLatLng: INaviLatLng = { latitude: 39.917839, longitude: 116.397029 }

  //【货车——限高】设置起终点：龙湖蓝海：116.437898,40.027547 —— 北京站：116.427354,39.90283
  // startLatLng: INaviLatLng = { latitude: 40.027547, longitude: 116.437898 }
  // endLatLng: INaviLatLng = { latitude: 39.90283, longitude: 116.427354 }

  //【禁限行-区间测速-主辅路桥上桥下同时展示-横屏】设置起终点 北京轻工商业大厦 116.587389,39.945486 —— 首都机场 116.602545,40.080213
  // startLatLng: INaviLatLng = { latitude: 39.945486, longitude: 116.587389 }
  // endLatLng: INaviLatLng = { latitude: 40.080213, longitude: 116.602545 }

  // 天通苑地铁站-立水桥地铁站
  // startLatLng: INaviLatLng = { latitude: 40.075248, longitude: 116.41289 }
  // endLatLng: INaviLatLng = { latitude: 40.052987, longitude: 116.412316 }

  //【超速脉冲——默认】 沙河站-北京站
  // startLatLng: INaviLatLng = { latitude: 40.125094 , longitude: 116.265117 }
  // endLatLng: INaviLatLng = { latitude: 39.90283, longitude: 116.427354 }

  // 桥上桥下
  // startLatLng: INaviLatLng = { latitude: 39.924132, longitude: 116.274781}
  // endLatLng: INaviLatLng = { latitude: 39.926424, longitude: 116.242812}

  // 区间测速起终点
  // startLatLng: INaviLatLng = { latitude:39.945486, longitude: 116.587389 }
  // endLatLng: INaviLatLng = { latitude: 40.080213, longitude: 116.602545 }

  // 唐山站-北京站
  // startLatLng: INaviLatLng = { latitude: 39.625622, longitude: 118.117903 }
  // endLatLng: INaviLatLng = { latitude: 39.90283, longitude: 116.427354 }

  //【主辅路切换】横竖屏来回切换 组件导航设置起点：阜石路高架桥 （116.242812,39.926424） 终点：西小口地铁站（116.351644,40.046873）；（初始有主辅路切换）
  // startLatLng: INaviLatLng = { latitude: 39.926424, longitude: 116.242812 }
  // endLatLng: INaviLatLng = { latitude: 40.046873, longitude: 116.351644 }

  //【黑卡--横屏--gps信号强弱】组件导航设置起点：西小口地铁站 116.351644,40.046873，终点：大屯路隧道116.393654,40.002287
  // startLatLng: INaviLatLng = { latitude: 40.046873, longitude: 116.351644 }
  // endLatLng: INaviLatLng = { latitude: 40.002287, longitude: 116.393654 }

  //【黑卡--横屏--下下路口转向箭头】下下路口转向箭头开关打开，设置起终点 龙湖蓝海引擎产业园 116.437898,40.027547 —— 奥林匹克公园 116.393096,40.009926
  // startLatLng: INaviLatLng = { latitude: 40.027547, longitude: 116.437898 }
  // endLatLng: INaviLatLng = { latitude: 40.009926, longitude: 116.393096 }

  //【黑卡--竖屏--无路口大图-锁车态】天通苑地铁站 116.41289,40.075248 终点：立水桥地铁站 116.412316,40.052987
  // startLatLng: INaviLatLng = { latitude: 40.075248, longitude: 116.41289 }
  // endLatLng: INaviLatLng = { latitude: 40.052987, longitude: 116.412316 }

  //【黑卡——竖屏——路名过长】设置起终点：龙湖蓝海引擎产业园 116.437898,40.027547  终点：故宫博物院 116.397029,39.917839
  // startLatLng: INaviLatLng = { latitude: 40.027547, longitude: 116.437898 }
  // endLatLng: INaviLatLng = { latitude: 39.917839, longitude: 116.397029 }

  //【黑卡——高架出入口牌信息】设置起终点：116.916442,40.392391 (大广高速上) 终点：116.366734,40.109739 宏福苑小区
  // startLatLng: INaviLatLng = { latitude: 40.392391, longitude: 116.916442 }
  // endLatLng: INaviLatLng = { latitude: 40.109739, longitude: 116.366734 }

  //【可视化区域——有路口大图时-横屏】设置起终点：沙河站 116.265117,40.125094 ——北京站 116.427354,39.90283
  // startLatLng: INaviLatLng = { latitude: 40.125094 , longitude: 116.265117 }
  // endLatLng: INaviLatLng = { latitude: 39.90283, longitude: 116.427354 }

  // 左侧自定义按钮-竖屏--有禁限行图标时】设置起终点 天通苑地铁站 116.41289,40.075248 终点：立水桥地铁站 116.412316,40.052987
  // startLatLng: INaviLatLng = { latitude: 40.075248, longitude: 116.41289 }
  // endLatLng: INaviLatLng = { latitude: 40.052987, longitude: 116.412316 }

  //【底部自定义View--横屏】设置起终点 天通苑地铁站 116.41289,40.075248 终点：立水桥地铁站 116.412316,40.052987
  // startLatLng: INaviLatLng = { latitude: 40.075248, longitude: 116.41289 }
  // endLatLng: INaviLatLng = { latitude: 40.052987, longitude: 116.412316 }

  //【路名--无名道路】设置起终点 711-ELEVEn(北京西小口路-号店) 116.357796,40.045466 终点：西小口（地铁站） 116.351644,40.046873
  // startLatLng: INaviLatLng = { latitude: 40.051408, longitude: 116.350223 }
  // endLatLng: INaviLatLng = { latitude: 40.046873, longitude: 116.351644 }

  //【模拟导航底部信息栏--竖屏--有路口大图时是否显示】设置起终点：沙河站 116.265117,40.125094 ——北京站 116.427354,39.90283
  // startLatLng: INaviLatLng = { latitude: 40.125094 , longitude: 116.265117 }
  // endLatLng: INaviLatLng = { latitude: 39.90283, longitude: 116.427354 }

  //【车道线--竖屏--有路口放大图】设置起终点 龙湖蓝海引擎产业园 116.437898,40.027547 —— 北苑地铁站 116.434518,40.042997
  // startLatLng: INaviLatLng = { latitude: 40.027547, longitude: 116.437898 }
  // endLatLng: INaviLatLng = { latitude: 40.042997, longitude: 116.434518 }

  // 继续导航按钮--横屏--点击取消】设置起终点 天通苑地铁站 116.41289,40.075248 终点：立水桥地铁站 116.412316,40.052987
  // startLatLng: INaviLatLng = { latitude: 40.075248, longitude: 116.41289 }
  // endLatLng: INaviLatLng = { latitude: 40.052987, longitude: 116.412316 }

  //【退出导航按钮确认--竖屏--有路口大图时】设置起终点 天通苑地铁站 116.41289,40.075248 终点：立水桥地铁站 116.412316,40.052987
  // startLatLng: INaviLatLng = { latitude: 40.075248, longitude: 116.41289 }
  // endLatLng: INaviLatLng = { latitude: 40.052987, longitude: 116.412316 }

  initTestData() {
    let arr = new ArrayList<INaviPoi>()
    /*
        for (let i = 0; i < 16; i++) {
          let location1: INaviLatLng = { latitude: 31.480612 + i * 0.01, longitude: 87.432088 + i * 0.01 }
          let test1: INaviPoi = {
            coordinate: location1
          }
          arr.add(test1)
        } */

    //途径点
    let location1: INaviLatLng = { latitude: 39.9404, longitude: 116.3554 }
    let location2: INaviLatLng = { latitude: 39.89491, longitude: 116.322056 }
    let location3: INaviLatLng = { latitude: 39.941626, longitude: 116.435842 }
    let location4: INaviLatLng = { latitude: 39.865246, longitude: 116.378517 }
    let location5: INaviLatLng = { latitude: 39.909187, longitude: 116.397451 }
    let location6: INaviLatLng = { latitude: 39.89491, longitude: 116.322056 }
    let location7: INaviLatLng = { latitude: 39.992806, longitude: 116.310905 }
    let location8: INaviLatLng = { latitude: 40.053034, longitude: 116.306295 }
    let location9: INaviLatLng = { latitude: 39.998521, longitude: 116.469409 }
    let location10: INaviLatLng = { latitude: 39.866770, longitude: 116.303819 }
    let location11: INaviLatLng = { latitude: 39.933801, longitude: 116.434133 }
    let location12: INaviLatLng = { latitude: 39.924499, longitude: 116.434584 }
    let location13: INaviLatLng = { latitude: 39.901063, longitude: 116.417093 }
    let location14: INaviLatLng = { latitude: 40.080525, longitude: 116.603039 }
    let location15: INaviLatLng = { latitude: 39.510561, longitude: 116.429172 }
    let location16: INaviLatLng = { latitude: 40.046873, longitude: 116.351644 }

    let test1: INaviPoi = {
      coordinate: location1
    }
    let test2: INaviPoi = {
      coordinate: location2
    }
    let test3: INaviPoi = {
      coordinate: location3
    }
    let test4: INaviPoi = {
      coordinate: location4
    }
    let test5: INaviPoi = {
      coordinate: location5
    }
    let test6: INaviPoi = {
      coordinate: location6
    }
    let test7: INaviPoi = {
      coordinate: location7
    }
    let test8: INaviPoi = {
      coordinate: location8
    }
    let test9: INaviPoi = {
      coordinate: location9
    }
    let test10: INaviPoi = {
      coordinate: location10
    }
    let test11: INaviPoi = {
      coordinate: location11
    }
    let test12: INaviPoi = {
      coordinate: location12
    }
    let test13: INaviPoi = {
      coordinate: location13
    }
    let test14: INaviPoi = {
      coordinate: location14
    }
    let test15: INaviPoi = {
      coordinate: location15
    }
    let test16: INaviPoi = {
      coordinate: location16
    }

    arr.add(test1)
    arr.add(test2)
    arr.add(test3)
    arr.add(test4)
    arr.add(test5)
    arr.add(test6)
    arr.add(test6)
    arr.add(test7)
    arr.add(test8)
    arr.add(test9)
    arr.add(test10)
    arr.add(test11)
    arr.add(test12)
    arr.add(test13)
    arr.add(test14)
    arr.add(test15)
    arr.add(test16)
    this.wayPoints = arr
  }

  goback() {
    //其他操作
    console.info('退出导航页面2')
    // >>>>>>>> 导航反初始化时序 <<<<<<<<<<<<<<
    // 停止mock定位信息
    // this.naviInstance?.stopMockLocation();
    // 移除外部监听
    this.naviInstance?.removeAMapNaviListener(this.listener)
    // 停止导航
    this.naviInstance?.stopNavi()
    // 销毁导航单例对象
    AMapNaviFactory.destroyAMapNaviInstance()
    this.pageInfos.pop()
  }

  build() {
    NavDestination() {
      AMapNaviComponent({
        appCustomerConfig: {
          mType: AmapNaviType.Driver, //引擎类型（驾车、骑行、步行）。1.0版本只支持驾车
          //默认模拟导航
          // mNaviType: NaviType.EMULATOR,
          //实时导航
          mNaviType: NaviType.GPS,
          start: {
            coordinate: this.startLatLng
          }, //起点
          end: {
            coordinate: this.endLatLng
          }, //终点
          // wayPoints: this.wayPoints, //途经点
          mRouteStrategy: 10, //设置默认规划路线策略
          serviceAreaDetailsEnable: true, //服务区信息
          // leftTopCustomComponent: this.titleBuilder,//左上角自定义组件
          // bottomCustomComponent: this.bottomCustomComponentBuilder,//底部自定义组件
          goBack: () => {
            this.goback()
          },
          isNeedCalculateRouteWhenPresent: true,
			    aMapNaviViewOptions: this.options
        }
      })
    }.title('导航组件')
    .hideTitleBar(true)
    .onBackPressed(() => {
      this.goback()
      return true
    })
  }
}