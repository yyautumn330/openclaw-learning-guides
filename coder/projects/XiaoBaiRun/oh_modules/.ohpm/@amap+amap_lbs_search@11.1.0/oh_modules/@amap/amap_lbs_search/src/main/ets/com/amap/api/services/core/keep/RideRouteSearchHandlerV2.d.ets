// @keepTs
// @ts-nocheck
import { RideRouteQueryV2 } from "../../route/RideRouteQueryV2";
import { RideRouteResultV2 } from "../../route/RideRouteResultV2";
import { b7 } from "./BasicLBSRestHandler";
export declare class l52 extends b7<RideRouteQueryV2, RideRouteResultV2> {
    constructor(context: Context, o52: RideRouteQueryV2);
    protected m6(): string;
    protected n6(m52: string): RideRouteResultV2 | undefined;
    k6(): string;
}
