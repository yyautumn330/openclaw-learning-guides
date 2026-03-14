// @keepTs
// @ts-nocheck
import { BitmapDescriptor } from './BitmapDescriptor';
/**
 * 定位小蓝点（当前位置）的绘制样式类。
 *
 * @since 1.0.0
 */
export declare class MyLocationStyle {
    /**
     * @exclude javadoc中不显示
     */
    static readonly TAG: string;
    private mMyLocationIcon?;
    private mAnchorU;
    private mAnchorV;
    private mRadiusFillColor;
    private mStrokeColor;
    private mStrokeWidth;
    /**
     * 是否显示定位小蓝点，默认显示
     */
    private myLocationVisible;
    /**
     * 只定位。
     * @since 1.0.0
     */
    static readonly LOCATION_TYPE_SHOW: number;
    /**
     * 定位、且将视角移动到地图中心点。
     * @since 1.0.0
     */
    static readonly LOCATION_TYPE_LOCATE: number;
    /**
     * 定位、且将视角移动到地图中心点，定位点跟随设备移动。
     * @since 1.0.0
     */
    static readonly LOCATION_TYPE_FOLLOW: number;
    /**
     * 定位、且将视角移动到地图中心点，地图依照设备方向旋转，定位点会跟随设备移动。
     * @since 1.0.0
     */
    static readonly LOCATION_TYPE_MAP_ROTATE: number;
    /**
     * 定位、且将视角移动到地图中心点，定位点依照设备方向旋转，并且会跟随设备移动。
     * @since 1.0.0
     */
    static readonly LOCATION_TYPE_LOCATION_ROTATE: number;
    /**
     * 定位、但不会移动到地图中心点，定位点依照设备方向旋转，并且会跟随设备移动。
     * @since 1.0.0
     */
    static readonly LOCATION_TYPE_LOCATION_ROTATE_NO_CENTER: number;
    /**
     * 定位、但不会移动到地图中心点，并且会跟随设备移动。
     * @since 1.0.0
     */
    static readonly LOCATION_TYPE_FOLLOW_NO_CENTER: number;
    /**
     * 定位、但不会移动到地图中心点，地图依照设备方向旋转，并且会跟随设备移动。
     * @since 1.0.0
     */
    static readonly LOCATION_TYPE_MAP_ROTATE_NO_CENTER: number;
    private mLocationType;
    /**
     * 定位（当前位置）的绘制样式类的构造函数
     * @since 1.0.0
     */
    constructor();
    /**
     * 设置定位（当前位置）的icon图标。
     *
     * @param myLocationIcon 使用的位置图标。
     * @return 一个设置了定位图标的MyLocationStyle对象。
     * @since 1.0.0
     */
    myLocationIcon(k39: BitmapDescriptor): MyLocationStyle;
    /**
     * 设置定位图标的锚点。
     * 锚点是定位图标接触地图平面的点。图标的左顶点为（0,0）点，右底点为（1,1）点。
     *
     * @param u 锚点水平范围的比例，建议传入0 到1 之间的数值。
     * @param v 锚点垂直范围的比例，建议传入0 到1 之间的数值。
     * @return 一个设置了定位图标锚点的MyLocationStyle对象。
     * @since 1.0.0
     */
    anchor(j39: number, v: number): MyLocationStyle | null;
    /**
     * 设置圆形区域（以定位位置为圆心，定位半径的圆形区域）的填充颜色。
     *
     * @param color 圆形区域的填充颜色。
     * @return 一个设置了定位圆形区域填充颜色的MyLocationStyle对象。
     * @since 1.0.0
     */
    radiusFillColor(color: number): MyLocationStyle | null;
    /**
     * 设置圆形区域（以定位位置为圆心，定位半径的圆形区域）的边框颜色。
     *
     * @param color 圆形区域的边框颜色。
     * @return 一个设置了定位圆形区域边框颜色的MyLocationStyle对象。
     * @since 1.0.0
     */
    strokeColor(color: number): MyLocationStyle | null;
    /**
     * 设置圆形区域（以定位位置为圆心，定位半径的圆形区域）的边框宽度。
     *
     * @param width 圆形区域的边框宽度。
     * @return 一个设置了定位圆形区域边框宽度的MyLocationStyle对象。
     * @since 1.0.0
     */
    strokeWidth(width: number): MyLocationStyle | null;
    /**
     * 设置我的位置展示模式，模式分别为 <br>
     * <tr>{@link #LOCATION_TYPE_SHOW}</tr>
     * <tr>{@link #LOCATION_TYPE_LOCATE}</tr>
     * <tr>{@link #LOCATION_TYPE_MAP_ROTATE}</tr>
     * <tr>{@link #LOCATION_TYPE_LOCATION_ROTATE}</tr> (默认)
     *
     * @return 一个设置了展示模式的MyLocationStyle对象。
     * @since 1.0.0
     */
    myLocationType(type: number): MyLocationStyle | null;
    /**
     * 设置是否显示定位小蓝点，true 显示，false不显示。<br>
     * 默认为true，设置false不显示定位小蓝点但是会持续定位
     *
     *  @return 一个设置了是否显示定位小蓝点的MyLocationStyle对象。
     * @since 1.0.0
     */
    showMyLocation(i39: boolean): MyLocationStyle | null;
    /**
     * 得到当前位置的图标。
     *
     * @return 当前位置的图标。
     * @since 1.0.0
     */
    getMyLocationIcon(): BitmapDescriptor | undefined;
    /**
     * 得到锚点横坐标方向的偏移量。
     *
     * @return 锚点横坐标方向的偏移量。
     * @since 1.0.0
     */
    getAnchorU(): number;
    /**
     * 得到锚点纵坐标方向的偏移量。
     *
     * @return 锚点纵坐标方向的偏移量。
     * @since 1.0.0
     */
    getAnchorV(): number;
    /**
     * 得到圆形区域（以定位位置为圆心，定位半径的圆形区域）的填充颜色值。
     *
     * @return 圆形区域的填充颜色值。
     * @since 1.0.0
     */
    getRadiusFillColor(): number;
    /**
     * 得到圆形区域（以定位位置为圆心，定位半径的圆形区域）边框的颜色值。
     *
     * @return 圆形区域边框的颜色值。
     * @since 1.0.0
     */
    getStrokeColor(): number;
    /**
     * 得到圆形区域（以定位位置为圆心，定位半径的圆形区域）边框的宽度。
     *
     * @return 圆形区域边框的宽度。
     * @since 1.0.0
     */
    getStrokeWidth(): number;
    /**
     * 得到我的位置展示模式。
     *
     * @return 我的位置展示模式。
     * @since 1.0.0
     */
    getMyLocationType(): number;
    /**
     * 得到是否显示定位小蓝点。
     * @return 是否显示定位小蓝点。
     * @since 1.0.0
     */
    isMyLocationShowing(): boolean;
}
