// @keepTs
// @ts-nocheck
/**
 * 定位错误码信息
 */
export declare class AMapLocationErrorCode {
    static readonly ERROR_CHECK_PRIVACY: number;
    /**
     * 权限检查失败
     */
    static readonly ERROR_CHECK_PERMINSSION: number;
    /**
     * 单次定位失败
     */
    static readonly ERROR_SINGLE_LOCATION_FAIL: number;
    /**
     * 定位服务未开启
     */
    static readonly ERROR_LOCATION_SERVICE_CLOSE: number;
    /**
     * 开始连续定位失败
     */
    static readonly ERROR_START_UPDATING_LOCATION_FAIL: number;
    /**
     * 停止连续定位失败
     */
    static readonly ERROR_STOP_UPDATING_LOCATION_FAIL: number;
    /**
     * 逆地理请求失败
     */
    static readonly ERROR_REQUEST_REGEO_FAIL: number;
    /**
     * 请求上次位置失败
     */
    static readonly ERROR_LAST_LOCATION_FAIL: number;
}
export declare enum j19 {
    /**
     * 未知
     */
    Unknow = 0,
    /**
     * 在范围内
     */
    Inside = 1,
    /**
     * 在范围外
     */
    Outside = 2
}
/**
 * 逆地理语言
 */
export declare enum AMapLocationReGeocodeLanguage {
    /**
     * 默认，根据地区选择语言。
     */
    Default = 0,
    /**
     * 中文
     */
    Chinese = 1,
    /**
     * 英文
     */
    English = 2
}
/**
 * 定位类型
 */
export declare enum AMapLocationType {
    /**
     * 最后位置
     */
    Last = 0,
    /**
     * 单次定位
     */
    Single = 1,
    /**
     * 连续定位
     */
    Updating = 2
}
