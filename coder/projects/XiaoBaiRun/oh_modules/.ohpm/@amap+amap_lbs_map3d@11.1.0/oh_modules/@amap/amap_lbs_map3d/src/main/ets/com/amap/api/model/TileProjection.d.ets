// @keepTs
// @ts-nocheck
/**
 * 瓦片编号范围。工具类Projection中调用fromBitmapToTile()方法返回TileProjection对象。
 *
 * @since V2.0.0
 */
export declare class TileProjection {
    /**
     * 将西北角经纬度映射到左上角瓦片上，对应的像素点距离瓦片起点（0,0）x方向上的偏移像素数。
     * @since V2.0.0
     */
    readonly offsetX: number;
    /**
     * 将西北角经纬度映射到左上角瓦片上，对应的像素点距离瓦片起点（0,0）y方向上的偏移像素数。。
     * @since V2.0.0
     */
    readonly offsetY: number;
    /**
     * 瓦片编号范围最小X。
     * @since V2.0.0
     */
    readonly minX: number;
    /**
     * 瓦片编号范围最大X。
     * @since V2.0.0
     */
    readonly maxX: number;
    /**
     * 瓦片编号范围最小Y。
     * @since V2.0.0
     */
    readonly minY: number;
    /**
     * 瓦片编号范围最大Y。
     * @since V2.0.0
     */
    readonly maxY: number;
    /**
     * 根据给定的参数构造一个 TileProjection 新对象。
     *
     * @param offsetX 西北角经纬度对应的像素点距离瓦片起点（0,0）x方向上的偏移像素数。
     * @param offsetY 西北角经纬度对应的像素点距离瓦片起点（0,0）y方向上的偏移像素数。
     * @param minX    瓦片编号范围最小X，如例中的215811。
     * @param maxX    瓦片编号范围最大X，如例中的215812。
     * @param minY    瓦片编号范围最小Y，如例中的99326。
     * @param maxY    瓦片编号范围最大Y，如例中的99327。
     * @since V2.0.0
     */
    constructor(offsetX: number, offsetY: number, h46: number, i46: number, j46: number, k46: number);
}
