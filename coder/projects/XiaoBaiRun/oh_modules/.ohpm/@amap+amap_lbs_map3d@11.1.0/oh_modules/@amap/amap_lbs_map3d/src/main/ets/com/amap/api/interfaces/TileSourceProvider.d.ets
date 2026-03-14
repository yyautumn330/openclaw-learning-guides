// @keepTs
// @ts-nocheck
import { Tile } from "../model/Tile";
import { TileProvider } from "../model/TileProvider";
import { i8 } from "../model/TileSourceReq";
export declare abstract class j8 extends TileProvider {
    /**
     * 获取指定坐标和缩放级别下的瓦片图层对象
     * @param req Tile请求的数据结构
     * @returns 对应Tile对象
     */
    abstract getTile(x: number, y: number, zoom: number): Promise<Tile | undefined>;
    abstract getTileReq(req: i8): Promise<Tile | undefined>;
    abstract getTileWidth(): number;
    abstract getTileHeight(): number;
    abstract cancel(req: i8): void;
}
