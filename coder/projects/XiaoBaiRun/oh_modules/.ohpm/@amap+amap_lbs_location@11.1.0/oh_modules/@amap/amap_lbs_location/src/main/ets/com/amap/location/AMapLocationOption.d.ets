// @keepTs
// @ts-nocheck
import geoLocationManager from '@ohos.geoLocationManager';
import { AMapLocationReGeocodeLanguage } from '../interface/AMapLocationCommonObj';
/**
 * 定位配置信息
 */
export interface AMapLocationOption {
    /**
     * 定位优先配置选项
     * ACCURACY：GPS定位
     * LOW_POWER：网络定位
     * FIRST_FIX：GPS+网络
     * 表示优先级信息。当scenario取值为UNSET时，priority参数生效，否则priority参数不生效；当scenario和priority均取值为UNSET时，无法发起定位请求。
     */
    priority?: geoLocationManager.LocationRequestPriority;
    /**
     * 定位场景设置
     * 表示场景信息。当scenario取值为UNSET时，priority参数生效，否则priority参数不生效；当scenario和priority均取值为UNSET时，无法发起定位请求。
     */
    scenario?: geoLocationManager.LocationRequestScenario;
    /**
     * 定位时间间隔，仅连续定位生效
     * 表示上报位置信息的时间间隔，单位是秒。默认值为2，取值范围为大于等于0。
     */
    timeInterval?: number;
    /**
     * 位置报告距离间隔，仅连续定位生效
     * 表示上报位置信息的距离间隔。单位是米，默认值为0，取值范围为大于等于0。
     */
    distanceInterval?: number;
    /**
     * 定位精度
     * 表示精度信息，单位是米。仅在精确位置功能场景下有效，模糊位置功能生效场景下该字段无意义。默认值为0，取值范围为大于等于0。
     */
    maxAccuracy?: number;
    /**
     * 是否加偏 默认true
     */
    isOffset?: boolean;
    /**
     * 是否允许后台定位。默认为 false。
     */
    allowsBackgroundLocationUpdates?: boolean;
    /**
     * 仅单次定位生效
     * 指定单次定位超时时间，单位是毫秒，最小为1000毫秒。取值范围为大于等于1000。
     */
    singleLocationTimeout?: number;
    /**
     * 定位是否返回逆地理信息，默认false。
     */
    locatingWithReGeocode?: boolean;
    /**
     * 逆地址语言类型，默认是AMapLocationRegionLanguage 中文
     */
    reGeocodeLanguage?: AMapLocationReGeocodeLanguage;
}
