// @keepTs
// @ts-nocheck
import { LatLng } from './LatLng';
/**
 * 代表了经纬度划分的一个矩形区域。
 *
 * @since 1.0.0
 */
export declare class LatLngBounds {
    static readonly CLASSNAME: string;
    private readonly mVersionCode;
    readonly southwest: LatLng;
    readonly northeast: LatLng;
    /**
     * 使用传入的西南角坐标和东北角坐标创建一个矩形区域。
     *
     * @param southwest 西南角坐标。
     * @param northeast 东北角坐标。
     * @since 1.0.0
     */
    constructor(southwest: LatLng, northeast: LatLng, versionCode?: number);
    /**
     * 创建一个LatLngBounds 构造器
     *
     * @return
     * @since 1.0.0
     */
    protected getVersionCode(): number;
    /**
     * 创建一个LatLngBounds构造器。
     *
     * @return 新创建的Builder对象。
     * @since 1.0.0
     */
    static builder(): LatLngBoundsBuilder;
    /**
     * 判断矩形区域是否包含传入的经纬度点。
     *
     * @param point 经纬度点。
     * @return true 矩形包含这个点;false 矩形未包含这个点。
     * @since 1.0.0
     */
    contains(point: LatLng): boolean;
    /**
     * 判断矩形区域是否包含传入的矩形区域。
     *
     * @param curBounds 矩形区域。
     * @return true 矩形包含这个区域;false 矩形未包含这个区域。
     * @since 1.0.0
     */
    containsBound(t35: LatLngBounds): boolean;
    /**
     * 判断两个矩形区域是否相交
     *
     * @param bounds 需要比较的矩形区域。
     * @return true 两个矩形相交;false 两个矩形不相交。
     * @since 1.0.0
     */
    intersects(bounds: LatLngBounds): boolean;
    private intersect;
    /**
     * 返回一个新的矩形区域。新区域是根据传入的经纬度对原有区域进行最小的扩展。
     * 返回矩形区域，需要传入至少两个扩展点的经纬度对象。多次调用此方法即可。
     * 这个方法将选择向东或向西方向扩展，期间扩展面积相对较小一个区域。如果相同，则优先向东方向扩展。
     *
     * @param point 扩展点的经纬度对象。
     * @return 一个根据传入的经纬度对原有区域进行最小的扩展的新矩形区域。
     * @since 1.0.0
     */
    including(point: LatLng): LatLngBounds;
    static longitudeDistanceHeadingWest(l35: number, longitude: number): number;
    static longitudeDistanceHeadingEast(k35: number, longitude: number): number;
    /**
     * 是否包含 纬度
     *
     * @param latitude
     * @return
     */
    private containsLatitude;
    /**
     * 是否包含 经度
     *
     * @param longitude
     * @return
     */
    private containsLongitude;
    toString(): string;
    equals(other: LatLngBounds): boolean;
}
/**
 * 经纬度坐标矩形区域的生成器。
 *
 * @since 1.0.0
 */
export declare class LatLngBoundsBuilder {
    private mSouth;
    private mNorth;
    private mWest;
    private mEast;
    /**
     * 区域包含传入的坐标。区域将进行小范围延伸包含传入的坐标。
     * 更准确来说，它会考虑向东或向西方向扩展（哪一种方法可能环绕地图），并选择最小扩展的方法。
     * 如果两种方向得到的矩形区域大小相同，则会选择向东方向扩展。
     * 例如：添加坐标（0，-179）和（1,179）将创建一个横穿180经线的区域。
     *
     * @param point 将坐标点包含在区域中。
     * @return 加入新坐标的builder对象。
     * @since 1.0.0
     */
    include(point: LatLng): LatLngBoundsBuilder;
    private containsLongitude;
    /**
     * 创建矩形区域。
     *
     * @return 一个LatLngBounds对象。
     * @since 1.0.0
     */
    build(): LatLngBounds | undefined;
}
