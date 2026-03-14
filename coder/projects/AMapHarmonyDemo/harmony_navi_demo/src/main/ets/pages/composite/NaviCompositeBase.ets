import {
  AMapCarInfo,
  AMapNaviFactory,
  AmapNaviType,
  AMapNaviViewTrackingMode,
  NaviLatLng,
  NaviPoi,
  NaviType,
  INaviInfoCallback,
  AMapPageType,
  AMapNaviLocation,
  AmapNaviParams,
  AmapNaviPage
} from '@amap/amap_lbs_navi';
import { ArrayList } from '@kit.ArkTS';

/**
 * 导航组件-基础功能
 */
@Component
export struct NaviCompositeBase {
  @Consume('pageInfos') pageInfos: NavPathStack;

  aboutToAppear(): void {
    this.initNavi();
  }

  initNavi() {
    const appkey = '此处替换官网申请的Key'
    AMapNaviFactory.getAMapNaviInstance(getContext().getApplicationContext(), appkey)
  }

  private naviInfoCallback: INaviInfoCallback = {
    onExitPage: (pageType: AMapPageType) => {
      console.log(`INaviInfoCallback-------onExitPage: ${pageType}`);
    },
    onInitNaviFailure: () => {
      console.log(`INaviInfoCallback-------onInitNaviFailure`);
    },
    onStartNavi: (type: NaviType) => {
      console.log(`INaviInfoCallback-------onStartNavi: ${type}`);
    },
    //算路成功回调
    onCalculateRouteSuccess: (ids: Int32Array) => {
      console.log(`INaviInfoCallback-------onCalculateRouteSuccess: ${ids}`);
    },
    //驾车路径规划失败后的回调函数。
    onCalculateRouteFailure: (errorInfo: number) => {
      console.log(`INaviInfoCallback-------onCalculateRouteFailure: ${errorInfo}`);
    },
    //重新规划的回调
    onReCalculateRoute: (type: number) => {
      console.log(`INaviInfoCallback-------onReCalculateRoute: ${type}`);
    },
    //切换算路偏好回调
    onStrategyChanged: (strategy: number) => {
      console.log(`INaviInfoCallback-------onStrategyChanged: ${strategy}`);
    },
    //驾车路径导航到达某个途经点的回调函数。
    onArrivedWayPoint: (wayID: number) => {
      console.log(`INaviInfoCallback-------onArrivedWayPoint: ${wayID}`);
    },
    //到达目的地后回调函数。
    onArriveDestination: (isEmulaterNavi: boolean) => {
      console.log(`INaviInfoCallback-------onArriveDestination: ${isEmulaterNavi}`);
    },
    //当GPS位置有更新时的回调函数
    onLocationChange: (location: AMapNaviLocation | null) => {
      console.log(`INaviInfoCallback-------onLocationChange: ${JSON.stringify(location)}`);
    },
    //导航播报信息回调
    onGetNavigationText: (text: string) => {
      console.log(`INaviInfoCallback-------onGetNavigationText: ${text}`);
    },
    //导航视角变化回调
    onNaviDirectionChanged: (naviMode: AMapNaviViewTrackingMode) => {
      console.log(`INaviInfoCallback-------onNaviDirectionChanged: ${naviMode}`);
    },
    //播报模式变化回调
    onBroadcastModeChanged: (mode: number) => {
      console.log(`INaviInfoCallback-------onBroadcastModeChanged: ${mode}`);
    },
    //组件地图白天黑夜模式切换回调
    onMapTypeChanged: (mapType: number) => {
      console.log(`INaviInfoCallback-------onMapTypeChanged: ${mapType}`);
    },
    //昼夜模式设置变化回调
    onDayAndNightModeChanged: (mode: number) => {
      console.log(`INaviInfoCallback-------onDayAndNightModeChanged: ${mode}`);
    },
    //比例尺智能缩放设置变化回调
    onScaleAutoChanged: (enable: boolean) => {
      console.log(`INaviInfoCallback-------onScaleAutoChanged: ${enable}`);
    },
    //停止播报回调
    onStopSpeaking: () => {
      console.log(`INaviInfoCallback-------onStopSpeaking:`);
    }
  };

  build() {
    NavDestination() {
      Column({ space: 10 }) {
        Button("无起终点启动导航组件")
          .onClick(() => {
            //构建导航组件配置类，没有传入起点，所以起点默认为 “我的位置”
            const params = new AmapNaviParams();
            params.setScaleAutoChangeEnable(true);
            //启动导航组件
            AmapNaviPage.getInstance().showRoutePage(params, null);
          })

        Button("有起终点启动导航组件-进入路径规划页面")
          .onClick(() => {
            const start = new NaviPoi("北京首都机场", new NaviLatLng(40.080525,116.603039), "B000A28DAE");
            //途经点
            const poiList = new ArrayList<NaviPoi>();
            poiList.add(new NaviPoi("故宫", new NaviLatLng(39.918058,116.397026), "B000A8UIN8"));
            //终点
            const end = new NaviPoi("北京大学", new NaviLatLng(39.992873,116.310918), "B000A816R6");

            const params = AmapNaviParams.buildForPoi(start, poiList, end, AmapNaviType.Driver);
            params.setScaleAutoChangeEnable(true);

            AmapNaviPage.getInstance().showRoutePage(params, this.naviInfoCallback);

            //7秒以后自动执行退出
            // setTimeout(() => {
            //   AmapNaviPage.getInstance().exitRoutePage();
            // }, 7000)
          })
        Button("有起终点启动导航组件-进入导航页面")
          .onClick(() => {
            const start = new NaviPoi("北京首都机场", new NaviLatLng(40.080525,116.603039), "B000A28DAE");
            //途经点
            const poiList = new ArrayList<NaviPoi>();
            poiList.add(new NaviPoi("故宫", new NaviLatLng(39.918058,116.397026), "B000A8UIN8"));
            //终点
            const end = new NaviPoi("北京大学", new NaviLatLng(39.992873,116.310918), "B000A816R6");

            const params = AmapNaviParams.buildForPageType(start, poiList, end, AmapNaviType.Driver, AMapPageType.NAVI);
            params.setScaleAutoChangeEnable(true);

            AmapNaviPage.getInstance().showRoutePage(params, this.naviInfoCallback);
          })
      }
    }
    .title("导航组件-基础功能")
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true;
    })
  }

  /**
   * 自定义中间靠左组件
   */
  @Builder
  customMiddleViewBuilder() {
    Button('按钮1')
      .width(100)
      .height(100)
      .type(ButtonType.Normal)
      .backgroundColor('orange')
  }

  /**
   * 自定义底部组件
   */
  @Builder
  customBottomViewBuilder() {
    Button('按钮2')
      .width('100%')
      .height(60)
      .type(ButtonType.Normal)
      .backgroundColor('blue')
  }

  /**
   * 自定义底部靠上组件
   */
  @Builder
  customAboveToBottomViewBuilder() {
    Row() {

    }
    .width("100%")
    .height(50)
    .backgroundColor(Color.Orange)
  }
}