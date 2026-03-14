// @keepTs
// @ts-nocheck
import { q60 } from "../interfaces/IRoutePOISearch";
import { OnRoutePOISearchListener } from "../routepoisearch/RoutePOISearch";
import { RoutePOISearchQuery } from "../routepoisearch/RoutePOISearchQuery";
import { RoutePOISearchResult } from "../routepoisearch/RoutePOISearchResult";
export declare class b89 implements q60 {
    private static v44;
    private r62;
    private mContext;
    private listener;
    private r90;
    constructor(context: Context, query: RoutePOISearchQuery);
    r60(listener: OnRoutePOISearchListener): void;
    searchRoutePOIAsyn(): void;
    setQuery(query: RoutePOISearchQuery): void;
    getQuery(): RoutePOISearchQuery | undefined;
    searchRoutePOI(): Promise<RoutePOISearchResult | undefined>;
    private h4;
}
