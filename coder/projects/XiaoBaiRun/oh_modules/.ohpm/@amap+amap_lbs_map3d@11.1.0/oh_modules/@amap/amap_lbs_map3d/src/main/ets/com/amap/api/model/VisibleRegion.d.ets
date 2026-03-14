// @keepTs
// @ts-nocheck
import { LatLng } from './LatLng';
import { LatLngBounds } from './LatLngBounds';
export declare class VisibleRegion {
    /**
     *@exclude javadoc中不显示
     */
    private readonly mVersionCode;
    /**
     * 可视区域的左下角。
     * @since 1.0.0
     */
    readonly nearLeft: LatLng;
    /**
     * 可视区域的右下角。
     * @since 1.0.0
     */
    readonly nearRight: LatLng;
    /**
     * 可视区域的左上角。
     * @since 1.0.0
     */
    readonly farLeft: LatLng;
    /**
     * 可视区域的右上角。
     * @since 1.0.0
     */
    readonly farRight: LatLng;
    /**
     * 由可视区域的四个顶点形成的经纬度范围
     * @since 1.0.0
     */
    readonly latLngBounds: LatLngBounds;
    /**
     * 给出可视区域四个角的坐标，创建VisibleRegion对象。
     * <p>经纬度参数必须定义一个凸形（得到的图形边缘不相交）。无边界检查时在运行时执行。</p>
     *
     * @param nearLeft     包含经纬度坐标的LatLng对象，区域离视野近的左顶点。
     * @param nearRight    包含经纬度坐标的LatLng对象，区域离视野近的右顶点。
     * @param farLeft      包含经纬度坐标的LatLng对象，区域离视野远的左顶点。
     * @param farRight     包含经纬度坐标的LatLng对象，区域离视野远的右顶点。
     * @param latLngBounds 最小边界框，包含在这个类里定义的可见区域。
     *                     如果这个框跨越180°子午线（垂直线从北向南），farRight的经度是负数，farLeft的经度是正数。
     *                     这个在nearLeft和nearRight同样适用。
     * @since 1.0.0
     */
    constructor(nearLeft: LatLng, nearRight: LatLng, farLeft: LatLng, farRight: LatLng, d47: LatLngBounds);
    /**
     * @param versionCode
     * @param nearLeft
     * @param nearRight
     * @param farLeft
     * @param farRight
     * @param latLngBounds
     * @exclude javadoc中不显示
     */
    constructor(nearLeft: LatLng, nearRight: LatLng, farLeft: LatLng, farRight: LatLng, c47: LatLngBounds, versionCode: number);
    /**
     * @return
     * @exclude javadoc中不显示
     */
    protected getVersionCode(): number;
    /**
     * 将这个可见区域和另个对象进行比较。如果两个对象指向相同的指针，
     * 或者两个对象的四个角和范围是一样的，方法返回true；否则，返回false。
     * @param o java.lang.Object。如果两个对象是同一个，
     *        或者四个角和范围相同，返回true；否则返回false。
     * @return 对象比较结果。相同则返回true，反之false。
     * @since 1.0.0
     */
    equals(z46: VisibleRegion): boolean;
    /**
     * @return
     * @exclude javadoc中不显示
     */
    toString(): string;
}
