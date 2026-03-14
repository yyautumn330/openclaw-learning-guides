// @keepTs
// @ts-nocheck
/**
 * 定义在地图上绘制多边形覆盖物。一个多边形可以凸面体，也可是凹面体。
 * 它有以下属性:
 * 边框
 * 一个多边开的边框由一系列的顺时针或逆时针顶点组成。边框不需要声明起点和终点一致。如果边框的起点与终点不一致，API会自动将它封闭。
 * 边框宽度
 * 边框的宽度以像素为单位，不会受可视区域缩放级别的影响。默认为10。
 * 边框颜色
 * 边框颜色是一个ARGB格式，ARGB请参考android.graphics.Color。默认为黑色。
 * 填充颜色
 * 填充颜色是一个ARGB格式，ARGB格式可参考android.graphics.Color。默认是透明的。如果多边形的几何图形不正确，则填充颜色不会被绘制。
 * Z轴
 * Z轴是控制覆盖物重复区域的绘制顺序的值。Z轴较大的覆盖物会在绘制在Z轴较小的覆盖物上面。如果两个覆盖物的Z轴数值相同，则覆盖情况将随机。默认为0。
 * 可见性
 * 标示多边形是否可见。如果可见性为否，则不会被绘制。 多边形方法必须在主线程中调用，否则会抛出IllegalStateException。
 * @since 1.0.0
 */
import ArrayList from '@ohos.util.ArrayList';
import { BaseOverlay } from './BaseOverlay';
import { PolygonOptions } from './PolygonOptions';
import { d16 } from '../../mapcore/interface/IGLOverlayLayer';
import { LatLng } from './LatLng';
import { BaseHoleOptions } from './BaseHoleOptions';
export declare class Polygon extends BaseOverlay {
    private static readonly TAG;
    private options;
    private glOverlayLayer;
    /**
     * @exclude javadoc中不显示
     */
    constructor(u42: d16, options: PolygonOptions, v42: string);
    /**
     * 从地图上删除当前多边形。
     *
     * @since 1.0.0
     */
    remove(): void;
    /**
     * 获取多边形的Id。
     *
     * @return 返回多边形Id。Id是区分一个地图里不同多边形的标识。
     * @since 1.0.0
     */
    getId(): string;
    /**
     * 设置多边形的顶点。设置完成后再修改顶点列表的值，不会影响多边形。
     *
     * @param points 多边形顶点列表
     * @since 1.0.0
     */
    setPoints(points: ArrayList<LatLng>): void;
    /**
     * 获取多边形的顶点列表。如果调用此方法后，多边形的顶点发生了变化，列表的值不会随之改变。如果调用此方法获得顶点坐标后并且修改了顶点坐标，
     * 也不会作用到当前多边形。如果需要修改多边形的顶点值必须调用setPoints(List)。
     *
     * @since 1.0.0
     */
    getPoints(): ArrayList<LatLng>;
    /**
     * 设置多边形空心洞的配置项集合
     *
     * @param options 空心洞的配置项集合
     * @since 1.0.0
     */
    setHoleOptions(options: ArrayList<BaseHoleOptions>): void;
    /**
     * 获取多边形空心洞的配置项集合
     *
     * @return 空心洞的配置项集合
     * @since 1.0.0
     */
    getHoleOptions(): ArrayList<BaseHoleOptions>;
    /**
     * 设置多边形的边框宽度
     *
     * @param width 多边形边框宽度，单位：像素
     * @since 1.0.0
     */
    setStrokeWidth(width: number): void;
    /**
     * 获取多边形的边框宽度
     *
     * @return 宽度  单位：像素
     * @since 1.0.0
     */
    getStrokeWidth(): number;
    /**
     * 设置多边形的边框颜色
     *
     * @param color 边框颜色，ARGB格式。
     * @since 1.0.0
     */
    setStrokeColor(color: number): void;
    /**
     * 获取多边形的边框颜色
     *
     * @return ARGB格式
     * @since 1.0.0
     */
    getStrokeColor(): number;
    /**
     * 设置多边形的填充颜色
     *
     * @param color 填充颜色的ARGB格式
     * @since 1.0.0
     */
    setFillColor(color: number): void;
    /**
     * 获取多边形的填充颜色
     *
     * @return 多边形填充颜色，ARGB格式。
     * @since 1.0.0
     */
    getFillColor(): number;
    /**
     * 设置多边形的Z轴数值。数值更高的多边形将绘制在数值较低的上面。
     *
     * @param zIndex 多边形Z轴数值
     * @since 1.0.0
     */
    setZIndex(zIndex: number): void;
    /**
     * 获取多边形的Z轴值
     *
     * @return 多边形的Z轴值
     * @since 1.0.0
     */
    getZIndex(): number;
    /**
     * 设置多边形的可见属性。当不可见时，多边形将不会被绘制，但是其他属性将会保存。
     *
     * @param visible true：可见；false：不可见。
     * @since 1.0.0
     */
    setVisible(visible: boolean): void;
    /**
     * 获取多边形是否可见。
     *
     * @return true: 可见，false: 不可见
     * @since 1.0.0
     */
    isVisible(): boolean;
    /**
     * 判断多边形是否包含传入的经纬度点。
     *
     * @param latLng 经纬度点。
     * @return true 多边形包含这个点,false 多边形未包含这个点。
     * @since 1.0.0
     */
    contains(latLng: LatLng): boolean;
    private updateOption;
}
