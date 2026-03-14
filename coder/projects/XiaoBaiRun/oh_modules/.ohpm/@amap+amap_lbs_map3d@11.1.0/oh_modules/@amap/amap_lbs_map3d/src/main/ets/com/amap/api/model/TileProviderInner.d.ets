// @keepTs
// @ts-nocheck
import { d16 } from "../../mapcore/interface/IGLOverlayLayer";
import { TileOverlaySource } from "./TileOverlaySource";
import { TileProvider } from "./TileProvider";
import { i18 } from "../TileReqTaskHandle";
import { i8 } from "./TileSourceReq";
/**
 * @internal
 */
export declare class e16 {
    private tileProvider?;
    private glOverlayLayerRef?;
    private overlayName?;
    private mTileSource;
    private u46;
    constructor(tileProvider: TileProvider);
    init(s46: d16, t46: string): void;
    v46(sources: TileOverlaySource[]): void;
    private w46;
    getTile(req: i8, q46: i18): void;
    private x46;
    cancelTile(req: i8, m46: i18): void;
    getTileWidth(): number;
    getTileHeight(): number;
    private y46;
}
