// @keepTs
// @ts-nocheck
/**
 * 3DTile覆盖物
 * @since v9.6.0
 * @exclude javadoc中不显示 后续开放
 */
import { BaseOverlay } from "../../../../../../../../Index";
import { d16 } from "../../../mapcore/interface/IGLOverlayLayer";
import { f16 } from "./AMap3DModelTileOverlayOptions";
export declare class g16 extends BaseOverlay {
    private glOverlayLayerRef?;
    private l16?;
    constructor(i16: d16, options: f16, j16: string);
    /**
     * 从地图上删除瓦片图层
     *
     * @since v9.6.0
     */
    remove(): void;
}
