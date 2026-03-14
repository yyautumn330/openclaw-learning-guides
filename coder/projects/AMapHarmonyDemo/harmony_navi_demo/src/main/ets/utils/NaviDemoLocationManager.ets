import { NaviTestLocation } from '../utils/NaviDemoLocationType';
import { geoLocationManager } from '@kit.LocationKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { AMapLocation } from '@amap/amap_lbs_location';

export class NaviDemoLocationManager {
  private static instance: NaviDemoLocationManager;
  // private startLocation: INaviLatLng
  // private endLocation: INaviLatLng
  private location: NaviTestLocation

  static getInstance(): NaviDemoLocationManager {
    if (!NaviDemoLocationManager.instance) {
      NaviDemoLocationManager.instance = new NaviDemoLocationManager();
    }
    return NaviDemoLocationManager.instance;
  }

  private constructor() {
    //场景
    //红绿灯测试
    // this.startLocation = { latitude: 39.993266, longitude: 116.473193 }
    // this.endLocation = { latitude: 39.917337, longitude: 116.397056 }
    this.location = {
      start: { latitude: 39.993266, longitude: 116.473193 },
      end: { latitude: 39.917337, longitude: 116.397056 }
    }
    //主辅路
    // this.location = {
    //   start: { latitude: 39.833187, longitude: 116.458887 },
    //   end: {latitude: 39.945834, longitude: 116.397056 }
    // }
    //服务区
    // this.location = {
    //   start: { latitude: 40.045939, longitude: 116.806406 },
    //   end: { latitude: 40.063907, longitude: 116.927041 }
    // }
    //路口大图
    // this.location = {
    //   start: { latitude: 39.993306, longitude: 116.473004 },
    //   end: { latitude: 40.01224, longitude: 116.479406 }
    // }
    //区间测速（脉速表下拉）
    // startLatLng: NaviLatLng = new NaviLatLng(30.069625, 120.282487)
    // endLatLng: NaviLatLng = new NaviLatLng(30.116183, 120.301541)
    // this.startLocation =  {latitude: 30.069625, longitude: 120.282487}
    // this.endLocation = {latitude: 30.116183, longitude: 120.301541}
  }

  setLocation(location: NaviTestLocation) {
    this.location = location
  }

  getLocation(): NaviTestLocation {
    return this.location
  }

  static async getCurrentLocation(): Promise<AMapLocation> {
    const request: geoLocationManager.SingleLocationRequest = {
      locatingPriority: geoLocationManager.LocatingPriority.PRIORITY_ACCURACY, // 高精度模式
      locatingTimeoutMs: 200 // 超时时间0.2秒
    };

    const location: AMapLocation = {
      longitude: 116.458887,
      latitude: 39.833187,
      speed: 15,
      accuracy: 1,
      timeStamp: new Date().getTime(),
      direction: -1,
      isOffset: false,
      timeSinceBoot: -1,
      altitude: 0
    }

    try {
      let tmp = await geoLocationManager.getCurrentLocation(request) as AMapLocation;
      return tmp ?? location
    } catch (err) {
      const error = err as BusinessError;
      console.error(`错误码: ${error.code}, 原因: ${error.message}`);

      return location
    }
  }
}