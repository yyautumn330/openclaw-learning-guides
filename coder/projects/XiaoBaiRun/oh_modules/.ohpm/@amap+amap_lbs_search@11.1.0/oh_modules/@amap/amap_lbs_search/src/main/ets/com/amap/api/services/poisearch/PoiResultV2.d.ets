// @keepTs
// @ts-nocheck
import { PoiItemV2 } from "../core/PoiItemV2";
import ArrayList from "@ohos.util.ArrayList";
import { PoiQueryV2, PoiSearchBoundV2 } from "./PoiSearchV2";
/**
 * POI（Point Of Interest，兴趣点）搜索结果分页显示。PoiResultV2 封装了此分页结果，并且会缓存已经检索到的页的搜索结果。此类不可直接构造，只能通过调用类PoiSearch 的searchPOI()方法得到。
 * @since V1.0.0
 */
export declare class PoiResultV2 {
    private w62;
    private q62;
    private r62;
    private w47;
    /**
     * 创建PoiResultV2对象
     * @param query     查询对象
     * @param bound     搜索形状
     * @param itemCount 条数
     * @param items     结果集对象列表
     * @returns         PoiResult对象
     */
    static createPagedResult(query: PoiQueryV2 | undefined, v62: PoiSearchBoundV2 | undefined, itemCount: number, items: ArrayList<PoiItemV2>): PoiResultV2;
    /**
     * 创建PoiResultV2对象
     * @param query     查询对象
     * @param bound     搜索形状
     * @param itemCount 条数
     * @param items     结果集对象列表
     * @returns         PoiResult对象
     */
    constructor(query: PoiQueryV2 | undefined, u62: PoiSearchBoundV2 | undefined, itemCount: number, items: ArrayList<PoiItemV2>);
    /**
     * 返回当前结果集的总数。
     * @return 该结果集的总数。
     * @since V1.0.0
     */
    getCount(): number;
    /**
     * 返回该结果对应的查询参数。
     * @return 该结果对应的查询参数
     * @since V1.0.0
     */
    getQuery(): PoiQueryV2 | undefined;
    /**
     * 返回该结果对应的范围参数。
     * @return 该结果对应的范围参数。
     * @since V2.0.0
     */
    getBound(): PoiSearchBoundV2 | undefined;
    /**
     * 返回当前页所有POI结果。
     * <p>如果当前页无POI结果，返回长度为零的list。</p>
     * @return 该页所有POI结果。
     * @since V2.1.0
     */
    getPois(): ArrayList<PoiItemV2>;
}
