// @keepTs
// @ts-nocheck
import { BaseOptions } from "./BaseOptions";
import { Gradient } from "./Gradient";
import ArrayList from "@ohos.util.ArrayList";
import { WeightedLatLng } from "./WeightedLatLng";
import { LatLng } from "./LatLng";
/**
 * 实现高德热力图
 *
 * @author qsh
 * @since 2.2.5
 *
 */
export declare class HeatMapLayerOptions extends BaseOptions {
    /**
     * 热力图默认的点半径
     *
     * @since 2.2.5
     */
    static readonly DEFAULT_RADIUS = 12;
    /**
     * 热力图层默认透明度
     *
     * @since 2.2.5
     */
    static readonly DEFAULT_OPACITY = 0.6;
    /**
     * 热力图默认渐变
     *
     * @since 2.2.5
     */
    private static readonly r29;
    static rgb(red: number, green: number, blue: number): number;
    private static readonly s29;
    /**
     * 热力图层类型-普通热力图（暂不支持）
     *
     * @since 2.2.5
     */
    static readonly TYPE_NORMAL = 0;
    /**
     * 热力图层类型-网格热力图
     *
     * @since 2.2.5
     */
    static readonly TYPE_GRID = 1;
    /**
     * 热力图层类型-蜂巢热力图
     *
     * @since 2.2.5
     */
    static readonly TYPE_HEXAGON = 2;
    /**
     * 热力图默认渐变
     *
     * @since 2.2.5
     */
    static readonly DEFAULT_GRADIENT: Gradient;
    private mGradient;
    private mData?;
    private mSize;
    private mOpacity;
    private maxIntensity;
    private maxZoom;
    private minZoom;
    private mGap;
    private mType;
    private zIndex;
    private isVisible;
    private isPointsUpdated;
    private pointList?;
    private mColors?;
    private mStartPoints?;
    private mLatitude;
    constructor();
    /**
     * 设置热力图绘制的数据，data 或 weightedData接口必须设置其中之一
     *
     * @param val 热力图绘制数据，不能为null，大小不能为 0.
     * @return 更新后的热力图提供者构造器引用
     * @since 2.2.5
     */
    data(val: ArrayList<LatLng>): HeatMapLayerOptions;
    /**
     * 设置热力图绘制的数据，带权值的位置点集合，data 或 weightedData接口必须设置其中之一
     *
     * @param val 热力图绘制数据，不能为null，大小不能为 0.
     * @return 更新后的热力图提供者构造器引用
     * @since 2.2.5
     */
    weightedData(val: ArrayList<WeightedLatLng>): this;
    /**
     * 设置热力图点大小，单位为米，默认为2000米
     *
     *    —— ——    —— ——
     *  丨     丨 丨     丨
     *  丨     丨 丨     丨
     *    —— ——    —— ——
     *
     *  每个方框的宽就是 size（六边形同理）
     *  两个放款之间的间隔就是 gap （六边形同理）
     *
     *
     *
     * @param val 热力图点
     * @return 更新后的热力图提供者构造器引用
     * @since 2.2.5
     */
    size(val: number): this;
    /**
     * 设置热力图渐变，有默认值 DEFAULT_GRADIENT，可不设置该接口
     *
     * @param val 热力图渐变
     * @return 更新后的热力图提供者构造器引用
     * @since 2.2.5
     */
    gradient(val: Gradient): this;
    /**
     * 设置热力图层透明度，默认 0.6，可不设置该接口
     *
     * @param val 热力图层透明度 [0, 1]
     * @return 更新后的热力图提供者构造器引用
     * @since 2.2.5
     */
    opacity(val: number): this;
    /**
     * 权重的最大值，默认为0，表示不填，不填则取数据集权重最大值
     * 对颜色选择有影响，计算颜色比例是，权重最大使用此接口设置的值
     * @param val
     * @return
     * @since 2.2.5
     */
    setMaxIntensity(val: number): this;
    /**
     * 最大缩放级别
     * @param val
     * @return
     * @since 2.2.5
     */
    setMaxZoom(val: number): this;
    /**
     * 最小缩放级别
     * @param val
     * @return
     * @since 2.2.5
     */
    setMinZoom(val: number): this;
    /**
     * 设置间隔 网格和蜂巢时生效
     *
     *    —— ——    —— ——
     *  丨     丨 丨     丨
     *  丨     丨 丨     丨
     *    —— ——    —— ——
     *
     *  每个方框的宽就是 size（六边形同理）
     *  两个放款之间的间隔就是 gap （六边形同理）
     *
     * @param val
     * @since 2.2.5
     */
    gap(val: number): this;
    /**
     * 设置热力图类型
     * @param val
     * @since 2.2.5
     */
    setType(val: number): this;
    /**
     * 设置Z轴的值。
     *
     * @param zIndex 要设置的Z轴的值。
     * @return 设置Z轴值的HeatMapLayerOptions对象。
     * @since 2.2.5
     */
    setZIndex(zIndex: number): this;
    /**
     * 设置可见性。默认为可见
     *
     * @param isVisible 一个表示是否可见的布尔值，true表示可见，false表示不可见。
     * @return 设置新可见属性的HeatMapLayerOptions对象
     * @since 2.2.5
     */
    visible(isVisible: boolean): this;
    /**
     * 获取颜色处理
     * @since 2.2.5
     */
    getGradient(): Gradient;
    /**
     * 获取经纬度数据
     * @since 2.2.5
     */
    getData(): ArrayList<WeightedLatLng>;
    /**
     * 获取大小
     * @since 2.2.5
     */
    getSize(): number;
    /**
     * 获取透明度
     * @since 2.2.5
     */
    getOpacity(): number;
    /**
     * 获取最大权重，0表示没有设置
     * @since 2.2.5
     */
    getMaxIntensity(): number;
    /**
     * 获取最大显示级别
     * @since 2.2.5
     */
    getMaxZoom(): number;
    /**
     * 获取最小显示级别
     * @since 2.2.5
     */
    getMinZoom(): number;
    /**
     * 获取间隔
     * @since 2.2.5
     */
    getGap(): number;
    /**
     * 获取热力图类型
     * @since 2.2.5
     */
    getType(): number;
    /**
     * 获取的Z轴值
     *
     * @return Z轴值
     * @since 2.2.5
     */
    getZIndex(): number;
    /**
     * 获取的可见属性
     *
     * @return true：为可见; false：不可见。
     * @since 2.2.5
     */
    getIsVisible(): boolean;
    private static t29;
    private u29;
}
