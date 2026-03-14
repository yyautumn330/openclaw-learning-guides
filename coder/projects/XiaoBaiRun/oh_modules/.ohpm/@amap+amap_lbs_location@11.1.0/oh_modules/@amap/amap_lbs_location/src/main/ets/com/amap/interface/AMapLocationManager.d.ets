// @keepTs
// @ts-nocheck
import { AMapLocation } from '../location/AMapLocation';
import { AMapLocationOption } from '../location/AMapLocationOption';
import { AMapLocationType } from './AMapLocationCommonObj';
import { AMapLocationErrorInfo } from '../location/AMapLocationErrorInfo';
export interface AMapLocationManager {
    /**
     * 获取最后位置
     */
    requestLastLocation(): void;
    /**
     * 单次定位。
     * @param reGeocode 是否带有逆地理信息(获取逆地理信息需要联网)
     * @return 是否成功添加单次定位Request
     */
    requestSingleLocation(): void;
    /**
     * 开始连续定位。
     */
    startUpdatingLocation(): void;
    /**
     * 停止连续定位。
     */
    stopUpdatingLocation(): void;
    /**
     * 设置定位配置项
     * @param locType 定位类型
     * @param option 定位配置
     */
    setLocationOption(locType: AMapLocationType, option: AMapLocationOption): void;
    /**
     * 设置定位信息监听回调
     * @param locType 定位类型
     * @param listener 监听类
     */
    setLocationListener(locType: AMapLocationType, listener: IAMapLocationListener): void;
    /**
     * 开启后台定位任务
     */
    startContinuousTask(): void;
    /**
     * 停止后台定位任务
     */
    stopContinuousTask(): void;
}
/**
 * 定位信息监听接口
 */
export interface IAMapLocationListener {
    /**
     * 定位信息改变回调
     * @param location 定位信息
     */
    onLocationChanged: (location: AMapLocation) => void;
    /**
     * 定位异常回调
     * @param locationErrorInfo 错误信息
     */
    onLocationError: (locationErrorInfo: AMapLocationErrorInfo) => void;
}
