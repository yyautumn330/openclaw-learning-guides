// @keepTs
// @ts-nocheck
import { p60 } from "../interfaces/IPoiSearchV2";
import { OnPoiSearchListenerV2, PoiQueryV2, PoiSearchBoundV2 } from "../poisearch/PoiSearchV2";
import { PoiResultV2 } from "../poisearch/PoiResultV2";
import { PoiItemV2 } from "../core/PoiItemV2";
/**
 * 本类为POI（Point Of Interest，兴趣点）搜索的“入口”类，定义此类，开始搜索。在类PoiSearchV2 中，还定义了两个类，PoiQueryV2 与PoiSearchBoundV2，请用这两个内部类设定搜索参数。
 * @since 1.0.0
 */
export declare class n64 implements p60 {
    private static x59;
    private w47;
    private r62;
    private mContext;
    private listener;
    /**
     * 语言设置常量。
     * @since 1.0.0
     */
    static ENGLISH: string;
    /**
     * 语言设置常量。
     * @since 1.0.0
     */
    static CHINESE: string;
    private l92;
    private preQuery;
    private m92;
    private p62;
    private static n92;
    private r90;
    /**
     * 根据给定的参数构造一个PoiSearch 的新对象。
     * @param act 对应的Context。
     * @param query 查询条件。
     */
    constructor(g93: Context, query: PoiQueryV2 | undefined);
    /**
     * 设置查询监听接口。
     * @param listener 查询监听接口。
     * @since 1.0.0
     */
    setOnPoiSearchListener(listener: OnPoiSearchListenerV2): void;
    /**
     * 设置POI搜索返回结果语言。
     * @param language 支持ENGLISH和CHINESE。
     * @deprecated
     * @since 1.0.0
     */
    setLanguage(language: string): void;
    /**
     * @deprecated
     */
    getLanguage(): string;
    private h4;
    /**
     * 判断bounds是不是圆形
     * @return
     */
    private o92;
    /**
     *
     * @return
     */
    private p92;
    /**
     * 查询POI。
     * <p>如果此时矩形查询（SearchBound）已定义，则搜索范围为该矩形内的符合条件的POI，否则如果此时查询条件（Query）中的行政区划代码已定义，则搜索该城市（地区）内的所有符合条件的POI,如上述两个条件均未定义，则搜索范围为全国。为了性能及结果的清晰，强烈建议定义一个范围：矩形或行政区划代码均可。整个查询的语义为查找符合查询关键字，符合查询类型编码组合及在指定范围内的所有POI。</p>
     *<p>此接口在网络连接出现问题的情况下，会抛出AMapException。</p>
     * @return 查询POI 的结果，结果是分页的，每页最多30 个。通过类PoiPagedResult 的实例可以检索每一页。
     * @throws AMapException。
     */
    searchPOI(): Promise<PoiResultV2 | undefined>;
    /**
     * 查询POI异步接口。
     * 如果此时矩形查询（PoiSearchBoundV2）已定义，则搜索范围为该矩形内的符合条件的POI，否则如果此时查询条件（Query）中的行政区划代码已定义，则搜索该城市（地区）内的所有符合条件的POI,如上述两个条件均未定义，则搜索范围为全国。建议定义一个范围：矩形或行政区划代码均可。整个查询的语义为查找符合查询关键字，符合查询类型编码组合及在指定范围内的指定POI。查询POI 的结果，结果是分页的，每页最多30 个。
     * 此方法为异步处理。
     * @since 1.0.0
     */
    searchPOIAsyn(): void;
    /**
     * 已知poiid信息（点击地图底图），搜索POI的详细信息，同步
     * @param poiID poi的ID
     * @return poi的信息，如POI名称、类型、城市编码等。
     * @throws AMapException
     */
    searchPOIId(w92: string): Promise<PoiItemV2 | undefined>;
    /**
     * 已知poiid信息（点击地图底图），搜索POI的详细信息，异步
     * @param poiID poi的ID
     */
    searchPOIIdAsyn(u92: string): void;
    /**
     * 设置查询条件。
     * @param query 新的查询条件。
     */
    setQuery(query: PoiQueryV2 | undefined): void;
    /**
     * 设置查询矩形。
     * @param bnd 新的查询矩形。
     */
    setBound(t92: PoiSearchBoundV2 | undefined): void;
    /**
     * 返回查询条件。
     * @return 查询条件。
     */
    getQuery(): PoiQueryV2 | undefined;
    /**
     * 返回查询矩形。
     * @return 查询矩形。
     */
    getBound(): PoiSearchBoundV2 | undefined;
    private z89;
    protected a90(r92: number): PoiResultV2;
    private b90;
}
