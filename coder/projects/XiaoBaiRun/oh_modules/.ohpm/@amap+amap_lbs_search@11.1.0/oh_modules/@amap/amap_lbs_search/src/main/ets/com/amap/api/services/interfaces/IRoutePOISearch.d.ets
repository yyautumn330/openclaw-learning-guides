// @keepTs
// @ts-nocheck
/**
 * Created by my94493 on 2016/9/7.
 */
import { OnRoutePOISearchListener } from "../routepoisearch/RoutePOISearch";
import { RoutePOISearchQuery } from "../routepoisearch/RoutePOISearchQuery";
import { RoutePOISearchResult } from "../routepoisearch/RoutePOISearchResult";
export interface q60 {
    r60(listener: OnRoutePOISearchListener): void;
    searchRoutePOIAsyn(): void;
    searchRoutePOI(): Promise<RoutePOISearchResult | undefined>;
    setQuery(query: RoutePOISearchQuery): void;
    getQuery(): RoutePOISearchQuery | undefined;
}
