// @keepTs
// @ts-nocheck
import { DriveRouteQuery } from "../../route/DriveRouteQuery";
import { DriveRouteResult } from "../../route/DriveRouteResult";
import { b7 } from "./BasicLBSRestHandler";
export declare class n13 extends b7<DriveRouteQuery, DriveRouteResult> {
    constructor(context: Context, q13: DriveRouteQuery);
    protected m6(): string;
    protected n6(o13: string): DriveRouteResult;
    k6(): string;
}
