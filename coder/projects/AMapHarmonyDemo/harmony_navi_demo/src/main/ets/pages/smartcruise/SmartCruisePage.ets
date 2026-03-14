import {
  IAMapNavi,
  IAMapNaviTrafficFacilityInfo,
  MapViewComponent,
  MapViewManager,
  MapView,
  MapViewCreateCallback,
  IAimlessModeListener,
  IAimLessModeCongestionInfo,
  AMapNaviPath,
  INaviLatLng
} from "@amap/amap_lbs_navi";

import { AMapNaviFactory } from "@amap/amap_lbs_navi";
import { BusinessError } from '@ohos.base';
import type { AimLessModeStat } from "@amap/amap_lbs_navi";
import { MockLocationManager } from "../../mock/manger/MockLocationManager";
import { promptAction } from "@kit.ArkUI";
import { ArrayList } from "@kit.ArkTS";

class AimlessModeListenerImpl implements IAimlessModeListener {
  onUpdateTrafficFacility(infos: IAMapNaviTrafficFacilityInfo[]): void {
    console.info('SmartCruiseWithMap', '回调成功: onUpdateTrafficFacility');
    if (!infos || infos.length === 0) {
      console.info('SmartCruiseWithMap', '设施列表为空');
      return;
    }
    console.info('SmartCruiseWithMap', `接收到 ${infos.length} 个交通设施`);
    infos.forEach((item, idx) => {
      console.info('SmartCruiseWithMap',
        `设施[${idx}]: type=${item.type}, dist=${item.distance}m, lon=${item.lon}, lat=${item.lat}`
      );
    });

    const first = infos[0];
    let typeText = '未知设施';
    if (first.type === 1) typeText = '电子眼';
    else if (first.type === 2) typeText = '服务区';
    else if (first.type === 3) typeText = '收费站';
    else if (first.type === 4 || first.type === 5) typeText = '摄像头';

    const speedPart = first.limitSpeed > 0 ? `限速${first.limitSpeed}km/h` : '';
    const message = `前方${first.distance}米 ${typeText} ${speedPart}`.trim();

    promptAction.showToast({
      message: message,
      duration: 3000,
      bottom: '35%'
    });
  }

  onUpdateAimlessModeElecCameraInfo(cameraInfo: IAMapNaviTrafficFacilityInfo[]): void {
    console.info('SmartCruiseWithMap', '回调成功: onUpdateAimlessModeElecCameraInfo');
    if (!cameraInfo || cameraInfo.length === 0) {
      console.info('SmartCruiseWithMap', '电子眼列表为空');
      return;
    }
    console.info('SmartCruiseWithMap', `接收到 ${cameraInfo.length} 个电子眼`);
    cameraInfo.forEach((cam, idx) => {
      const speedText = cam.limitSpeed > 0 ? `限速${cam.limitSpeed}km/h` : '无明确限速';
      console.info('SmartCruiseWithMap',
        `电子眼[${idx}]: ${speedText}, 距离=${cam.distance}m, lon=${cam.lon}, lat=${cam.lat}`
      );
    });

    const cam = cameraInfo[0];
    const speedText = cam.limitSpeed ? `限速${cam.limitSpeed}km/h` : '';
    const message = `前方${cam.distance}米 电子眼 ${speedText}`;
    promptAction.showToast({
      message: message,
      duration: 3500,
      bottom: '50%'
    });
  }

  updateAimlessModeStatistics(stat: AimLessModeStat): void {
    console.info('SmartCruiseWithMap', '回调成功: updateAimlessModeStatistics');
    console.info('SmartCruiseWithMap',
      `统计数据: totalLength=${stat.totalLength}m, totalTrafficLength=${stat.totalTrafficLength}m`
    );

    const distKm = (stat.totalLength / 1000).toFixed(1);
    const timeMin = Math.floor(stat.totalTrafficLength / 60);
    const message = `巡航：${distKm}km / ${timeMin}分钟`;
    promptAction.showToast({
      message: message,
      duration: 4000,
      bottom: '25%'
    });
  }

  updateAimlessModeCongestionInfo(info: IAimLessModeCongestionInfo): void {
    console.info('SmartCruiseWithMap', '回调成功: updateAimlessModeCongestionInfo');
    console.info('SmartCruiseWithMap',
      `拥堵信息: roadName="${info.roadName}", status=${info.status}, length=${info.length}m, etaTime=${info.etaTime}s`
    );

    const statusMap = ['畅通', '缓行', '较堵', '拥堵'];
    const statusStr = statusMap[info.status] || '未知';
    const lengthKm = (info.length / 1000).toFixed(1);
    const etaMin = Math.floor(info.etaTime / 60);
    const message = `${info.roadName} ${statusStr} ${lengthKm}km(${etaMin}分钟)`;
    promptAction.showToast({
      message: message,
      duration: 5000,
      bottom: '75%'
    });
  }
}

@Component
export struct SmartCruisePage {
  @Consume('pageInfos') pageInfos: NavPathStack;
  private mapView?: MapView;
  private mAMapNavi?: IAMapNavi;
  private aimlessListener = new AimlessModeListenerImpl();
  private isCruiseStarted: boolean = false;

  //  控制地图是否渲染
  @State private shouldRenderMap: boolean = false;

