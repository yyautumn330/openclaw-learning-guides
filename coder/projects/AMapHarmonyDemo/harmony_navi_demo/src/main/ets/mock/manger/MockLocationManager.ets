import virtualUtil from '../VirtualUtil'
import ArrayList from '@ohos.util.ArrayList';
import { MockState } from '../MockState';
import { LogUtil } from '@amap/amap_lbs_common';
import { AMapLocation } from '@amap/amap_lbs_location';
import { AMapNaviPath } from '@amap/amap_lbs_navi';
import { NaviLatLng } from '@amap/amap_lbs_navi';
import { IGpsCallback } from '@amap/amap_lbs_navi';
import {
  IMockLocationManager
} from '@amap/amap_lbs_navi';

const TAG: string = '[MockTest]'

/**
 * 模拟定位管理类
 */
export class MockLocationManager implements IMockLocationManager {
  private static instance: MockLocationManager;
  //模拟后的原始数据
  private oriCoordinates: AMapLocation[] = [];
  //当前返回数据的位置
  private index = 0
  //默认80km/h
  private mockSpeed: number = 80
  //稀释数据默认200ms发送一次
  private timeInverval: number = 0.4
  //每次增加或减少速度默认值
  private speedLength: number = 10
  //新数据是否添加在原数据之后
  private isAddOriginEnd: boolean = false
  //回调
  private callback: IGpsCallback | null = null
  //状态管理
  private state = MockState.PREPARE
  //上一个坐标的距离
  private distancePerStep = 0;
  //原始数据长度
  private count = 0;
  private totalDis = 0
  private stepTotalDistance = 0

  public startMockLocation(path: AMapNaviPath, callback: IGpsCallback): void {
    this.callback = callback;

    const coordList = path.getCoordList();
    if (!coordList || coordList.isEmpty()) {
      LogUtil.w(TAG, 'startMockLocation', 'Empty path ignored');
      return;
    }
    const newCoords: NaviLatLng[] = coordList.convertToArray();

    if (this.state === MockState.MOCKING) {
      this.updateDynamicPath(newCoords);
    } else {
      this.setCoordinates(path.getCoordList(), path.getCoordList()?.length);
      this.setSpeed();
      this.start();
    }
  }
  private updateDynamicPath(newCoords: NaviLatLng[]): void {
    if (this.index >= this.oriCoordinates.length) return;

    const currentPos = this.oriCoordinates[this.index];
    const tolerance = 0.0005;
    let matchIndex = -1;
    for (let i = 0; i < newCoords.length; i++) {
      const p = newCoords[i];
      const dLat = Math.abs(p.latitude - currentPos.latitude);
      const dLng = Math.abs(p.longitude - currentPos.longitude);
      if (dLat < tolerance && dLng < tolerance) {
        matchIndex = i;
        break;
      }
    }

    const remainingNewPath = matchIndex !== -1 ? newCoords.slice(matchIndex + 1) : newCoords;

    if (remainingNewPath.length === 0) return;

    const converted: AMapLocation[] = remainingNewPath.map(p =>
    virtualUtil.simpleLocationVirtual(p.latitude, p.longitude)
    );

    this.oriCoordinates = [
      ...this.oriCoordinates.slice(0, this.index + 1),
      ...converted
    ];
    this.count = this.oriCoordinates.length;
  }

  public stopMockLocation(): void {
    this.stop()
  }

  public static getInstance(): MockLocationManager {
    if (!MockLocationManager.instance) {
      MockLocationManager.instance = new MockLocationManager();
    }
    return MockLocationManager.instance;
  }

  /**
   * 塞入定位数据
   */
  private async setCoordinates(coordinates: ArrayList<NaviLatLng> | null, count: number | undefined) {
    if (coordinates == null || count == undefined || count <= 0) {
      return
    }
    this.count = count
    if (!this.isAddOriginEnd) {
      this.oriCoordinates = []
    }
    for (let i = 0; i < count; i++) {
      this.oriCoordinates[i] = virtualUtil.simpleLocationVirtual(coordinates.convertToArray()[i].latitude,
        coordinates.convertToArray()[i].longitude)
    }
  }

  /**
   * 设置速度
   */
  public setSpeed(speed: number = 80) {
    let simulateSpeed = Math.max(0, Math.min(200, speed))
    this.mockSpeed = simulateSpeed / 3.6
    this.distancePerStep = this.timeInverval * this.mockSpeed;
  }

  /**
   * 设置是否添加到原数组
   */
  public setIsAddOriginEnd(isAddOriginEnd: boolean = false) {
    this.isAddOriginEnd = isAddOriginEnd
  }

  /**
   * 设置稀释后数据多少s输出一次 单位s
   */
  public setTimeInverval(time: number = 0.2) {
    if (time < 0) {
      return
    }
    this.timeInverval = time
  }

