// @keepTs
// @ts-nocheck
import { Tile } from "./model/Tile";
/**
 * @internal
 */
export declare class i18 {
    nativeObj: number;
    tile?: Tile;
    status: number;
    /**
     * 构造函数
     */
    constructor();
    /**
     * 任务完成时，赋值新的 tile
     */
    finish(m49: Tile): void;
}
