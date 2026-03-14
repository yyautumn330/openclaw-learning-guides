// @keepTs
// @ts-nocheck
import { AMapLocationReGeo } from '../interface/AMapLocationReGeocode';
import HashMap from "@ohos.util.HashMap";
/**
 * 定位信息
 */
export interface AMapLocation {
    /**
     * 纬度
     */
    latitude: number;
    /**
     * 经度
     */
    longitude: number;
    /**
     * 海拔
     */
    altitude: number;
    /**
     * 精度
     */
    accuracy: number;
    /**
     * 速度
     */
    speed: number;
    /**
     * 时间戳
     */
    timeStamp: number;
    /**
     * 方向
     */
    direction: number;
    /**
     * 自启动以来时间
     */
    timeSinceBoot: number;
    /**
     * 附加信息
     */
    additions?: string[];
    /**
     * 附加信息数量
     */
    additionSize?: number;
    /**
     * 是否偏转
     */
    isOffset: boolean;
    /**
     * the name of the provider that generated this fix
     */
    provider?: string;
    /**
     * 定位结果来源
     */
    locationType?: AMapLocationMoreType;
    /**
     * 角度
     */
    bearing?: number;
    extras?: HashMap<string, ESObject>;
    /**
     * 定位信息描述
     */
    locationDetail?: string;
    /**
     * 逆地理信息
     */
    reGeo?: AMapLocationReGeo;
}
export declare class AMapLocationMoreType {
    static readonly LOCATION_TYPE_GPS: number;
    static readonly LOCATION_TYPE_SAME_REQ: number;
    /** @deprecated */
    static readonly LOCATION_TYPE_FAST: number;
    static readonly LOCATION_TYPE_FIX_CACHE: number;
    static readonly LOCATION_TYPE_WIFI: number;
    static readonly LOCATION_TYPE_CELL: number;
    static readonly LOCATION_TYPE_AMAP: number;
    static readonly LOCATION_TYPE_OFFLINE: number;
    static readonly LOCATION_TYPE_LAST_LOCATION_CACHE: number;
    static readonly LOCATION_COMPENSATION: number;
    static readonly LOCATION_TYPE_COARSE_LOCATION: number;
}
