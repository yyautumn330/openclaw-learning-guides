// @keepTs
// @ts-nocheck
import { DistrictResult } from "../../district/DistrictResult";
import { DistrictSearchQuery } from "../../district/DistrictSearchQuery";
import { b7 } from "./BasicLBSRestHandler";
export declare class v12 extends b7<DistrictSearchQuery, DistrictResult> {
    constructor(context: Context, task: DistrictSearchQuery);
    protected m6(): string;
    protected n6(w12: string): DistrictResult | undefined;
    k6(): string;
}
