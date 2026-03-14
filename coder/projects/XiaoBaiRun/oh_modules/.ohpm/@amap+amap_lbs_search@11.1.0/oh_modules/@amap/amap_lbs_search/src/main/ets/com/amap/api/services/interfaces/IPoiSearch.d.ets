// @keepTs
// @ts-nocheck
import { PoiItem } from "../core/PoiItem";
import { PoiResult } from "../poisearch/PoiResult";
import { OnPoiSearchListener, PoiQuery, PoiSearchBound } from "../poisearch/PoiSearch";
/**
 * 本类为POI（Point Of Interest，兴趣点）搜索的“入口”类，定义此类，开始搜索。在类PoiSearch 中，还定义了两个内部类，Query 与SearchBound，请用这两个内部类设定搜索参数。
 * @since 1.0.0
 */
export interface o60 {
    /**
     * 设置查询监听接口。
     * @param listener 查询监听接口。
     */
    setOnPoiSearchListener(listener: OnPoiSearchListener): void;
    /**
     * 设置POI搜索返回结果语言。
     * @param language 支持ENGLISH和CHINESE。
     * @deprecated
     */
    setLanguage(language: string): void;
    /**
     * @deprecated
     */
    getLanguage(): string;
    /**
     * 查询POI。
     * <p>如果此时矩形查询（SearchBound）已定义，则搜索范围为该矩形内的符合条件的POI，否则如果此时查询条件（Query）中的行政区划代码已定义，则搜索该城市（地区）内的所有符合条件的POI,如上述两个条件均未定义，则搜索范围为全国。为了性能及结果的清晰，强烈建议定义一个范围：矩形或行政区划代码均可。整个查询的语义为查找符合查询关键字，符合查询类型编码组合及在指定范围内的所有POI。</p>
     *<p>此接口在网络连接出现问题的情况下，会抛出AMapException。</p>
     * @return 查询POI 的结果，结果是分页的，每页最多30 个。通过类PoiPagedResult 的实例可以检索每一页。
     * @throws AMapException。
     */
    searchPOI(): Promise<PoiResult | undefined>;
    /**
     * 查询POI异步接口。
     * 如果此时矩形查询（SearchBound）已定义，则搜索范围为该矩形内的符合条件的POI，否则如果此时查询条件（Query）中的行政区划代码已定义，则搜索该城市（地区）内的所有符合条件的POI,如上述两个条件均未定义，则搜索范围为全国。建议定义一个范围：矩形或行政区划代码均可。整个查询的语义为查找符合查询关键字，符合查询类型编码组合及在指定范围内的指定POI。查询POI 的结果，结果是分页的，每页最多30 个。
     * 此方法为异步处理。
     */
    searchPOIAsyn(): void;
    /**
     * 已知poiid信息（点击地图底图），搜索POI的详细信息，同步
     * @param poiID poi的ID
     * @return poi的信息，如POI名称、类型、城市编码等。
     */
    searchPOIId(poiID: string): Promise<PoiItem | undefined>;
    /**
     * 已知poiid信息（点击地图底图），搜索POI的详细信息，异步
     * @param poiID poi的ID
     */
    searchPOIIdAsyn(poiID: string): void;
    /**
     * 设置查询条件。
     * @param query 新的查询条件。
     */
    setQuery(query: PoiQuery): void;
    /**
     * 设置查询矩形。
     * @param bnd 新的查询矩形。
     */
    setBound(bnd: PoiSearchBound): void;
    /**
     * 返回查询条件。
     * @return 查询条件。
     */
    getQuery(): PoiQuery | undefined;
    /**
     * 返回查询矩形。
     * @return 查询矩形。
     */
    getBound(): PoiSearchBound | undefined;
}
