// @keepTs
// @ts-nocheck
import { DrivePlanQuery } from "../../route/DrivePlanQuery";
import { DriveRoutePlanResult } from "../../route/DriveRoutePlanResult";
import { b7 } from "./BasicLBSRestHandler";
export declare class h13 extends b7<DrivePlanQuery, DriveRoutePlanResult> {
    constructor(context: Context, k13: DrivePlanQuery);
    protected m6(): string;
    protected n6(i13: string): DriveRoutePlanResult;
    k6(): string;
}
