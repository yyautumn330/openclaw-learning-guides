// @keepTs
// @ts-nocheck
import { z193 } from "./AbstractAMapRequest";
import HashMap from "@ohos.util.HashMap";
/**
 * Tile瓦片请求
 */
export declare abstract class y16 extends z193 {
    o126(): Map<string, string>;
    /**
     * 整理请求参数,并添加ts 和 scode
     *
     * @return
     */
    protected w233(s233: HashMap<string, string>): string;
}
