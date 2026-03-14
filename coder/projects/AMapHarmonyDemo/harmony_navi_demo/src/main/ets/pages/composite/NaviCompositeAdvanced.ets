import {
  AMapCarInfo,
  AMapNaviBroadcastMode,
  AMapNaviFactory,
  AmapNaviPage,
  AmapNaviParams,
  AMapNaviPath,
  AmapNaviType,
  AMapPageType,
  IAMapCalcRouteResult,
  IAMapNavi,
  NaviLatLng,
  NaviPoi,
  NaviType,
  PathPlanningStrategy
} from '@amap/amap_lbs_navi';
import { ArrayList, HashMap } from '@kit.ArkTS';
import { promptAction } from '@kit.ArkUI';

/**
 * 导航组件-基础功能
 */
@Component
export struct NaviCompositeAdvanced {
  @Consume('pageInfos') pageInfos: NavPathStack;
  @State isNeedCalculateRouteWhenPresent: boolean = false
  @State isUseInnerVoice: boolean = true
  @State voiceMode: AMapNaviBroadcastMode = AMapNaviBroadcastMode.Detailed
  naviInstance: IAMapNavi | null = null;

  aboutToAppear(): void {
    this.initNavi();
  }

  initNavi() {
    const appkey = '此处替换官网申请的Key'
    this.naviInstance = AMapNaviFactory.getAMapNaviInstance(getContext().getApplicationContext(), appkey)
  }

