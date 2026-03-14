// @keepTs
// @ts-nocheck
import geoLocationManager from '@ohos.geoLocationManager';
import { IAMapLocationListener, AMapLocationManager } from '../interface/AMapLocationManager';
import { AMapLocationOption } from './AMapLocationOption';
import { AMapPrivacyShowStatus, AMapPrivacyInfoStatus, AMapPrivacyAgreeStatus } from '@amap/amap_lbs_common';
import { AMapLocationType } from '../interface/AMapLocationCommonObj';
/**
 * 请求定位逻辑实现类
 */
export declare class AMapLocationManagerImpl implements AMapLocationManager {
    static n22: string;
    private updatingLocationListener?;
    private singleLocationListener?;
    private lastLocationListener?;
    private updatingLocationOption;
    private singleLocationOption;
    private lastLocationOption;
    private context;
    private isStartLocation;
    constructor(ctx: Context);
    setLocationOption(d29: AMapLocationType, option: AMapLocationOption): void;
    private realSetLocationOption;
    setLocationListener(b29: AMapLocationType, listener: IAMapLocationListener): void;
    private checkPerminssion;
    /**
     * 获取最后一次位置信息
     * @returns
     * */
    requestLastLocation(): void;
    locationCurrent: (err: Error, location: geoLocationManager.Location) => void;
    /**
     * 单次定位，获取当前位置
     */
    requestSingleLocation(): void;
    e29: (error: geoLocationManager.LocationError) => void;
    f29: (error: geoLocationManager.LocationError) => void;
    locationChange: (location: geoLocationManager.Location) => void;
    /**
     * 开启连续定位
     */
    startUpdatingLocation(): void;
    /**
     * 关闭连续定位
     */
    stopUpdatingLocation(): void;
    /**
     * 开启后台定位
     */
    startContinuousTask(): void;
    /**
     * 停止后台定位
     */
    stopContinuousTask(): void;
    /**
     * 通知定位信息
     * @param loc
     */
    private notifyLocation;
    /**
     * 通知定位中发生的错误信息
     * @param errorCode
     * @param errorMsg
     */
    private notifyLocationError;
    /**
     * 将系统的定位信息转成amap定位信息
     * @param location
     * @returns
     */
    private convert2AMapLocation;
    /**
     * 请求逆地理信息
     * @param location
     * @returns
     */
    private requestReGeoLocation;
    /**
     * 设置key
     * @param apiKey 平台申请key信息
     */
    static setApiKey(m28: string): void;
    /**
     * 更新App是否显示隐私弹窗的状态，隐私弹窗是否包含高德SDK隐私协议内容的状态。
     * 注意：必须在 AMapLocationManager 实例化之前调用。
     * @param showStatus 隐私弹窗状态
     * @param containStatus 包含高德SDK隐私协议状态
     * @param context 上下文
     * @since 1.0.0
     */
    static updatePrivacyShow(j28: AMapPrivacyShowStatus, k28: AMapPrivacyInfoStatus, context: Context): void;
    /**
     * 更新用户授权高德SDK隐私协议状态，注意：必须在AMapLocationManager实例化之前调用。
     * @param agreeStatus 用户授权高德SDK隐私协议状态
     * @since 1.0.0
     */
    static updatePrivacyAgree(h28: AMapPrivacyAgreeStatus, context: Context): void;
    /**
     * 检查是否同意隐私协议
     */
    private checkPrivacyStatus;
    private registerWithComponent;
}
