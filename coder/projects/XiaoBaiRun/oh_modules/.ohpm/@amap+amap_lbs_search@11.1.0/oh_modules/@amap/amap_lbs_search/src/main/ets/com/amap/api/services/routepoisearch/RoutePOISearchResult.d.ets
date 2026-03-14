// @keepTs
// @ts-nocheck
/**
 *  此类定义了沿途搜索POI的结果集。
 *  @since V1.0.0
 */
import { RoutePOIItem } from "./RoutePOIItem";
import ArrayList from "@ohos.util.ArrayList";
import { RoutePOISearchQuery } from "./RoutePOISearchQuery";
export declare class RoutePOISearchResult {
    private k89;
    private r62;
    /**
     * 依据参数构造沿途搜索查询结果
     * @param routePOIItems RoutePOI列表。
     * @param query 查询参数。
     * @since V1.0.0
     */
    constructor(j89: ArrayList<RoutePOIItem>, query: RoutePOISearchQuery);
    /**
     * 获取RoutePOI列表。
     * @return RoutePOI列表。
     * @since V1.0.0
     */
    getRoutePois(): ArrayList<RoutePOIItem>;
    /**
     * 返回查询条件。
     * @return 查询条件。
     * @since V1.0.0
     */
    getQuery(): RoutePOISearchQuery;
}
