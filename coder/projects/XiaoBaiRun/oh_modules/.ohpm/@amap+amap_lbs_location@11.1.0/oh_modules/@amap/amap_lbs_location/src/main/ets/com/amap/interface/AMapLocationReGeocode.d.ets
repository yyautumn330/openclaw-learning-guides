// @keepTs
// @ts-nocheck
import ArrayList from '@ohos.util.ArrayList';
/**
 * 逆地理信息接口
 */
export interface AMapLocationReGeo {
    /**
     * 国家
     */
    country: string;
    /**
     * 省/直辖市
     */
    province: string;
    /**
     * 市
     */
    city: string;
    /**
     * 区
     */
    district: string;
    /**
     * 城市编码
     */
    citycode: string;
    /**
     * 区域编码
     */
    adcode: string;
    /**
     * 街道名称
     */
    street: string;
    /**
     * 门牌号
     */
    number: string;
    /**
     * poi名字
     */
    poiName: string;
    /**
     * aoi名字
     */
    aoiName: string;
    /**
     * 描述信息
     */
    desc: string;
    /**
     * 地址信息
     */
    address: string;
}
export interface k19 {
    status: string;
    regeocode: l19;
    info: string;
    infocode: string;
}
export interface AMapLocationReGeoInfo {
    status?: string;
    regeo?: AMapLocationReGeo;
    info?: string;
    infocode?: string;
}
export interface l19 {
    addressComponent: AddressComponent;
    aois: ArrayList<AoiItem>;
    pois: ArrayList<PoiItem>;
}
/**
 * 地址信息接口
 */
export interface AddressComponent {
    /**
     * 国家
     */
    country: string;
    /**
     * 省/直辖市
     */
    province: string;
    /**
     * 市
     */
    city: string;
    /**
     * 区
     */
    district: string;
    /**
     * 城市编码
     */
    citycode: string;
    /**
     * 区域编码
     */
    adcode: string;
    /**
     * 街道信息
     */
    streetNumber: StreetNumber;
}
/**
 * 街道信息
 */
export interface StreetNumber {
    /**
     * 街道名称
     */
    street: string;
    /**
     * 门牌号
     */
    number: string;
}
/**
 * aoi信息
 */
export interface AoiItem {
    /**
     * 名称
     */
    name: string;
}
/**
 * poi信息
 */
export interface PoiItem {
    /**
     * 名称
     */
    name: string;
}
