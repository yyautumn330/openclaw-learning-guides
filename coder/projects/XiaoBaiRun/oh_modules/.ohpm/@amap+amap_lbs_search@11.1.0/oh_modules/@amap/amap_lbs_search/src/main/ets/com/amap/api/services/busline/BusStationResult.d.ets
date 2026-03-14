// @keepTs
// @ts-nocheck
import { BusStationQuery } from "./BusStationQuery";
import ArrayList from "@ohos.util.ArrayList";
import { BusStationItem } from "./BusStationItem";
import { SuggestionCity } from "../core/SuggestionCity";
/**
 * 公交站点搜索结果是分页显示的，从第0页开始，每页默认显示20个BusStationItem。BusStationResult封装了此分页结果，并且会缓存已经检索到的页的搜索结果。
 * @since V2.1.0
 */
export declare class BusStationResult {
    private pageCount;
    private a2;
    private query;
    private f3;
    private g3;
    /**
     * @exclude javadoc中不显示 内部使用接口
     * @param query
     * @param itemCount
     * @param searchSuggestionCities
     * @param suggestionKeywords
     * @param items
     * @return
     */
    static createPagedResult(query: BusStationQuery, itemCount: number, l4: ArrayList<SuggestionCity>, m4: ArrayList<string>, items: ArrayList<BusStationItem>): BusStationResult;
    constructor(query: BusStationQuery, itemCount: number, j4: ArrayList<SuggestionCity>, k4: ArrayList<string>, items: ArrayList<BusStationItem>);
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
    getQuery(): BusStationQuery;
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
     * 返回公交站列表。
     * @return 一个BusStationItem 的列表，其中每一项代表一个BusStation。
     * @since V2.1.0
     */
    getBusStations(): ArrayList<BusStationItem>;
}
