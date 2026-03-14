// @keepTs
// @ts-nocheck
import { PoiQueryV2, PoiShowFields } from "../../../../../../../../../Index";
import { PoiItemV2 } from "../PoiItemV2";
import { y43 } from "./PoiHandler";
import { e5 } from "./RequestCacheControl";
export declare class h44 extends y43<string, PoiItemV2> {
    private static v44;
    private query;
    constructor(context: Context, u44: string, query: PoiQueryV2 | undefined);
    k6(): string;
    n6(json: string): PoiItemV2 | undefined;
    private g44;
    protected m6(): string;
    private w44;
    protected v6(): e5 | undefined;
    x44(i44: PoiShowFields | undefined): string;
}
