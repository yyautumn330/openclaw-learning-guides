// @keepTs
// @ts-nocheck
import { GeocodeAddress } from "../../geocoder/GeocodeAddress";
import { GeocodeQuery } from "../../geocoder/GeocodeQuery";
import { b7 } from "./BasicLBSRestHandler";
import ArrayList from "@ohos.util.ArrayList";
import { e5 } from "./RequestCacheControl";
export declare class d14 extends b7<GeocodeQuery, ArrayList<GeocodeAddress>> {
    constructor(context: Context, task: GeocodeQuery);
    protected m6(): string;
    protected n6(json: string): ArrayList<GeocodeAddress> | undefined;
    protected v6(): e5 | undefined;
    k6(): string;
}
