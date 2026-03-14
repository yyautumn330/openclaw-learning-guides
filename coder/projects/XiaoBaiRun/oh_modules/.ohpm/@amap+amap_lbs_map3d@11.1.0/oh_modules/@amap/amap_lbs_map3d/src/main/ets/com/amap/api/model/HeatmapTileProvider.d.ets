// @keepTs
// @ts-nocheck
import { Gradient } from "./Gradient";
import { LatLng } from "./LatLng";
import { Tile } from "./Tile";
import { TileProvider } from "./TileProvider";
import { WeightedLatLng } from "./WeightedLatLng";
import { p23 } from "./Bounds";
import image from "@ohos.multimedia.image";
export declare class HeatmapTileProvider extends TileProvider {
    /**
     * 热力图默认的点半径
     *
     * @since 2.2.3
     */
    static readonly DEFAULT_RADIUS: number;
    /**
     * 热力图层默认透明度
     *
     * @since 2.2.3
     */
    static readonly DEFAULT_OPACITY: number;
    /**
     * 热力图默认渐变
     *
     * @since 2.2.3
     * @internal
     */
    private static readonly r29;
    static rgb(red: number, green: number, blue: number): number;
    /**
     * @internal
     */
    private static readonly s29;
    /**
     * 热力图默认渐变
     *
     * @since 2.2.3
     */
    static readonly DEFAULT_GRADIENT: Gradient;
    private static readonly u33;
    private static readonly v33;
    private static readonly w33;
    private static readonly x33;
    private static readonly y33;
    /**
     * @internal
     * @since 2.2.3
     */
    static z33: number;
    /**
     * @internal
     * @since 2.2.3
     */
    static a34: number;
    private mTree?;
    private mData?;
    private mBounds?;
    private mRadius?;
    private mGradient?;
    private mColorMap;
    private mKernel?;
    private mOpacity?;
    private mMaxIntensity;
    constructor(builder: HeatMapBuilder);
    getTile(x: number, y: number, zoom: number): Promise<Tile | undefined>;
    /**
     * @internal
     * @since 2.2.3
     */
    e34(pixelMap: image.PixelMap): Promise<Tile | undefined>;
    /**
     * @internal
     * @since 2.2.3
     */
    f34(i32: number[][], j32: number[]): number[][];
    /**
     * @internal
     * @since 2.2.3
     */
    g34(x31: number[][], y31: number[], z31: number): image.PixelMap;
    getTileWidth(): number;
    getTileHeight(): number;
    /**
     * @internal
     * @since 2.2.3
     */
    private setGradient;
    /**
     * @internal
     * @since 2.2.3
     */
    private c34;
    /**
     * @internal
     * @since 2.2.3
     */
    private h34;
    /**
     * @internal
     * @since 2.2.3
     */
    static i34(points: WeightedLatLng[], bounds: p23, radius: number, i31: number): number;
    /**
     * @internal
     * @since 2.2.3
     */
    static getBounds(points: WeightedLatLng[]): p23;
    /**
     * @internal
     * @since 2.2.3
     */
    static b34(radius: number, a31: number): number[];
}
/**
 * 热力图构造器.
 *
 * @since 2.2.3
 */
export declare class HeatMapBuilder {
    /**
     * @internal
     */
    data?: WeightedLatLng[];
    /**
     * @internal
     */
    radius: number;
    /**
     * @internal
     */
    gradient: Gradient;
    /**
     * @internal
     */
    opacity: number;
    /**
     * @since 2.2.3
     */
    constructor();
    /**
     * 设置热力图绘制的数据，data 或 weightedData接口必须设置其中之一
     *
     * @param val 热力图绘制数据，不能为null，大小不能为 0.
     * @return 更新后的热力图瓦片提供者构造器引用
     * @since 2.2.3
     */
    setData(val: LatLng[]): HeatMapBuilder;
    /**
     * @internal
     * @param data
     * @returns
     */
    private static t29;
    /**
     * 设置热力图绘制的数据，带权值的位置点集合，data 或 weightedData接口必须设置其中之一
     *
     * @param val 热力图绘制数据，不能为null，大小不能为 0.
     * @return 更新后的热力图瓦片提供者构造器引用
     * @since 2.2.3
     */
    weightedData(val: WeightedLatLng[]): HeatMapBuilder;
    /**
     * 设置热力图点半径，默认为12ps，可不设置该接口
     *
     * @param val 热力图点半径,[10,50].
     * @return 更新后的热力图瓦片提供者构造器引用
     * @since 2.2.3
     */
    setRadius(val: number): HeatMapBuilder;
    /**
     * 设置热力图渐变，有默认值 DEFAULT_GRADIENT，可不设置该接口
     *
     * @param val 热力图渐变
     * @return 更新后的热力图瓦片提供者构造器引用
     * @since 2.2.3
     */
    setGradient(val: Gradient): HeatMapBuilder;
    /**
     * 设置热力图层透明度，默认 0.6，可不设置该接口
     *
     * @param val 热力图层透明度 [0, 1]
     * @return 更新后的热力图瓦片提供者构造器引用
     * @since 2.2.3
     */
    transparency(val: number): HeatMapBuilder;
    /**
     * 构造热力图，调用该函数之前必须先通过 data 或者 weightedData 函数设置该热力图所要渲染的数据。
     *
     * @return 构造好的热力图瓦片提供者.
     * @since 2.2.3
     */
    build(): HeatmapTileProvider | undefined;
}
