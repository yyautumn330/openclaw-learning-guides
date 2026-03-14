// @keepTs
// @ts-nocheck
import { e16 } from "../api/model/TileProviderInner";
import { d16 } from "../mapcore/interface/IGLOverlayLayer";
import { BitmapDescriptor } from "../api/model/BitmapDescriptor";
/**
 * 地形图provider
 * 包含地形图的数据源
 */
export declare class r66 {
    private static v227;
    private static w227;
    private q16;
    private mContext;
    constructor(r227: d16, context: Context);
    getTileProvider(): e16;
    getSkyBoxImages(): BitmapDescriptor[];
    c68(): BitmapDescriptor;
}
