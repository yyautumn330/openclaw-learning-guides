// @keepTs
// @ts-nocheck
import { z193 } from "../../tool/AbstractAMapRequest";
import HashMap from "@ohos.util.HashMap";
/**
 * @author zxy
 */
export declare class x193 extends z193 {
    private i200?;
    constructor(h200: string, context: Context);
    o126(): Map<string, string>;
    getParams(): HashMap<string, string> | undefined;
    p126(): string | undefined;
    q126(): string | undefined;
    r126(): boolean;
    protected getUri(): string;
}
