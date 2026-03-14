// @keepTs
// @ts-nocheck
import { b7 } from "./BasicLBSRestHandler";
import { BusRouteQueryV2 } from "../../route/BusRouteQueryV2";
import { BusRouteResultV2 } from "../../route/BusRouteResultV2";
export declare class b8 extends b7<BusRouteQueryV2, BusRouteResultV2> {
    constructor(context: Context, g8: BusRouteQueryV2);
    protected m6(): string;
    protected n6(json: string): BusRouteResultV2 | undefined;
    k6(): string;
}
