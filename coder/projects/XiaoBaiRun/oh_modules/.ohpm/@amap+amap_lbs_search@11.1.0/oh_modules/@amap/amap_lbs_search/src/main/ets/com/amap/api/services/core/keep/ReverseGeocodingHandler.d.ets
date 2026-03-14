// @keepTs
// @ts-nocheck
import { ReGeocodeAddress } from "../../geocoder/ReGeocodeAddress";
import { ReGeocodeQuery } from "../../geocoder/ReGeocodeQuery";
import { b7 } from "./BasicLBSRestHandler";
import { e5 } from "./RequestCacheControl";
export declare class s51 extends b7<ReGeocodeQuery, ReGeocodeAddress> {
    constructor(context: Context, task: ReGeocodeQuery);
    protected m6(): string;
    protected n6(json: string): ReGeocodeAddress | undefined;
    private g52;
    private j46;
    protected v6(): e5 | undefined;
    k6(): string;
}
