// @keepTs
// @ts-nocheck
/**
 * poi对象
 * @项目名称： AMapLocationSDK
 * @类型名称：PoiItem
 * @since 3.2.0
 */
export declare class PoiItem {
    /**
     * 名称
     */
    private poiName;
    /**
     * id
     */
    private z18;
    /**
     * 兴趣点类型
     */
    private poiType;
    /**
     * 兴趣点类型编码
     */
    private typeCode;
    /**
     * 地址
     */
    private address;
    /**
     * 纬度
     */
    private latitude;
    /**
     * 精度
     */
    private longitude;
    /**
     * 电话
     */
    private tel;
    /**
     * poi所在的省份名称
     */
    private province;
    /**
     * poi所在的城市名称
     */
    private city;
    /**
     * poi所在的区域编码
     */
    private adname;
    constructor();
    /**
     * 获取POI的纬度
     * @return POI的纬度
     * @since 3.2.0
     * @author hongming.wang
     */
    getLatitude(): number;
    /**
     * 设置POI的纬度
     * @param latitude POI的纬度
     * @since 3.2.0
     * @author hongming.wang
     * @exclude
     *
     */
    setLatitude(latitude: number): void;
    /**
     * 获取POI的经度
     * @return POI的经度
     * @since 3.2.0
     * @author hongming.wang
     */
    getLongitude(): number;
    /**
     * 设置POI的经度
     * @param latitude POI的纬度
     * @since 3.2.0
     * @author hongming.wang
     * @exclude
     */
    setLongitude(longitude: number): void;
    /**
     * 获取POI的ID
     * @return POI的ID
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    a19(): string;
    /**
     * 设置POI的ID
     * @param poiId
     * @since 3.2.0
     * @author hongming.wang
     * @exclude
     */
    f16(y18: string): void;
    /**
     * 获取POI的类型
     * @return POI的类型, 更多分类请下载<a href="http://lbs.amap.com/api/android-location-sdk/download/" target="view_window">POI分类编码表</a>进行参照
     * @since 3.2.0
     * @author hongming.wang
     * @see <a href="http://lbs.amap.com/api/android-location-sdk/download/" target="_blank">POI分类编码表和城市编码表</a>
     */
    b19(): string;
    /**
     * 设置POI的类型
     * @param poiType
     * @since 3.2.0
     * @author hongming.wang
     * @exclude
     */
    h16(poiType: string): void;
    /**
     * 获取POI的类型编码
     * @return POI的类型编码
     * @since 3.2.0
     * @author hongming.wang
     * @see <a href="http://lbs.amap.com/api/android-location-sdk/download/" target="_blank">POI分类编码表和城市编码表</a>
     */
    c19(): string;
    /**
     * 设置POI的类型编码
     * @param typeCode
     * @since 3.2.0
     * @author hongming.wang
     * @exclude
     */
    i16(typeCode: string): void;
    /**
     * 获取POI的地址信息
     * @return POI的地址信息
     * @since 3.2.0
     * @author hongming.wang
     */
    d19(): string;
    /**
     * 设置POI的地址信息
     * @return POI的地址信息
     * @since 3.2.0
     * @author hongming.wang
     * @exclude
     */
    j16(address: string): void;
    /**
     * 获取POI的电话号码
     * @return POI的电话号码
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    e19(): string;
    /**
     * 设置POI的电话号码
     * @param tel
     * @since 3.2.0
     * @author hongming.wang
     * @exclude
     */
    k16(x18: string): void;
    /**
     * 获取POI所在的省份名称
     * @return POI所在的省份名称
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    f19(): string;
    /**
     * 设置POI所在的城市名称
     * @param pname POI所在的城市名称
     * @since 3.2.0
     * @author hongming.wang
     * @exclude
     */
    l16(w18: string): void;
    /**
     * 获取POI所在的城市名称
     * @return
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    g19(): string;
    /**
     * 设置POI所在的城市名称
     * @param city
     * @since 3.2.0
     * @author hongming.wang
     * @exclude
     */
    m16(city: string): void;
    /**
     * 获取POI所在的区域名称
     * @return POI所在的区域名称
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    h19(): string;
    /**
     * 获取POI的名称
     * @return POI的名称
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    i19(): string;
    /**
     * 获取POI的名称
     * @param poiName
     * @since 3.2.0
     * @author hongming.wang
     * @exclude
     */
    g16(v18: string): void;
    /**
     * 设置POI所在的区域名称
     * @param adname
     * @since 3.2.0
     * @author hongming.wang
     * @exclude
     */
    n16(u18: string): void;
}
