// @keepTs
// @ts-nocheck
/**
 * 多边形覆盖物选项类
 *
 * @since 1.0.0
 */
import ArrayList from '@ohos.util.ArrayList';
import { BaseOptions, BaseUpdateFlags, LineJoinType } from './BaseOptions';
import { BaseHoleOptions } from './BaseHoleOptions';
import { LatLng } from './LatLng';
export declare class PolygonOptions extends BaseOptions {
    static readonly TAG: string;
    protected id: string;
    private pointWithHoles;
    private lineJoinType;
    private readonly pointsArray;
    private holeOptionsArray;
    private points;
    private strokeWidth;
    private strokeColor;
    private fillColor;
    private zIndex;
    private visible;
    private polygonHoleOptions;
    private circleHoleOptions;
    private isUsePolylineStroke;
    private nLineCapType;
    private nLineJoinType;
    private updateFlags;
    /**
     * 创建PolygonOptions对象。
     */
    constructor();
    /**
     * @return
     * @exclude javadoc中不显示
     */
    describeContents(): number;
    /**
     * @param out
     * @param arg1
     * @exclude javadoc中不显示
     */
    /**
     * 添加一个多边形边框的顶点
     *
     * @return 加入边形边框顶点的PolygonOptions对象
     * @since 1.0.0
     */
    add(p43: LatLng): PolygonOptions;
    /**
     * 添加多个多边形边框的顶点
     *
     * @return 加入多个新的多边形边框顶点的PolygonOptions对象
     * @since 1.0.0
     */
    add(...r43: LatLng[]): PolygonOptions;
    /**
     * 添加多个多边形边框的顶点
     *
     * @return 加入多个新的多边形边框顶点的PolygonOptions对象
     * @since 1.0.0
     */
    /**
     * 设置多边形的经纬度点
     * @return
     * @since 1.0.0
     * @exclude javadoc中不显示
     */
    setPoints(points: ArrayList<LatLng>): void;
    /**
     * 设置多边形洞的属性
     * @return
     * @since 1.0.0
     * @exclude javadoc中不显示
     */
    setHoleOptions(o43: ArrayList<BaseHoleOptions>): void;
    /**
     * 设置多边形洞的属性
     * @return
     * @since V6.6.0
     * @exclude javadoc中不显示
     */
    private processPolygonHoleOption;
    /**
     * 设置空心洞的配置项
     *
     * @return 设置空心洞的配置项的 PolygonOptions 对象
     *
     * @since 1.0.0
     */
    addHoles(...g43: BaseHoleOptions[]): PolygonOptions;
    /**
     * 添加空心洞的配置项
     *
     * @return 设置holeOptions的PolygonOptions对象
     *
     * @since 1.0.0
     */
    private updateHolesPoints;
    /**
     * 设置多边形的边框宽度，单位：像素。默认为10
     *
     * @return 设置新的边框宽度后PolygonOptions 对象
     * @since 1.0.0
     */
    setStrokeWidth(e43: number): PolygonOptions;
    /**
     * 设置多边形的边框颜色，32位 ARGB格式，默认为黑色。
     *
     * @return 设置新的边框颜色后PolygonOptions 对象
     * @since 1.0.0
     */
    setStrokeColor(d43: number): PolygonOptions;
    /**
     * 设置多边形的填充颜色，32位ARGB格式。默认黑色。
     *
     * @return 设置新的填充颜色后PolygonOptions对象
     * @since 1.0.0
     */
    setFillColor(c43: number): PolygonOptions;
    /**
     * 设置多边形的Z轴数值
     *
     * @return 设置新的Z轴数值后PolygonOptions 对象
     * @since 1.0.0
     */
    setZIndex(b43: number): PolygonOptions;
    /**
     * 设置多边形是否可见。默认为可见
     *
     * @return 设置新的可见属性后PolygonOptions 对象
     * @since 1.0.0
     */
    setVisible(a43: boolean): PolygonOptions;
    /**
     * 返回多边形坐标点列表
     *
     * @return 多边形坐标点列表
     * @since 1.0.0
     */
    getPoints(): ArrayList<LatLng>;
    /**
     * 获取多边形的边框宽度
     *
     * @return 多边形边框宽度
     * @since 1.0.0
     */
    getStrokeWidth(): number;
    /**
     * 获取多边形的边框颜色
     *
     * @return 多边形边框颜色
     * @since 1.0.0
     */
    getStrokeColor(): number;
    /**
     * 获取多边形的填充颜色
     *
     * @return 多边形填充颜色
     * @since 1.0.0
     */
    getFillColor(): number;
    /**
     * 获取多边形的Z轴数值
     *
     * @return 多边形Z轴数值
     * @since 1.0.0
     */
    getZIndex(): number;
    /**
     * 获取多边形是否可见
     *
     * @return true为可见；false为不可见
     * @since 1.0.0
     */
    getVisible(): boolean;
    /**
     * 获取空心洞的配置项
     *
     * @return 空心洞的配置项列表
     *
     * @since 1.0.0
     */
    getHoleOptions(): ArrayList<BaseHoleOptions>;
    /**
     * 设置边框连接处形状
     *
     * @param lineJoinType 形状
     * @return 设置边框连接处形状后的对象
     * @since 2.0.0
     */
    setLineJoinType(z42: LineJoinType): PolygonOptions;
    /**
     * 返回边框连接处形状
     *
     * @return 形状
     * @since 2.0.0
     */
    getLineJoinType(): LineJoinType;
    /**
     * 是否使用polyline绘制边框
     *
     * @param isUsePolylineStroke 是否使用polyline绘制边框
     * @return 设置属性后的对象
     * @since 6.9.4
     * @exclude javadoc中不显示 切换边框内部实现方式，后续版本可以删除
     */
    setUsePolylineStroke(y42: boolean): PolygonOptions;
    /**
     * 是否使用polyline绘制边框
     *
     * @return 是否使用polyline绘制边框
     * @since 6.9.4
     * @exclude javadoc中不显示 切换边框内部实现方式，后续版本可以删除
     */
    getUsePolylineStroke(): boolean;
    /**
     * @exclude javadoc中不显示
     */
    /**
     * 获取屏幕坐标
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
    getUpdateFlags(): PolygonUpdateFlags;
}
declare class PolygonUpdateFlags {
    isPointsUpdated: boolean;
    isHoleOptionsUpdated: boolean;
    baseUpdateFlags: BaseUpdateFlags;
    reset(): void;
}
export {};
