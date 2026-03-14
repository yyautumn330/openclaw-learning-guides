// @keepTs
// @ts-nocheck
import { PoiResultV2 } from "../../poisearch/PoiResultV2";
import { PoiQueryV2, PoiSearchBoundV2, PoiShowFields } from "../../poisearch/PoiSearchV2";
import { e5 } from "./RequestCacheControl";
import { y43 } from "./PoiHandler";
export declare class p46 extends y43<PoiQueryV2, PoiResultV2> {
    static u47: number;
    private v47;
    private h46;
    private w47;
    constructor(context: Context, query: PoiQueryV2, t47: PoiSearchBoundV2 | undefined);
    u8(): number;
    getQuery(): PoiQueryV2 | undefined;
    getBound(): PoiSearchBoundV2 | undefined;
    k6(): string;
    n6(json: string): PoiResultV2;
    protected m6(): string;
    private j46;
    private k46;
    private l46;
    protected v6(): e5 | undefined;
    x44(q46: PoiShowFields | undefined): string;
}
