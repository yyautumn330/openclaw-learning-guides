// @keepTs
// @ts-nocheck
import { DriveRouteQueryV2 } from "../../route/DriveRouteQueryV2";
import { DriveRouteResultV2 } from "../../route/DriveRouteResultV2";
import { b7 } from "./BasicLBSRestHandler";
export declare class v13 extends b7<DriveRouteQueryV2, DriveRouteResultV2> {
    constructor(context: Context, a14: DriveRouteQueryV2);
    protected m6(): string;
    protected n6(w13: string): DriveRouteResultV2;
    k6(): string;
}