  //  控制是否启用模拟导航模式（true=模拟，false=真实GPS巡航）
  private useMockMode: boolean = false; //  修改这里可切换模式
  @Consume('isPageHide') @Watch('pageChange') isPageHide: boolean
  private mapViewCreateCallback: MapViewCreateCallback = (mapview?: MapView) => {
    if (!mapview || this.mapView) return;
    this.mapView = mapview;
    this.mapView.onCreate();
    console.info('SmartCruiseWithMap', '地图已创建');

    if (!this.isCruiseStarted) {
      this.startCruise();
      this.isCruiseStarted = true;
    }
  };
  pageChange(changedPropertyName: string) {
    if (this.isPageHide === true) {
      this.onPageHide()
    } else {
      this.onPageShow()
    }
  }

  onPageShow(): void {
    this.mapView?.onResume();
  }

  onPageHide(): void {
    this.mapView?.onPause();
  }
  private startCruise(): void {
    if (!this.mAMapNavi) return;

    // 区分模式
    if (this.useMockMode) {
      this.startMockCruise();
    } else {
      this.startRealCruise();
    }
  }

  /**
   * 启动真实 GPS 智能巡航（无目的地模式）
   */
  private startRealCruise(): void {
    this.mAMapNavi!.addAimlessModeListener(this.aimlessListener);
    this.mAMapNavi!.startAimlessMode(3); // 智能模式
    console.info('SmartCruiseWithMap', ' 真实 GPS 智能巡航已启动');
  }

  /**
   * 启动模拟导航巡航
   */
  private startMockCruise(): void {
    // 设置模拟定位管理器
    this.mAMapNavi!.setMockLocationManager(MockLocationManager.getInstance());

    // 添加算路监听
    this.mAMapNavi!.addAMapNaviListener({
      onCalculateRouteSuccess: () => {
        console.info('SmartCruiseWithMap', ' 算路成功，开始模拟巡航');
        const path = this.mAMapNavi?.getNaviPath();
        if (path) {
          this.mAMapNavi?.setEmulatorNaviSpeed(10); // 模拟速度：10 km/h
          this.mAMapNavi?.startAimlessMode(3);     // 启动无目的地模式
          this.mAMapNavi?.startMockLocation(path); // 开始模拟移动
          console.info('SmartCruiseWithMap', ' 模拟位置已启动');
        }
      },
      onCalculateRouteFailure: (errorCode) => {
        console.error('SmartCruiseWithMap', ' 算路失败:', errorCode);
        promptAction.showToast({
          message: `算路失败: ${errorCode}`,
          duration: 3000
        });
      }
    });

    // 定义起点和终点（示例路径）
    const startList = new ArrayList<INaviLatLng>();
    startList.add({ latitude: 40.037530, longitude: 116.417580 }); // 中关村软件园北

    const endList = new ArrayList<INaviLatLng>();
    endList.add({ latitude: 40.035570, longitude: 116.417020 }); // 世界公园附近

    const wayPoints = new ArrayList<INaviLatLng>(); // 无途经点

    // 发起算路请求
    try {
      const success = this.mAMapNavi!.calculateDriveRoute(startList, endList, wayPoints, 0);
      if (!success) {
        console.error('SmartCruiseWithMap', ' 路径规划调用失败');
        promptAction.showToast({ message: '路径规划请求失败' });
      }
    } catch (error) {
      console.error('SmartCruiseWithMap', ' 路径规划异常:', error);
      promptAction.showToast({ message: '路径规划异常' });
    }

    // 添加监听（注意：不能重复添加）
    this.mAMapNavi!.addAimlessModeListener(this.aimlessListener);
  }

  private stopCruise(): void {
    if (this.mAMapNavi) {
      this.mAMapNavi.stopAimlessMode();
      if (this.useMockMode) {
        this.mAMapNavi.stopMockLocation(); // 停止模拟
      }
      this.mAMapNavi.removeAimlessModeListener(this.aimlessListener);
    }
    this.isCruiseStarted = false;
  }

  aboutToAppear(): void {
    const context = getContext();
    const appContext = context.getApplicationContext();
    const appKey = '此处替换为官网的key';

    //  1. 初始化 SDK（注入 Key）
    this.mAMapNavi = AMapNaviFactory.getAMapNaviInstance(appContext, appKey);
    console.info('SmartCruiseWithMap', ' 高德导航实例创建完成，Key 已注入');

    // 2. 注册地图回调
    MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);

    // 3. 允许渲染地图
    this.shouldRenderMap = true;
  }

  aboutToDisappear(): void {
    this.stopCruise();

    if (this.mapView) {
      this.mapView.onDestroy();
      this.mapView = undefined;
    }

    MapViewManager.getInstance().unregisterMapViewCreatedCallback(this.mapViewCreateCallback);

    if (this.mAMapNavi) {
      AMapNaviFactory.destroyAMapNaviInstance();
      this.mAMapNavi = undefined
    }
  }

  build() {
    NavDestination() {
      Column() {
        if (this.shouldRenderMap) {
          MapViewComponent({ type: 'native', soName: 'AMapOpenNaviJNI' })
            .width('100%')
            .height('100%')
        } else {
          Text('地图初始化中...')
            .fontSize(16)
            .textAlign(TextAlign.Center)
            .width('100%')
            .height('100%')
        }
      }
      .width('100%')
      .height('100%')
    }
    .title('智能巡航')
    .onBackPressed(() => {
      this.aboutToDisappear();
      this.pageInfos.pop();
      return true;
    })
    .onWillDisappear(() => {
      this.aboutToDisappear();
    })
  }
}