  build() {
    NavDestination() {
      Column({ space: 20 }) {
        this.NeedCalculateRouteWhenPresent()
        Divider()
        this.InstanceWhenNaviExit()
        Divider()
        this.UseInnerVoice()
        Divider()
        this.BroadcastMode()
        Divider()
        this.CarInfoBuild()
        Divider()
        this.RouteStrategy()
        Divider()
        this.CarDirectionMode()
        Divider()
        this.ScaleAutoChange()
      }
    }
    .title("导航组件-高级功能")
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true;
    })
  }

  @Builder
  NeedCalculateRouteWhenPresent() {
    Row() {
      Button(this.isNeedCalculateRouteWhenPresent ? "内部算路启动导航组件" : '使用上一次算路启动导航组件')
        .onClick(() => {
          let start = new NaviPoi("立水桥(北5环)", new NaviLatLng(40.045452, 116.357802), "");
          //途经点
          let poiList = new ArrayList<NaviPoi>();
          //终点
          let end = new NaviPoi("新三余公园(南5环)", new NaviLatLng(40.022915, 116.374329), "");

          if (!this.isNeedCalculateRouteWhenPresent) {
            //模拟算一次路
            this.initNavi()
            // this.naviInstance?.addAMapNaviListener({
            //   //算路成功回调
            //   onCalculateRouteSuccess: (routeResult: IAMapCalcRouteResult | null) => {
            //     if (routeResult !== null && routeResult.routeId) {
            //       const routeIds: Int32Array = routeResult.routeId;
            //       const paths: HashMap<number, AMapNaviPath> | null = this.naviInstance!.getNaviPaths();
            //       if (paths === null || paths.length === 0) {
            //         promptAction.showToast({ message: "未获取到路径" });
            //         return;
            //       }
            //       this.naviInstance?.selectRouteId(routeIds[1]);
            //       this.naviInstance?.startNavi(NaviType.GPS);
            //     }
            //   }
            // })

            this.naviInstance!.calculateDriveRouteForPoi(start, end, poiList,
              PathPlanningStrategy.DRIVING_MULTIPLE_ROUTES_DEFAULT);
          }

          let params =
            AmapNaviParams.buildForPageType(start, poiList, end, AmapNaviType.Driver, AMapPageType.NAVI);
          params.setNeedCalculateRouteWhenPresent(this.isNeedCalculateRouteWhenPresent);
          params.setScaleAutoChangeEnable(true);
          AmapNaviPage.getInstance().showRoutePage(params, null);
        })
      Row() {
        Checkbox()
          .select(this.isNeedCalculateRouteWhenPresent)
          .selectedColor(0xed6f21)
          .shape(CheckBoxShape.CIRCLE)
          .onChange((value: boolean) => {
            this.isNeedCalculateRouteWhenPresent = value
          })
        Text('内部是否算路')
      }
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ left: 10, right: 10 })
  }

  @Builder
  InstanceWhenNaviExit() {
    Row() {
      Button("退出导航后不销毁导航实例")
        .onClick(() => {
          const start = new NaviPoi("北京首都机场", new NaviLatLng(40.080525, 116.603039), "B000A28DAE");
          //途经点
          const poiList = new ArrayList<NaviPoi>();
          poiList.add(new NaviPoi("故宫", new NaviLatLng(39.918058, 116.397026), "B000A8UIN8"));
          //终点
          const end = new NaviPoi("北京大学", new NaviLatLng(39.941823, 116.426319), "B000A816R6");

          // 组件参数配置
          const params =
            AmapNaviParams.buildForPageType(start, poiList, end, AmapNaviType.Driver, AMapPageType.NAVI);

          params.setNeedDestroyDriveManagerInstanceWhenNaviExit(false);
          params.setNaviMode(NaviType.GPS);
          params.setScaleAutoChangeEnable(true);
          AmapNaviPage.getInstance().showRoutePage(params, null);
        })

      Button("直接进入导航")
        .onClick(() => {
          //构建导航组件配置类，没有传入起点，所以起点默认为 “我的位置”
          const params = AmapNaviParams.buildForPageType(null, null, null, AmapNaviType.Driver, AMapPageType.NAVI);
          params.setNaviMode(NaviType.GPS);
          params.setScaleAutoChangeEnable(true);
          params.setNeedCalculateRouteWhenPresent(false)
          //启动导航组件
          AmapNaviPage.getInstance().showRoutePage(params, null);
        })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ left: 10, right: 10 })
  }

  @Builder
  UseInnerVoice() {
    Row() {
      Button(this.isUseInnerVoice ? "使用内部语音" : '不使用内部语音')
        .onClick(() => {
          const start = new NaviPoi("北京首都机场", new NaviLatLng(40.080525, 116.603039), "B000A28DAE");
          //途经点
          const poiList = new ArrayList<NaviPoi>();
          poiList.add(new NaviPoi("故宫", new NaviLatLng(39.918058, 116.397026), "B000A8UIN8"));
          //终点
          const end = new NaviPoi("北京大学", new NaviLatLng(39.941823, 116.426319), "B000A816R6");

          // 组件参数配置
          const params =
            AmapNaviParams.buildForPageType(start, poiList, end, AmapNaviType.Driver, AMapPageType.NAVI);

          params.setUseInnerVoice(this.isUseInnerVoice)
          params.setScaleAutoChangeEnable(true);

          AmapNaviPage.getInstance().showRoutePage(params, null);
        })

      Row() {
        Checkbox()
          .select(this.isUseInnerVoice)
          .selectedColor(0xed6f21)
          .shape(CheckBoxShape.CIRCLE)
          .onChange((value: boolean) => {
            this.isUseInnerVoice = value
          })
        Text('是否使用内部语音')
      }
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ left: 10, right: 10 })
  }

  @Builder
  BroadcastMode() {
    Row() {
      Button('开始导航')
        .onClick(() => {
          const start = new NaviPoi("北京首都机场", new NaviLatLng(40.080525, 116.603039), "B000A28DAE");
          //途经点
          const poiList = new ArrayList<NaviPoi>();
          poiList.add(new NaviPoi("故宫", new NaviLatLng(39.918058, 116.397026), "B000A8UIN8"));
          //终点
          const end = new NaviPoi("北京大学", new NaviLatLng(39.941823, 116.426319), "B000A816R6");

          // 组件参数配置
          const params =
            AmapNaviParams.buildForPageType(start, poiList, end, AmapNaviType.Driver, AMapPageType.NAVI);

          params.setBroadcastMode(this.voiceMode)
          params.setScaleAutoChangeEnable(true);

          AmapNaviPage.getInstance().showRoutePage(params, null);
        })

      Row() {
        Radio({ value: 'voiceMode1', group: 'voiceMode' })
          .checked(true)
          .onChange((value: boolean) => {
            if (value) {
              this.voiceMode = AMapNaviBroadcastMode.Concise
            }
          })
        Text('简洁播报')
      }

      Row() {
        Radio({ value: 'voiceMode2', group: 'voiceMode' })
          .checked(false)
          .onChange((value: boolean) => {
            if (value) {
              this.voiceMode = AMapNaviBroadcastMode.Detailed
            }
          })
        Text('详细播报')
      }

      Row() {
        Radio({ value: 'voiceMode3', group: 'voiceMode' })
          .checked(false)
          .onChange((value: boolean) => {
            if (value) {
              this.voiceMode = AMapNaviBroadcastMode.Mute
            }
          })
        Text('静音模式')
      }
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ left: 10, right: 10 })
  }

  @Builder
  CarInfoBuild() {
    Row() {
      Button('根据车辆信息算路')
        .onClick(() => {
          const start = new NaviPoi("杨镇客运站", new NaviLatLng(40.175088, 116.826374), "");

          //终点
          const end = new NaviPoi("北京现代汽车有限公司第二工厂", new NaviLatLng(40.091921, 116.648614), "");

          // 组件参数配置
          const params =
            AmapNaviParams.buildForPageType(start, null, end, AmapNaviType.Driver, AMapPageType.ROUTE);

          let carInfo: AMapCarInfo = new AMapCarInfo()
          carInfo.setCarType("1");
          carInfo.setCarNumber('京B66666');
          carInfo.setVehicleSize('0');
          carInfo.setVehicleLoad('52.0');
          carInfo.setVehicleWeight('50.0');
          carInfo.setVehicleWidth('3.0');
          carInfo.setVehicleLength('5.0');
          carInfo.setVehicleHeight('2.0');
          carInfo.setVehicleAxis('0');
          carInfo.setRestriction(true);

          params.setCarInfo(carInfo);
          params.setScaleAutoChangeEnable(true);

          AmapNaviPage.getInstance().showRoutePage(params, null);
        })
    }
  }

  @Builder
  RouteStrategy() {
    Row() {
      Button("根据策略算路-10")
        .onClick(() => {
          const start = new NaviPoi("天坛公园", new NaviLatLng(39.887895, 116.417337), "");

          //终点
          const end = new NaviPoi("应寺村村委会", new NaviLatLng(39.644050, 116.752444), "");

          // 组件参数配置
          const params =
            AmapNaviParams.buildForPageType(start, null, end, AmapNaviType.Driver, AMapPageType.ROUTE);
          params.setRouteStrategy(PathPlanningStrategy.DRIVING_MULTIPLE_ROUTES_DEFAULT) //策略-1到20
          params.setScaleAutoChangeEnable(true);
          AmapNaviPage.getInstance().showRoutePage(params, null);
        })
    }
  }

  @Builder
  CarDirectionMode() {
    Row() {
      Button("导航视角-车头朝上")
        .onClick(() => {
          const start = new NaviPoi("天坛公园", new NaviLatLng(39.887895, 116.417337), "");

          //终点
          const end = new NaviPoi("应寺村村委会", new NaviLatLng(39.644050, 116.752444), "");

          // 组件参数配置
          const params =
            AmapNaviParams.buildForPageType(start, null, end, AmapNaviType.Driver, AMapPageType.NAVI);
          params.setCarDirectionMode(0) //0-车头朝上 1-正北朝上
          params.setScaleAutoChangeEnable(true);
          AmapNaviPage.getInstance().showRoutePage(params, null);
        })
    }
  }

  @Builder
  ScaleAutoChange() {
    Row() {
      Button("开启比例尺智能缩放导航")
        .onClick(() => {
          const start = new NaviPoi("天坛公园", new NaviLatLng(39.887895, 116.417337), "");

          //终点
          const end = new NaviPoi("应寺村村委会", new NaviLatLng(39.644050, 116.752444), "");

          // 组件参数配置
          const params =
            AmapNaviParams.buildForPageType(start, null, end, AmapNaviType.Driver, AMapPageType.NAVI);
          params.setScaleAutoChangeEnable(true) //开启智能缩放
          params.setNaviMode(NaviType.EMULATOR) //模拟导航
          AmapNaviPage.getInstance().showRoutePage(params, null);
        })
    }
  }
}