  /**
   * 设置加速的速度长度m/s
   */
  public setSpeedLength(speedLength: number = 10) {
    if (speedLength < 0) {
      return
    }
    this.speedLength = speedLength
  }

  /**
   * 开始模拟Gps
   */
  public async start() {
    if (this.state === MockState.PREPARE
      || this.state === MockState.PAUSE
      || this.state === MockState.STOP) {

      this.state = MockState.MOCKING

      this.stepTotalDistance = this.distancePerStep;

      let course = 0;
      this.index = 0;
      let dis =
        virtualUtil.distanceBetweenCoordinates(this.oriCoordinates[this.index], this.oriCoordinates[this.index + 1])
      this.totalDis = dis;
      let resultCoordinate: AMapLocation = virtualUtil.newAMapLocation()

      while (this.index < this.count - 1 && this.state === MockState.MOCKING) {
        if (this.stepTotalDistance <= this.totalDis) {
          resultCoordinate = virtualUtil.coordinateAtRateOfCoordinates(this.oriCoordinates[this.index],
            this.oriCoordinates[this.index + 1], ((dis - (this.totalDis - this.stepTotalDistance)) / dis));
          this.stepTotalDistance += this.distancePerStep;

          course = virtualUtil.angleBetweenCoordinates(this.oriCoordinates[this.index], resultCoordinate);
          if (this.mockSpeed) {
            resultCoordinate.altitude = 30
            resultCoordinate.speed = this.mockSpeed
            resultCoordinate.direction = course
          }

          await this.sleep(this.timeInverval * 1000)

          this.callback?.onLocationChanged(2, resultCoordinate)
          LogUtil.i(TAG, 'start', 'location: ' + resultCoordinate.latitude + ', ' + resultCoordinate.longitude + ', ' +
          resultCoordinate.direction)
        } else {
          this.index++
          if (this.index + 1 === this.count) { // out of range
            break
          }

          dis = virtualUtil.distanceBetweenCoordinates(this.oriCoordinates[this.index],
            this.oriCoordinates[this.index +1])
          this.totalDis += dis
        }
      }

      this.callback?.onLocationChanged(2, this.oriCoordinates[this.count - 1])
      LogUtil.i(TAG, 'start', 'last location: ' + this.oriCoordinates[this.count - 1].latitude + ', ' +
      this.oriCoordinates[this.count - 1].longitude + ', ' + this.oriCoordinates[this.count - 1].direction)

      this.state = MockState.STOP
    }
  }

  /**
   * 暂停模拟Gps
   */
  public async pause() {
    if (this.state == MockState.MOCKING) {
      this.state = MockState.PAUSE
      LogUtil.i(TAG, 'pause', 'the current last location')
    }
  }

  /**
   * 停止模拟Gps
   */
  public async stop() {
    if (this.state == MockState.MOCKING) {
      this.state = MockState.STOP
      LogUtil.i(TAG, 'stop', 'the current last location')
    }
  }

  /**
   * 恢复模拟gps
   */
  public async restore() {
    if (this.state == MockState.PAUSE) {
      this.state = MockState.PREPARE
      LogUtil.i(TAG, 'restore', 'start')
      this.start()
    }
  }

  /**
   * 增加模拟速度 (默认每次调用增加10)
   */
  public async plusVirtualSpeed() {
    if (this.state === MockState.MOCKING) {
      let speed = this.mockSpeed * 3.6
      this.setSpeed(speed += this.speedLength)
      this.state = MockState.PREPARE
      LogUtil.i(TAG, 'plusVirtualSpeed', 'start,this current speed is ' + this.mockSpeed)
      this.start()
    }
  }

  /**
   * 减少模拟速度(默认每次调用减少10)
   */
  public async minusVirtualSpeed() {
    if (this.state === MockState.MOCKING) {
      let speed = this.mockSpeed * 3.6
      this.setSpeed(speed -= this.speedLength)
      this.state = MockState.PREPARE
      LogUtil.i(TAG, 'minusVirtualSpeed', 'start,this current speed is ' + this.mockSpeed)
      this.start()
    }
  }

  /**
   * 模拟点位飘逸
   */
  public jumpVirtualLocation() {
    if (this.state === MockState.MOCKING) {
      LogUtil.i(TAG, 'jumpVirtualLocation', 'start')
      // let location = this.MockedData[this.index]
      // let virtualArr = virtualUtil.generateRandomGps(location.longitude, location.latitude, 800)
      // this.initData(virtualArr)
      // this.state = MockState.PREPARE
      // this.start()
    }
  }

  sleep(ms: number): Promise<void> {
    return new Promise(resolve => setTimeout(resolve, ms));
  }
}




