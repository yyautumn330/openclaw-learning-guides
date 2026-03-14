// @keepTs
// @ts-nocheck
import { BusLineItem } from "./BusLineItem";
import ArrayList from "@ohos.util.ArrayList";
import { BusLineQuery } from "./BusLineQuery";
import { SuggestionCity } from "../core/SuggestionCity";
/**
 * 公交线路搜索结果是分页显示的，从第0页开始，每页默认显示20个BusLineItem。BusLineResult封装了此分页结果，并且会缓存已经检索到的页的搜索结果。
 * @since V2.1.0
 */
export declare class BusLineResult {
    private pageCount;
    private buslines;
    private query;
    private f3;
    private g3;
    /**
     * @exclude javadoc中不显示 内部使用接口
     */
    static createPagedResult(query: BusLineQuery, itemCount: number, d3: ArrayList<SuggestionCity>, e3: ArrayList<string>, items: ArrayList<BusLineItem>): BusLineResult;
    constructor(query: BusLineQuery, itemCount: number, b3: ArrayList<SuggestionCity>, c3: ArrayList<string>, items: ArrayList<BusLineItem>);
    private itemCountToPageCount;
    /**
     * 返回该结果的总页数。
     * @return 该结果的总页数。
     * @since V2.1.0
     */
    getPageCount(): number;
    /**
     * 返回该结果对应的查询参数。
     * @return 该结果对应的查询参数。
     * @since V2.1.0
     */
    getQuery(): BusLineQuery;
    /**
     * 返回搜索建议。
     * 如果搜索关键字明显为误输入，则通过此方法得到搜索关键词建议。如果有搜索结果则此方法必定返回空。
     * @return 搜索建议。
     * @since V2.1.0
     */
    getSearchSuggestionKeywords(): ArrayList<string>;
    /**
     * 返回建议的城市。
     * 如果搜索关键字无返回结果时，引擎将建议此关键字在其他城市的搜索情况。返回的详细内容也见SuggestionCity类。如果有搜索结果则此方法必定返回空。
     * @return 搜索建议的城市。
     * @since V2.1.0
     */
    getSearchSuggestionCities(): ArrayList<SuggestionCity>;
    /**
     * 返回当前页对应的结果。
     * @return 一个BusLineItem 的列表，其中每一项代表一个BusLine。
     * @since V2.1.0
     */
    getBusLines(): ArrayList<BusLineItem>;
}
