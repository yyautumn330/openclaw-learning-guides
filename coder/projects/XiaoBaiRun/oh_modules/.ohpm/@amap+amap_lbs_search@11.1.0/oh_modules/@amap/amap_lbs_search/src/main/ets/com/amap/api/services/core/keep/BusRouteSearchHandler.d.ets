// @keepTs
// @ts-nocheck
import { BusRouteQuery } from "../../route/BusRouteQuery";
import { BusRouteResult } from "../../route/BusRouteResult";
import { b7 } from "./BasicLBSRestHandler";
export declare class s7 extends b7<BusRouteQuery, BusRouteResult> {
    constructor(context: Context, w7: BusRouteQuery);
    protected m6(): string;
    protected n6(t7: string): BusRouteResult;
    k6(): string;
}
