// @keepTs
// @ts-nocheck
import { TruckRouteQuery } from "../../route/TruckRouteQuery";
import { TruckRouteRestult } from "../../route/TruckRouteRestult";
import { b7 } from "./BasicLBSRestHandler";
export declare class u52 extends b7<TruckRouteQuery, TruckRouteRestult> {
    private readonly r12;
    private readonly s12;
    private readonly t12;
    constructor(context: Context, task: TruckRouteQuery);
    protected m6(): string;
    protected n6(v52: string): TruckRouteRestult | undefined;
    k6(): string;
}
