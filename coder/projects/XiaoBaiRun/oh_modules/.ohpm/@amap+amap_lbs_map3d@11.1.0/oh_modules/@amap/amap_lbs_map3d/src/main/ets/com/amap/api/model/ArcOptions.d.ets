// @keepTs
// @ts-nocheck
import { BaseOptions } from "./BaseOptions";
import { LatLng } from "./LatLng";
export declare class ArcOptions extends BaseOptions {
    /**
     * @internal
     */
    static readonly TAG: string;
    /**
     * @internal
     */
    id?: string;
    private startpoint?;
    private passedpoint?;
    private endpoint?;
    private strokeWidth;
    private strokeColor;
    private zIndex;
    private isVisible;
    /**
     * 设置弧线的起终点和途径点。
     *
     * @param startpoint  弧线的起点坐标。
     * @param passedpoint 弧线的途经点坐标。
     * @param endpoint    弧线的终点坐标。
     * @return 设置弧线的起终点和途径点的  ArcOptions 对象。
     * @since 2.2.3
     */
    point(y21: LatLng, z21: LatLng, endpoint: LatLng): ArcOptions;
    /**
     * 设置弧形边框宽度参数，单位：像素。参数必须大于等于0，默认10。
     *
     * @param width 边框宽度，单位：像素。
     * @return 设置新边框宽度的 ArcOptions 对象。
     * @since 2.2.3
     */
    setStrokeWidth(width: number): ArcOptions;
    /**
     * 设置弧形边框颜色参数，ARGB格式。如果设置透明，则边框不会被绘制。默认黑色。
     *
     * @param color 边框颜色，ARGB格式。
     * @return 设置新边框颜色的 ArcOptions 对象。
     * @since 2.2.3
     */
    setStrokeColor(color: number): ArcOptions;
    /**
     * 设置弧形Z轴数值参数，默认为0。
     *
     * @param zIndex Z轴数值。
     * @return 设置新Z轴数值的 ArcOptions 对象。
     * @since 2.2.3
     */
    setZIndex(zIndex: number): ArcOptions;
    /**
     * 设置弧形是否可见参数。
     *
     * @param visible true为可见，false为不可见。
     * @return 设置新可见属性的 ArcOptions 对象。
     * @since 2.2.3
     */
    visible(visible: boolean): ArcOptions;
    /**
     * 返回弧形边框宽度，单位：像素。
     *
     * @return 弧形边框宽度，单位：像素。
     * @since 2.2.3
     */
    getStrokeWidth(): number;
    /**
     * 返回弧形边框颜色，ARGB格式。
     *
     * @return 弧形边框颜色，ARGB格式。
     * @since 2.2.3
     */
    getStrokeColor(): number;
    /**
     * 返回弧形Z轴的数值。
     *
     * @return 弧形Z轴的数值。
     * @since 2.2.3
     */
    getZIndex(): number;
    /**
     * 返回弧形是否可见。
     *
     * @return true表示可见； false表示不可见。
     * @since 2.2.3
     */
    getIsVisible(): boolean;
    /**
     * 返回圆弧起点
     *
     * @return 圆弧起点
     * @since 2.2.3
     */
    getStart(): LatLng | undefined;
    /**
     * 返回圆弧中点
     *
     * @return 圆弧中点
     * @since 2.2.3
     */
    getPassed(): LatLng | undefined;
    /**
     * 返回圆弧终点
     *
     * @return 圆弧终点
     * @since 2.2.3
     */
    getEnd(): LatLng | undefined;
}
