// @keepTs
// @ts-nocheck
import { Tile } from "../../api/model/Tile";
import { TileProvider } from "../../api/model/TileProvider";
import { b53 } from "../MapConfig";
export declare class n210 extends TileProvider {
    private width?;
    private height?;
    private o233?;
    private p233?;
    static readonly l96 = 6;
    static readonly o231 = "zh_cn";
    static readonly q233 = "en_US";
    constructor(width: number, height: number, m233: b53, n233: boolean);
    getTile(x: number, y: number, zoom: number): Promise<Tile>;
    getTileWidth(): number;
    getTileHeight(): number;
    private d123;
}
