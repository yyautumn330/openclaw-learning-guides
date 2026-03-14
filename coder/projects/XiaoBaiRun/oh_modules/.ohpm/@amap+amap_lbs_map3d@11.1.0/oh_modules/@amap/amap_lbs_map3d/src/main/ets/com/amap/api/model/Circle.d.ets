// @keepTs
// @ts-nocheck
/**
 * 定义了在地图上绘制圆的类。
 * 圆对象有以下属性：
 * 圆心 ：圆心的经纬度。
 * 半径： 圆的半径，单位：米。这个值应该大于等于0。
 * 边框宽度： 圆的边框宽度。这个值设置后不会受到可视区域缩放级别的影响。默认为10。
 * 边框颜色：圆的边框颜色，ARGB格式。默认为黑色。
 * 填充颜色：圆的填充颜色，ARGB格式。默认为透明。
 * Z轴：Z轴是控制覆盖物重复区域的绘制顺序的值。Z轴较大的覆盖物会绘制在Z轴较小的覆盖物上面。如果两个覆盖物的Z轴数值相同，则覆盖情况将随机。默认值为0。
 * 可见属性：标识多边形是否可见。如果可见性为否，则不会被绘制。 圆形方法必须在主线程中调用，否则会抛出IllegalStateException。
 *
 * @since 1.0.0
 */
import { BaseOverlay } from './BaseOverlay';
import { d16 } from '../../mapcore/interface/IGLOverlayLayer';
import ArrayList from '@ohos.util.ArrayList';
import { BaseHoleOptions } from './BaseHoleOptions';
import { LatLng } from './LatLng';
import { CircleOptions } from './CircleOptions';
import { DottedLineType } from './BaseOptions';
export declare class Circle extends BaseOverlay {
    private static readonly TAG;
    private options;
    private glOverlayLayer;
    /**
     * @exclude javadoc中不显示
     */
    constructor(b24: d16, options: CircleOptions, c24: string);
    /**
     * 删除从地图对象里圆
     *
     * @since 1.0.0
     */
    remove(): void;
    /**
     * 返回圆的id。
     *
     * @return 返回圆的id。此id是覆盖物在所属的地图对象里的唯一标识。
     * @since 1.0.0
     */
    getId(): string;
    /**
     * 设置圆心经纬度坐标，参数不能为null，无默认值。
     *
     * @param center 圆心经纬度坐标。
     * @throws NullPointerException 如果圆心经纬度坐标为null。
     * @since 1.0.0
     */
    setCenter(center: LatLng): void;
    /**
     * 获取圆心经纬度坐标。
     *
     * @return 圆心经纬度坐标。
     * @since 1.0.0
     */
    getCenter(): LatLng;
    /**
     * 设置圆的半径，单位米。半径必须大于等于0。
     *
     * @param radius 圆形半径，单位米。
     * @throws IllegalArgumentException 如果传入的半径为负数。
     * @since 1.0.0
     */
    setRadius(radius: number): void;
    /**
     * 获取圆的半径，单位米。
     *
     * @return 圆形半径，单位米。
     * @since 1.0.0
     */
    getRadius(): number;
    /**
     * 设置圆的边框宽度，单位像素。参数必须大于等于0。如果为0则不会绘制边框。默认为10。
     *
     * @param width 边框宽度，单位像素。
     * @throws IllegalArgumentException 如果宽度为负数。
     * @since 1.0.0
     */
    setStrokeWidth(width: number): void;
    /**
     * 获取圆的边框宽度。
     *
     * @return 圆的边框宽度，单位像素。
     * @since 1.0.0
     */
    getStrokeWidth(): number;
    /**
     * 设置圆的边框颜色。
     *
     * @param color 边框颜色，ARGB格式。
     * @since 1.0.0
     */
    setStrokeColor(color: number): void;
    /**
     * 获取圆的边框颜色
     *
     * @return 圆的边框颜色，ARGB格式。
     * @since 1.0.0
     */
    getStrokeColor(): number;
    /**
     * 设置圆的填充颜色。填充颜色是绘制边框以内部分的颜色，ARGB格式。
     *
     * @param color 填充颜色ARGB格式。
     * @since 1.0.0
     */
    setFillColor(color: number): void;
    /**
     * 获取圆的填充颜色
     *
     * @return 圆填充颜色的ARGB格式
     * @since 1.0.0
     */
    getFillColor(): number;
    /**
     * 设置圆的Z轴数值。数值更高的圆将绘制在数值较低的上面。
     *
     * @param zIndex Z轴数值。
     * @since 1.0.0
     */
    setZIndex(zIndex: number): void;
    /**
     * 获取圆的Z轴数值
     *
     * @return 圆的Z轴数值
     * @since 1.0.0
     */
    getZIndex(): number;
    /**
     * 设置圆的可见属性。如果不可见属性为false，则不会被绘制在地图上。默认为true。
     *
     * @param visible true为可见；false不可见。
     * @since 1.0.0
     */
    setVisible(visible: boolean): void;
    /**
     * 获取圆是否可见
     *
     * @return true 为可见，false为不可见。
     * @since 1.0.0
     */
    isVisible(): boolean;
    /**
     * 判断圆是否包含传入的经纬度点。
     *
     * @param latLng 经纬度点。
     * @return true 包含，false 为不包含。
     * @since 1.0.0
     */
    contains(latLng: LatLng): boolean;
    /**
     * 设置洞的配置项集合
     *
     * @param options 洞的配置项集合
     * @since 1.0.0
     */
    setHoleOptions(options: ArrayList<BaseHoleOptions>): void;
    /**
     * 获取洞的配置项集合
     *
     * @return 洞的配置项集合
     * @since 1.0.0
     */
    getHoleOptions(): ArrayList<BaseHoleOptions>;
    setDottedLineType(type: DottedLineType): void;
    getDottedLineType(): DottedLineType;
    private updateOption;
}
