// @keepTs
// @ts-nocheck
import { WalkRouteQuery } from "../../route/WalkRouteQuery";
import { WalkRouteResult } from "../../route/WalkRouteResult";
import { b7 } from "./BasicLBSRestHandler";
export declare class x52 extends b7<WalkRouteQuery, WalkRouteResult> {
    constructor(context: Context, a53: WalkRouteQuery);
    protected m6(): string;
    protected n6(y52: string): WalkRouteResult;
    k6(): string;
}
