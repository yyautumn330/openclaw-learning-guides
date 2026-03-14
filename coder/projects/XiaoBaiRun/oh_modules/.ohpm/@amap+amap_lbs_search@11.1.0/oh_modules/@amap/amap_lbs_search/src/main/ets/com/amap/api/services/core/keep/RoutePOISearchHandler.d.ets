// @keepTs
// @ts-nocheck
import { RoutePOISearchQuery } from "../../routepoisearch/RoutePOISearchQuery";
import { RoutePOISearchResult } from "../../routepoisearch/RoutePOISearchResult";
import { b7 } from "./BasicLBSRestHandler";
export declare class p52 extends b7<RoutePOISearchQuery, RoutePOISearchResult> {
    constructor(context: Context, task: RoutePOISearchQuery);
    protected m6(): string;
    protected n6(q52: string): RoutePOISearchResult | undefined;
    k6(): string;
}
