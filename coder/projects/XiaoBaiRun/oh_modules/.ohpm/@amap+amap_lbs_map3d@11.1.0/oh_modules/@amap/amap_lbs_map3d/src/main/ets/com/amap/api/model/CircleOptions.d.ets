// @keepTs
// @ts-nocheck
/**
 * 创建圆的选项类
 *
 * @since 1.0.0
 */
import ArrayList from '@ohos.util.ArrayList';
import { BaseOptions, BaseUpdateFlags, DottedLineType } from './BaseOptions';
import { PolygonOptions } from './PolygonOptions';
import { LatLng } from './LatLng';
import { BaseHoleOptions } from './BaseHoleOptions';
export declare class CircleOptions extends BaseOptions {
    private static readonly TAG;
    protected id: string;
    private holeOptionsArray;
    options: PolygonOptions;
    private point;
    private radius;
    private strokeWidth;
    private strokeColor;
    private fillColor;
    private zIndex;
    private visible;
    private polygonHoleOptions;
    private circleHoleOptions;
    private dottedLineType;
    private usePolylineStroke;
    private updateFlags;
    /**
     * @return
     * @exclude javadoc中不显示
     */
    constructor();
    /**
     * @return
     * @exclude javadoc中不显示
     */
    /**
     * @return
     * @exclude javadoc中不显示
     */
    /**
     * @param out
     * @param paramInt
     * @exclude javadoc中不显示
     */
    /**
     * @return
     * @exclude javadoc中不显示
     */
    describeContents(): number;
    /**
     * 设置圆心经纬度坐标。圆心经纬度坐标不能为Null，圆心经纬度坐标无默认值。
     *
     * @return 设置圆心经纬度坐标的CircleOptions对象
     * @since 1.0.0
     */
    setCenter(point: LatLng): CircleOptions;
    private createPoints;
    /**
     * 设置圆的半径，单位米。半径必须大于等于0。
     *
     * @param radius
     *            半径，单位米
     * @return 设置新半径的CircleOptions对象。
     * @since 1.0.0
     */
    setRadius(radius: number): CircleOptions;
    /**
     * 设置圆的边框宽度，单位像素。参数必须大于等于0，默认10。
     *
     * @param width 边框宽度，单位像素
     * @return 设置新边框宽度的CircleOptions对象。
     * @since 1.0.0
     */
    setStrokeWidth(width: number): CircleOptions;
    /**
     * 设置圆的边框颜色，ARGB格式。如果设置透明，则边框不会被绘制。默认黑色。
     *
     * @param color 设置边框颜色，ARGB格式。
     * @return 设置新边框颜色的CircleOptions对象。
     * @since 1.0.0
     */
    setStrokeColor(color: number): CircleOptions;
    /**
     * 设置圆的填充颜色。填充颜色是绘制边框以内部分的颜色，ARGB格式。默认透明。
     *
     * @param color 填充颜色ARGB格式
     * @return 设置填充颜色的CircleOptions对象
     * @since 1.0.0
     */
    setFillColor(color: number): CircleOptions;
    /**
     * 设置圆的Z轴数值，默认为0。
     *
     * @param zIndex z轴数值
     * @return 设置新z轴数值的CircleOptions对象。
     * @since 1.0.0
     */
    setZIndex(zIndex: number): CircleOptions;
    /**
     * 设置圆的可见属性
     *
     * @param visible true为可见，false为不可见
     * @return 设置新可见属性的CircleOptions对象。
     * @since 1.0.0
     */
    setVisible(visible: boolean): CircleOptions;
    /**
     * 获取圆心经纬度坐标
     *
     * @return 圆点经纬度坐标
     * @since 1.0.0
     */
    getCenter(): LatLng;
    /**
     * 获取圆的半径，单位米。
     *
     * @return 圆半径，单位米
     * @since 1.0.0
     */
    getRadius(): number;
    /**
     * 获取圆的边框宽度。
     *
     * @return 圆的边框宽度，单位像素。
     * @since 1.0.0
     */
    getStrokeWidth(): number;
    /**
     * 获取圆的边框颜色。
     *
     * @return 圆的边框颜色，ARGB格式
     * @since 1.0.0
     */
    getStrokeColor(): number;
    /**
     * 获取圆的填充颜色
     *
     * @return 圆的填充颜色，ARGB格式。
     * @since 1.0.0
     */
    getFillColor(): number;
    /**
     * 获取圆的Z轴的值
     *
     * @return 圆Z轴的值
     * @since 1.0.0
     */
    getZIndex(): number;
    /**
     * 获取圆是否可见
     *
     * @return true可见; false 不可见
     * @since 1.0.0
     */
    getVisible(): boolean;
    /**
     * 添加空心洞的配置项
     * @return 设置holeOptions的CircleOptions对象
     *
     * @since 1.0.0
     */
    addHoles(...q24: BaseHoleOptions[]): CircleOptions;
    /**
     * 添加空心洞的配置项
     * @return 设置holeOptions的CircleOptions对象
     *
     * @since 1.0.0
     */
    /**
     * @exclude javadoc中不显示
     */
    getHoleOptions(): ArrayList<BaseHoleOptions>;
    setDottedLineType(type: DottedLineType): CircleOptions;
    getDottedLineType(): DottedLineType;
    setUsePolylineStroke(p24: boolean): CircleOptions;
    getUsePolylineStroke(): boolean;
    private processCircleHoleOption;
    /**
     * @exclude javadoc中不显示
     */
    toJson(): string;
    /**
     * 用于Native判断当前有哪些数据有更新
     * @exclude javadoc中不显示。
     */
    resetUpdateFlags(): void;
    /**
     * 用于Native判断当前有哪些数据有更新
     * @exclude javadoc中不显示。
     */
    protected getUpdateFlags(): CircleUpdateFlags;
}
export declare class CircleUpdateFlags {
    isCenterUpdated: boolean;
    isRadiusUpdated: boolean;
    isHoleOptionsUpdated: boolean;
    baseUpdateFlags: BaseUpdateFlags;
    reset(): void;
}
