// @keepTs
// @ts-nocheck
/**
 * 接口类，为类TileOverlay提供瓦片图像。
 * 调用这个接口的方法可能会存在多线程，所以实现时注意线程安全。
 *
 * @author zhm
 * @since v2.2.0
 */
import { Tile } from './Tile';
export declare abstract class TileProvider {
    /**
     * 指定tile坐标后不存在瓦片的特殊tile。
     *
     * @since V2.2.0
     */
    static readonly NO_TILE: Tile;
    /**
     * 获取指定坐标和缩放级别下的瓦片图层对象。
     *
     * @param x    tile的横坐标，范围为[0, 2的zoom次方 - 1]。
     * @param y    tile的纵坐标，范围为[0, 2的zoom次方 - 1]。
     * @param zoom 瓦片的缩放级别，范围通过类AMap的getMinZoomLevel()和getMaxZoomLevel()获得。
     * @return 指定坐标和缩放级别下的Tile对象。
     *
     * @since V2.2.0
     */
    abstract getTile(x: number, y: number, zoom: number): Promise<Tile | undefined>;
    /**
     * 获取瓦片图层的图片像素宽度，单位像素pixel。
     *
     * @return 图片像素宽度。
     * @since V2.2.0
     */
    abstract getTileWidth(): number;
    /**
     * 获取指定瓦片图层的图片像素高度，单位像素pixel。
     *
     * @return 图片像素高度。
     * @since V2.2.0
     */
    abstract getTileHeight(): number;
}
