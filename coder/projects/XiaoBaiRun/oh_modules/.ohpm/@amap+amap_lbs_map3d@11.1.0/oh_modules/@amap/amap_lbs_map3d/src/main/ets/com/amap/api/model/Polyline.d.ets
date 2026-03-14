// @keepTs
// @ts-nocheck
/**
 * 定义地图线段覆盖物。一个线段是多个连贯点的集合线段。
 * 它拥有以下属性：
 * 顶点
 * 线段是由两个顶点之间连贯的点构成的。如果两个顶点相同，则一个线段将闭合。
 * 宽度
 * 宽度是单位是像素。宽度是可视区域的缩放级别无关。默认为10。
 * 颜色
 * 线段的颜色是ARGB格式，颜色格式可以参考 {@link android.graphics.Color}。默认是黑色(0xff000000)。
 * Z轴
 * Z轴是控制地图覆盖物（overlay）之间的绘制层次的参数。这个参数能够控制Circles、Polygons、Polyline的绘制层次，但不会影响marker。
 * Z轴数值越大的覆盖物（overlay）将会绘制在更上层。如果两个及两个以上覆盖物（overlay）的Z轴数值相同，则最后的绘制结果是随机的。 覆盖物（overlay）的Z轴默认为0。
 * 可见
 * 这个属性表示了线段是否可以显示在地图上。如果设置为不可见，则绘制地图时不会绘制此线段，但其他属性不受影响。默认为可见。
 *
 * @since 1.0.0
 */
import ArrayList from '@ohos.util.ArrayList';
import { PolylineOptions } from './PolylineOptions';
import { BaseOverlay } from './BaseOverlay';
import { d16 } from '../../mapcore/interface/IGLOverlayLayer';
import { LatLng } from './LatLng';
export declare class Polyline extends BaseOverlay {
    static readonly TAG: string;
    private options;
    private glOverlayLayer;
    /**
     * 构造一个新的Polyline 对象。
     *
     * @exclude javadoc中不显示
     */
    constructor(h44: d16, options: PolylineOptions);
    constructor(f44: d16, options: PolylineOptions, g44: string);
    /**
     * 从地图上删除当前线段。线段删除后，被删除的线段的方法均无效。
     *
     * @since 1.0.0
     */
    remove(): void;
    /**
     * 获取线段的Id。线段的Id用于区分在同一个地图里面不同的线段覆盖物。
     *
     * @return Id
     * @since 1.0.0
     */
    getId(): string;
    /**
     * 设置线段的坐标点列表。如果调用此方法后修改了List的值将不会影响到线段。
     *
     * @param points 线段顶点的坐标列表
     * @since 1.0.0
     */
    setPoints(points: ArrayList<LatLng>): void;
    /**
     * 获取线段的顶点坐标点列表。如果调用此方法后，线段的顶点发生了变化，列表的值不会随之改变。
     * <p>如果调用此方法获得顶点坐标后并且修改了顶点坐标，也不会作用到当前线程。如果需要修改线段的顶点值必须调用 {@link #setPoints(List)}。</p>
     *
     * @return 线段的顶点坐标列表。
     * @since 1.0.0
     */
    getPoints(): ArrayList<LatLng>;
    /**
     * 设置线段是否画大地曲线，默认false，不画大地曲线。
     *
     * @param geodesic true：画大地曲线；false：不画大地曲线。
     * @since V2.0.0
     */
    setGeodesic(geodesic: boolean): void;
    /**
     * 获取线段是否为大地曲线，默认false，不画大地曲线。
     *
     * @return true 为大地曲线，flase 不是大地曲线。
     * @since 1.0.0
     */
    isGeodesic(): boolean;
    /**
     * 设置线段是否虚线，默认为false，画实线。
     *
     * @param isDottedLine true，画虚线；false，画实线。
     * @since 1.0.0
     */
    setDottedLine(c44: boolean): void;
    /**
     * 获取线段是否虚线。
     *
     * @return true，虚线；false，实线。
     * @since 1.0.0
     */
    isDottedLine(): boolean;
    /**
     * 设置线段的宽度
     *
     * @param width 线段宽度 单：像素
     * @since 1.0.0
     */
    setWidth(width: number): void;
    /**
     * 获取线段的宽度
     *
     * @return 线段宽度 单位：像素
     * @since 1.0.0
     */
    getWidth(): number;
    /**
     * 设置线段的颜色
     *
     * @param color 颜色的ARGB格式
     * @since 1.0.0
     */
    setColor(color: number): void;
    /**
     * 获取线段的颜色
     *
     * @return 线段颜色的ARGB格式
     * @since 1.0.0
     */
    getColor(): number;
    /**
     * 设置线段的z轴值。
     *
     * @param zIndex z轴值。
     * @since 1.0.0
     */
    setZIndex(zIndex: number): void;
    /**
     * 获取线段的z轴值。
     *
     * @return z轴值
     * @since 1.0.0
     */
    getZIndex(): number;
    /**
     * 设置线段的可见属性。当不可见时，线段不会被绘制。
     *
     * @param visible true: 可见; false: 不可见。
     * @since 1.0.0
     */
    setVisible(visible: boolean): void;
    /**
     * 获取线段是否可见
     *
     * @return true: 可见; false: 不可见
     * @since 1.0.0
     */
    isVisible(): boolean;
    equals(other: object): boolean;
    /**
     * 获取某坐标点距线上最近的坐标点。
     *
     * @param latLng - 一个经纬度点。
     * @return 某点到线上最近的点。
     * @since 1.0.0
     */
    getNearestLatLng(latLng: LatLng): LatLng;
    /**
     * 设置线段的透明度，需要使用纹理，此方法才有效，如果只设置颜色透明度，使用color即可
     *
     * @param transparency 透明度 范围0~1, 默认是1, 1表示不透明
     * @since 1.0.0
     */
    setTransparency(transparency: number): void;
    /**
     * 设置线段选项信息<br>
     * 设置多个属性时可以使用此方法,单个属性设置建议使用各自对应的方法。<br>
     *
     * @param options 线段选项信息 {@link PolylineOptions}
     * @since 1.0.0
     */
    setOptions(options: PolylineOptions): void;
    /**
     * 获取线段选项信息
     *
     * @return 线段选项信息 {@link PolylineOptions}
     * @since 1.0.0
     */
    getOptions(): PolylineOptions;
    private updateOption;
    /**
     * 将List<LatLng> 格式的points转换为 number [] 格式的pointsList，jni层直接使用pointsList
     */
    protected setOptionPointList(options: object): void;
}
