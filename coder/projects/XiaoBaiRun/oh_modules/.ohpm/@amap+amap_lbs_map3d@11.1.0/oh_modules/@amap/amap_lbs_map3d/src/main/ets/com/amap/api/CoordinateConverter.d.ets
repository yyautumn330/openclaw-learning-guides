// @keepTs
// @ts-nocheck
import { CoordType } from "./CoordType";
import { LatLng } from "./model/LatLng";
/**
 * 坐标转换工具类
 * @author zxy
 * @since 2.2.5
 */
export declare class CoordinateConverter {
    private static readonly TAG;
    private ctx;
    private coordType?;
    private o7?;
    /**
     * 坐标转换工具类构造方法
     * @param context
     * @since 2.2.5
     */
    constructor(context: Context);
    /**
     * 设置需要转换的坐标系类型
     *
     * @param type 源坐标类型，如BAIDU、GPS等。
     * @return 坐标转换工具类coordinateConverter对象。
     * @since 2.2.5
     */
    from(type: CoordType): CoordinateConverter;
    /**
     * 设置需要转换的经纬度坐标值
     *
     * @param latLng 源经纬度坐标。
     * @return 坐标转换工具类coordinateConverter对象。
     * @since 2.2.5
     */
    coord(latLng: LatLng): CoordinateConverter;
    /**
     * 执行坐标转换操作。
     *
     * @return 返回高德经纬度坐标。
     * @since 2.2.5
     */
    convert(): LatLng | undefined;
    /**
     * 是否是高德地图可用数据
     * @param latitude 纬度
     * @param longitude 经度
     * @return 是否是跟高德地图坐标系匹配的数据
     * @since 2.2.5
     */
    static isAMapDataAvailable(latitude: number, longitude: number): boolean;
}
