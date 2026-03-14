import { window } from '@kit.ArkUI'
import ArrayList from '@ohos.util.ArrayList'
import { NaviLatLng } from '@amap/amap_lbs_navi'
import { AMapLocationReGeo } from '@amap/amap_lbs_location'
import { AMapLocation } from '@amap/amap_lbs_location'

class Virtual {
  /**
   * 根据基准点生成坐标
   */
  generateRandomGps(base_log: number, base_lat: number, num: number): ArrayList<NaviLatLng> {
    let radius_in_degrees = 1000 / 111300
    let locationArr: ArrayList<NaviLatLng> = new ArrayList()
    for (let i = 0; i < num; i++) {
      let u = Math.random()
      let v = Math.random()
      let w = radius_in_degrees * Math.sqrt(u)

      let t = 2 * Math.PI * v
      let x = w * Math.cos(t)
      let y = w * Math.sin(t)
      let longitude = y + base_log
      let latitude = x + base_lat
      let location: NaviLatLng = new NaviLatLng(Number(latitude.toFixed(6)), Number(longitude.toFixed(6)))
      locationArr.add(location)
    }
    return locationArr
  }

  /**
   * 获取两点坐标之间的距离
   * @param pointA
   * @param pointB
   * @returns
   */
  distanceBetweenCoordinates(pointA: AMapLocation, pointB: AMapLocation) {
    let AMAPLOC_DEG_TO_RAD = 0.0174532925199432958;
    let AMAPLOC_EARTH_RADIUS = 6378137.0;
    let latitudeArc = (pointA.latitude - pointB.latitude) * AMAPLOC_DEG_TO_RAD;
    let longitudeArc = (pointA.longitude - pointB.longitude) * AMAPLOC_DEG_TO_RAD;

    let latitudeH = Math.sin(latitudeArc * 0.5);
    latitudeH *= latitudeH;
    let lontitudeH = Math.sin(longitudeArc * 0.5);
    lontitudeH *= lontitudeH;

    let tmp = Math.cos(pointA.latitude * AMAPLOC_DEG_TO_RAD) * Math.cos(pointB.latitude * AMAPLOC_DEG_TO_RAD);
    return AMAPLOC_EARTH_RADIUS * 2.0 * Math.asin(Math.sqrt(latitudeH + tmp * lontitudeH));
  }

  // distanceBetweenCoordinates(pointA: AMapLocation, pointB: AMapLocation): number {
  //   // 使用 Haversine 公式计算距离
  //   // 地球半径，单位为千米
  //   let R = 6378137.0;
  //   let dLat = (pointB.latitude - pointA.latitude) * Math.PI / 180
  //   let dLon = (pointB.longitude - pointA.longitude) * Math.PI / 180
  //   let a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +Math.cos(pointA.latitude * Math.PI / 180) * Math.cos(pointB.latitude * Math.PI / 180) * Math.sin(dLon / 2) *Math.sin(dLon / 2);
  //   let c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  //   // 距离，单位为千米
  //   let distance = R * c;
  //   return distance * 1000;
  // }

  normalizeDegree(degree: number): number {
    let normalizationDegree = degree % 360.0;
    return (normalizationDegree < 0) ? normalizationDegree += 360.0 : normalizationDegree;
  }

  /**
   * 获取两个坐标点之间的角度
   * @param pointA
   * @param pointB
   * @returns
   */
  angleBetweenCoordinates(pointA: AMapLocation | null, pointB: AMapLocation | null): number {
    if (pointA == null || pointB == null) {
      return 0
    }
    let longitudeDelta = pointB.longitude - pointA.longitude;
    let latitudeDelta = pointB.latitude - pointA.latitude;
    let azimuth = (Math.PI * 0.5) - Math.atan2(latitudeDelta, longitudeDelta);
    return this.normalizeDegree(azimuth * 180 / Math.PI);
  }

  coordinateAtRateOfCoordinates(from: AMapLocation, to: AMapLocation, rate: number): AMapLocation {
    if (rate >= 1) {
      return to;
    }
    if (rate <= 0) {
      return from;
    }
    let latitudeDelta = (to.latitude - from.latitude) * rate;
    let longitudeDelta = (to.longitude - from.longitude) * rate;
    return this.simpleLocationVirtual(from.latitude + latitudeDelta, from.longitude + longitudeDelta);
  }

  simpleLocationVirtual(latitude: number, longitude: number): AMapLocation {
    let aMapLocationReGeo: AMapLocationReGeo = {
      adcode: '',
      address: '',
      aoiName: '',
      city: '',
      citycode: '',
      country: '',
      desc: '',
      district: '',
      number: '',
      poiName: '',
      province: '',
      street: '',
    }

    let string = []

    let gLocation: AMapLocation = {
      accuracy: -1,
      additionSize: -1,
      additions: string,
      altitude: -1,
      direction: -1,
      isOffset: false,
      latitude: latitude,
      longitude: longitude,
      reGeo: aMapLocationReGeo,
      speed: -1,
      timeSinceBoot: -1,
      timeStamp: -1
    }

    return gLocation
  }

  newAMapLocation(): AMapLocation {
    let aMapLocationReGeo: AMapLocationReGeo = {
      adcode: '',
      address: '',
      aoiName: '',
      city: '',
      citycode: '',
      country: '',
      desc: '',
      district: '',
      number: '',
      poiName: '',
      province: '',
      street: '',
    }

    let string = []

    let gLocation: AMapLocation = {
      accuracy: -1,
      additionSize: -1,
      additions: string,
      altitude: -1,
      direction: -1,
      isOffset: false,
      latitude: 0,
      longitude: 0,
      reGeo: aMapLocationReGeo,
      speed: 0,
      timeSinceBoot: -1,
      timeStamp: -1
    }

    return gLocation
  }

  async getWindowAvoidArea(): Promise<number> {
    return new Promise<number>(async (resolve, reject) => {
      let windowClass = await window.getLastWindow(getContext(this));
      //如果没设置全屏就需要设置全屏（非全屏状态下窗口和系统状态栏没有重叠）
      await windowClass.setWindowLayoutFullScreen(true)
      let type = window.AvoidAreaType.TYPE_SYSTEM;
      try {
        let avoidArea = windowClass.getWindowAvoidArea(type);
        resolve(avoidArea.topRect.height)
      } catch (exception) {
        reject
      }
    })
  }
}

export default new Virtual()