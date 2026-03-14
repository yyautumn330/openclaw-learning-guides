// @keepTs
// @ts-nocheck
import { j8 } from "../api/interfaces/TileSourceProvider";
import { Tile } from "../api/model/Tile";
import { TileOverlaySource } from "../api/model/TileOverlaySource";
import { i8 } from "../api/model/TileSourceReq";
/**
 * 地形图专用的tileProvider
 * @author zxy
 */
export declare class o227 extends j8 {
    getTile(x: number, y: number, zoom: number): Promise<Tile | undefined>;
    private size;
    private i229;
    private j229;
    private k229;
    constructor(g229: TileOverlaySource, h229: TileOverlaySource);
    private w46;
    getTileReq(req: i8): Promise<Tile | undefined>;
    private n229;
    l229(req: i8): Tile;
    cancel(req: i8): void;
    getTileWidth(): number;
    getTileHeight(): number;
    /**
     * 使用核心库发起网络请求
     * @return
     */
    private d123;
    private m229;
}
