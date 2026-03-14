// @keepTs
// @ts-nocheck
import { PoiQuery, PoiResult, PoiSearchBound } from "../../../../../../../../../Index";
import { y43 } from "./PoiHandler";
import { e5 } from "./RequestCacheControl";
export declare class a45 extends y43<PoiQuery, PoiResult> {
    private h46;
    private i46;
    constructor(context: Context, task: PoiQuery, g46: PoiSearchBound | undefined);
    getQuery(): PoiQuery | undefined;
    k6(): string;
    protected n6(json: string): PoiResult | undefined;
    protected m6(): string;
    private j46;
    private k46;
    private l46;
    protected v6(): e5 | undefined;
}
