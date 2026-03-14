// @keepTs
// @ts-nocheck
import { RideRouteQuery } from "../../route/RideRouteQuery";
import { RideRouteResult } from "../../route/RideRouteResult";
import { b7 } from "./BasicLBSRestHandler";
export declare class h52 extends b7<RideRouteQuery, RideRouteResult> {
    constructor(context: Context, k52: RideRouteQuery);
    protected m6(): string;
    protected n6(i52: string): RideRouteResult | undefined;
    k6(): string;
}
