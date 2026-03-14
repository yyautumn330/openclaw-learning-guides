// @keepTs
// @ts-nocheck
import { PoiItem } from "../core/PoiItem";
import { SuggestionCity } from "../core/SuggestionCity";
import { PoiQuery, PoiSearchBound } from "./PoiSearch";
import ArrayList from "@ohos.util.ArrayList";
/**
 * POI（Point Of Interest，兴趣点）搜索结果分页显示。PoiResult 封装了此分页结果，并且会缓存已经检索到的页的搜索结果。此类不可直接构造，只能通过调用类PoiSearch 的searchPOI()方法得到。
 * @since V1.0.0
 */
export declare class PoiResult {
    private p62;
    private q62;
    private r62;
    private w47;
    private s62;
    private t62;
    private j57;
    /**
     * 创建POIResult对象
     * @param query                 查询对象
     * @param bound                 搜索形状
     * @param suggestionKeywords    搜索建议
     * @param searchSuggestionCitys 建议的城市
     * @param pageSize              页数
     * @param itemCount             条数
     * @param items                 结果集对象列表
     * @returns                     PoiResult对象
     */
    static createPagedResult(query: PoiQuery, m62: PoiSearchBound, n62: ArrayList<string> | undefined, o62: ArrayList<SuggestionCity> | undefined, pageSize: number, itemCount: number, items: ArrayList<PoiItem>): PoiResult;
    /**
     * 构造方法
     * @param query                 查询对象
     * @param bound                 搜索形状
     * @param suggestionKeywords    搜索建议
     * @param searchSuggestionCitys 建议的城市
     * @param pageSize              页数
     * @param itemCount             条数
     * @param items                 结果集对象列表
     * @returns                     PoiResult对象
     */
    constructor(query: PoiQuery, j62: PoiSearchBound, k62: ArrayList<string> | undefined, l62: ArrayList<SuggestionCity> | undefined, pageSize: number, itemCount: number, items: ArrayList<PoiItem>);
    /**
     * 返回该结果的总页数。
     * @return 该结果的总页数。
     */
    getPageCount(): number;
    /**
     * 返回该结果对应的查询参数。
     * @return 该结果对应的查询参数
     */
    getQuery(): PoiQuery | undefined;
    /**
     * 返回该结果对应的范围参数。
     * @return 该结果对应的范围参数。
     */
    getBound(): PoiSearchBound | undefined;
    /**
     * 返回当前页所有POI结果。
     * <p>如果当前页无POI结果，返回长度为零的list。</p>
     * @return 该页所有POI结果。
     */
    getPois(): ArrayList<PoiItem>;
    /**
     * 返回搜索建议。
     * 如果搜索关键字明显为误输入，则通过此方法得到搜索关键词建议。如搜索“早君庙”，搜索引擎给出建议为“皂君庙”。建议按照与查询关键词发音近似的原则给出。如果有搜索结果则此方法必定返回空。
     * @return 搜索建议。
     */
    getSearchSuggestionKeywords(): ArrayList<String> | undefined;
    /**
     * 返回建议的城市。
     * 如果搜索关键字无返回结果时，引擎将建议此关键字在其他城市的搜索情况。返回的详细内容也见SuggestionCity类。如果有搜索结果则此方法必定返回空。
     * @return 搜索建议的城市。
     */
    getSearchSuggestionCitys(): ArrayList<SuggestionCity> | undefined;
    private itemCountToPageCount;
}
