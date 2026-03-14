// @keepTs
// @ts-nocheck
/**
 * 坐标点对象，包含经度和纬度
 * @项目名称： AMapLocationSDK
 * @version 2.1.0
 * @since 2.1.0
 * @类型名称: DPoint
 */
export declare class DPoint {
    private longitude;
    private latitude;
    /**
     * 根据经纬度构造坐标点
     * @param latitude  纬度
     * @param longitude  经度
     * @since 2.1.0
     */
    constructor(latitude?: number, longitude?: number);
    /**
     * 获取坐标点的经度
     * @return 坐标点的经度
     * @since 2.1.0
     */
    getLongitude(): number;
    /**
     * 设置坐标点的经度
     * @param longitude 经度
     * @since 2.1.0
     */
    setLongitude(longitude: number): void;
    /**
     * 获取坐标点的纬度
     * @return 标点的纬度
     * @since 2.1.0
     */
    getLatitude(): number;
    /**
     * 设置坐标点的纬度
     * @param latitude 纬度
     * @since 2.1.0
     */
    setLatitude(latitude: number): void;
}
