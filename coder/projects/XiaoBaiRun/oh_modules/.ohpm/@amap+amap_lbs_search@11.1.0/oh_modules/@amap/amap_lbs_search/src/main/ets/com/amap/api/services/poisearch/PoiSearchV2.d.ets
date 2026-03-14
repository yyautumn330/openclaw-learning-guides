// @keepTs
// @ts-nocheck
import { LatLonPoint } from "../core/LatLonPoint";
import { PoiItemV2 } from "../core/PoiItemV2";
import { PoiResultV2 } from "./PoiResultV2";
import ArrayList from "@ohos.util.ArrayList";
import HashMap from "@ohos.util.HashMap";
import { Context as Context } from "@ohos.abilityAccessCtrl";
/**
 *  A/B库类型
 *  @exclude javadoc中不显示。
 */
export declare enum PremiumType {
    /**
     * 默认类型，搜索B库
     * @since 9.5.0
     * @exclude javadoc中不显示。
     */
    DEFAULT = "",
    /**
     * 搜索A库，需要对应的key权限
     * @since 9.5.0
     * @exclude javadoc中不显示。
     */
    ENTIRETY = "entirety_poi"
}
export declare function m64(type: string): PremiumType;
/**
 * 本类为POI（Point Of Interest，兴趣点）搜索的“入口”类，定义此类，开始搜索。在类PoiSearch 中，还定义了两个内部类，Query 与SearchBound，请用这两个内部类设定搜索参数。
 *
 * @since V1.0.0
 */
export declare class PoiSearchV2 {
    private static x59;
    /**
     * 语言设置常量。
     *
     * @since V1.0.0
     */
    static ENGLISH: string;
    /**
     * 语言设置常量。
     *
     * @since V1.0.0
     */
    static CHINESE: string;
    private search;
    /**
     * 根据给定的参数构造一个PoiSearch 的新对象。
     *
     * @param context
     *            对应的Context。
     * @param query
     *            查询条件。
     * @since V1.0.0
     */
    constructor(context: Context, query: PoiQueryV2 | undefined);
    /**
     * 设置查询监听接口。
     *
     * @param listener
     *            查询监听接口。
     * @since V1.0.0
     */
    setOnPoiSearchListener(listener: OnPoiSearchListenerV2): void;
    /**
     * 查询POI。
     * <p>
     * 如果此时矩形查询（SearchBound）已定义，则搜索范围为该矩形内的符合条件的POI，否则如果此时查询条件（Query）中的行政区划代码已定义，则搜索该城市（地区）内的所有符合条件的POI,如上述两个条件均未定义，则搜索范围为全国。为了性能及结果的清晰，强烈建议定义一个范围：矩形或行政区划代码均可。整个查询的语义为查找符合查询关键字，
     * 符合查询类型编码组合及在指定范围内的所有POI。
     * </p>
     * <p>
     * 此接口在网络连接出现问题的情况下，会抛出AMapException。<br>
     *
     * </p>
     *
     * @return 查询POI 的结果，结果是分页的，每页最多30 个。通过类PoiPagedResult 的实例可以检索每一页。
     * @throws AMapException。
     * @since V1.0.0
     */
    searchPOI(): Promise<PoiResultV2 | undefined>;
    /**
     * 查询POI异步接口。 如果此时矩形查询（SearchBound）已定义，则搜索范围为该矩形内的符合条件的POI，否则如果此时查询条件（Query）中的行政区划代码已定义，则搜索该城市（地区）内的所有符合条件的POI,如上述两个条件均未定义，则搜索范围为全国。建议定义一个范围：矩形或行政区划代码均可。整个查询的语义为查找符合查询关键字，
     * 符合查询类型编码组合及在指定范围内的指定POI。查询POI 的结果，结果是分页的，每页最多30 个。 此方法为异步处理。
     *
     * @since V1.0.0
     */
    searchPOIAsyn(): void;
    /**
     * 已知poiid信息（点击地图底图），搜索POI的详细信息，同步
     *
     * @param poiID
     *            poi的ID
     * @return poi的信息，如POI名称、类型、城市编码等。
     * @throws AMapException
     * @since V1.0.0
     */
    searchPOIId(p65: string): Promise<PoiItemV2 | undefined>;
    /**
     * 已知poiid信息（点击地图底图），搜索POI的详细信息，异步
     *
     * @param poiID
     *            poi的ID
     * @since V1.0.0
     */
    searchPOIIdAsyn(o65: string): void;
    /**
     * 设置查询条件。
     *
     * @param query
     *            新的查询条件。
     * @since V1.0.0
     */
    setQuery(query: PoiQueryV2): void;
    /**
     * 设置查询矩形。
     *
     * @param bnd
     *            新的查询矩形。
     * @since V1.0.0
     */
    setBound(n65: PoiSearchBoundV2): void;
    /**
     * 返回查询条件。
     *
     * @return 查询条件。
     * @since V1.0.0
     */
    getQuery(): PoiQueryV2 | undefined;
    /**
     * 返回查询矩形。
     *
     * @return 查询矩形。
     * @since V1.0.0
     */
    getBound(): PoiSearchBoundV2 | undefined;
}
export declare class PoiShowFields {
    /**
     * 默认值，只返回基础类
     */
    static DEFAULT: number;
    /**
     * 设置后返回子POI信息children相关信息
     */
    static CHILDREN: number;
    /**
     * 设置后返回子POI信息business相关信息
     */
    static BUSINESS: number;
    /**
     * 设置后返回室内相关信息
     */
    static INDOOR: number;
    /**
     * 设置后返回导航位置相关信息
     */
    static NAVI: number;
    /**
     * 设置后返回poi图片相关信息
     */
    static PHOTOS: number;
    /**
     * 设置后添加所有字段
     */
    static ALL: number;
    /**
     * PoiShowFields的指，需要使用上面定义的值
     * 可以叠加
     */
    value: number;
    constructor(value: number);
    getValue(): number;
    setValue(value: number): void;
}
/**
 * 此类定义了搜索的关键字，类别及城市。
 */
export declare class PoiQueryV2 {
    private r62;
    private f64;
    private b60;
    private i57;
    private j57;
    private d56;
    private g64;
    private i64;
    private d64;
    private j64;
    private k64;
    private channel;
    private s65;
    private l64;
    /**
     * 扩展字段 PoiShowFields.DEFAULT表示只返回基础数据，PoiShowFields.ALL表示所有数据 ，默认 PoiShowFields.DEFAULT
     * 可以组合
     */
    private t65;
    /**
     * 根据给定的参数来构造一个 PoiQueryV2 的新对象。
     * <p>
     * 参数 query 及 ctgr 至少需要定义一个，并且参数 city 必须定义，不能为空。
     * </p>
     *
     * @param query
     *            查询字符串，多个关键字用“|”分割 。
     * @param ctgr
     *            POI 类型的组合，比如定义如下组合：餐馆|电影院|景点 （POI类型请在网站“相关下载”处获取）。
     * @param city
     *            待查询城市（地区）的城市编码 citycode、城市名称（中文或中文全拼）、行政区划代码adcode。必设参数。
     * @since V1.0.0
     */
    constructor(query: string | undefined, m65: string | undefined, city: string | undefined);
    /**
     * 返回待查询建筑物的标识
     * @return 待查询建筑物的标识
     * @since V1.0.0
     */
    getBuilding(): string | undefined;
    /**
     * 如果要进行室内搜索，需要添加该字段
     * @param mBuilding 待查询建筑物的标识
     * @since V1.0.0
     */
    setBuilding(l65: string | undefined): void;
    /**
     * 返回待查字符串。
     *
     * @return 待查字符串。
     * @since V1.0.0
     */
    getQueryString(): string | undefined;
    /**
     * @deprecated 请参考 {@link ServiceSettings#setLanguage(String)}
     * @since V1.0.0
     */
    setQueryLanguage(language: string): void;
    protected getQueryLanguage(): string | undefined;
    /**
     * 返回待查分类组合。
     *
     * @return 待查分类组合。
     * @since V1.0.0
     */
    getCategory(): string;
    private getCategoryFilter00;
    /**
     * 返回待查城市（地区）的电话区号。
     *
     * @return 待查城市（地区）的电话区号。
     * @since V1.0.0
     */
    getCity(): string | undefined;
    /**
     * 获取设置查询的是第几页，从0开始。<font color="red">自 5.2.1后修改成从1开始，和iOS保持一致。</font>
     *
     * @return 查询的是第几页。
     * @since V1.0.0
     */
    getPageNum(): number;
    /**
     * 设置查询第几页的结果数目。
     *
     * @param pageNum
     *            查询第几页的结果，从0开始。<font color="red">自 5.2.1后修改成从1开始，和iOS保持一致。</font>
     * @since V1.0.0
     */
    setPageNum(k65: number): void;
    /**
     * 设置查询每页的结果数目。
     *
     * @param size
     *            新的查询条件， 默认值是20 条,取值范围在1-30 条。
     * @since V1.0.0
     */
    setPageSize(size: number): void;
    /**
     * 获取设置的查询页面的结果数目。
     *
     * @return 查询页面的结果数目。
     * @since V1.0.0
     */
    getPageSize(): number;
    /**
     * 仅在通过关键字搜索时进行限制严格按照设置城市搜索
     *
     * @param isLimit
     *            true，城市限制；false，输入文字是权重词汇时，全国搜索。默认为false。
     * @since V1.0.0
     */
    setCityLimit(j65: boolean): void;
    /**
     * 返回是否严格按照设定城市搜索
     *
     * @return true，城市限制；false，关键字是权重词汇时，全国搜索
     * @since V1.0.0
     */
    getCityLimit(): boolean;
    /**
     * 返回是否按照距离排序。
     *
     * @return true 按照距离排序，false不按照距离排序。
     * @since V1.0.0
     */
    getIsDistanceSort(): boolean;
    /**
     * 设置是否按距离排序
     * @param distanceSort 是否按照距离排序
     * @since V1.0.0
     */
    setDistanceSort(i65: boolean): void;
    /**
     * 获取设置的经纬度
     * @return 经纬度
     * @since V1.0.0
     */
    getLocation(): LatLonPoint | undefined;
    /**
     * 设置经纬度
     * @param location
     * @since V1.0.0
     */
    setLocation(location: LatLonPoint | undefined): void;
    /**
     * 是否对结果进行人工干预，如火车站，原因为POI较为特殊，结果存在人工干预，干预结果优先，所以距离优先的排序未生效
     * 仅周边搜索支持
     * @return 是否对结果进行人工干预
     * @since V1.0.0
     */
    getIsSpecial(): boolean;
    /**
     * 是否对结果进行人工干预，如火车站，原因为POI较为特殊，结果存在人工干预，干预结果优先，所以距离优先的排序未生效
     * 仅周边搜索支持
     * 默认为 true
     * @since V1.0.0
     */
    setSpecial(h65: boolean): void;
    /**
     * 扩展字段 base表示只返回基础数据，all表示所有数据 ，默认 base
     * @since V1.0.0
     */
    getShowFields(): PoiShowFields;
    /**
     * 扩展字段 base表示只返回基础数据，all表示所有数据 ，默认 base
     * @since V1.0.0
     */
    setShowFields(g65: PoiShowFields): void;
    /**
     * 设置channel
     *
     * @param channel
     * @since 9.4.5
     */
    setChannel(channel: string | undefined): void;
    /**
     * 获取channel
     *
     * @param channel
     * @since 9.4.5
     */
    getChannel(): string | undefined;
    /**
     * 设置搜索的质量,需要对应的key权限
     * 不同库存在POI信息精细度及实效性差异
     *
     * {@link PremiumType#DEFAULT} {@link PremiumType#ENTIRETY}
     *
     * @param premium
     * @since 9.5.0
     * @exclude javadoc中不显示。
     */
    setPremium(type: PremiumType): void;
    /**
     * 获取搜索的质量,需要对应的key权限
     * 不同库存在POI信息精细度及实效性差异
     *
     * @return premium {@link PremiumType#DEFAULT} {@link PremiumType#ENTIRETY}
     * @since 9.5.0
     * @exclude javadoc中不显示。
     */
    getPremium(): string;
    /**
     * 设置自定义参数
     * @param customParams
     */
    setCustomParams(f65: HashMap<string, string>): void;
    /**
     * 获取自定义参数
     * @return
     */
    getCustomParams(): HashMap<string, string>;
    /**
     * 比较两个查询条件是否相同（不包括查询第几页）。
     *
     * @param query
     *            待比较的对象
     * @return 查询条件是否相同
     * @since V1.0.0
     */
    queryEquals(query: PoiQueryV2 | undefined): boolean;
    /**
     * @exclude javadoc中不显示。
     */
    clone(): PoiQueryV2;
}
export declare class PoiSearchBoundV2 {
    private b64;
    private c64;
    private range;
    private centerPoint;
    private shape;
    private d64;
    private e64;
    /**
     * 圆形区域
     * @since V1.0.0
     */
    static BOUND_SHAPE: string;
    /**
     * 多边形区域
     * @since V1.0.0
     */
    static POLYGON_SHAPE: string;
    /**
     * 矩形区域
     * @since V1.0.0
     */
    static RECTANGLE_SHAPE: string;
    /**
     * 椭圆区域
     * @since V1.0.0
     */
    static ELLIPSE_SHAPE: string;
    /**
     * 根据给定的参数来构造PoiSearchBoundV2 的新对象，默认由近到远排序。 如果超出中国边界或者radiusInMeters<=0，则抛出异常。
     *
     * @param center
     *            该范围的中心点。
     * @param radiusInMeters
     *            半径，单位：米。
     * @param isDistanceSort
     *            是否按照距离排序。
     * @since V1.0.0
     */
    static createCircleSearchBoundV2(center: LatLonPoint, b65: number, c65?: boolean): PoiSearchBoundV2;
    /**
     * 根据给定的参数来构造PoiSearchBoundV2矩形区域新对象。
     * <p>
     * 如果超出中国边界或者lowerLeft>=upperRight，则抛出异常。
     * </p>
     *
     * @param lowerLeft
     *            矩形的左下角。
     * @param upperRight
     *            矩形的右上角。
     * @since V1.0.0
     */
    static createRectangleSearchBoundV2(y64: LatLonPoint, z64: LatLonPoint): PoiSearchBoundV2;
    /**
     * 根据给定的参数来构造PoiSearchV2.SearchBound 的新对象。 如果超出中国边界或者list不是首尾相接的几何点，并且不为多边形，则抛出IllegalArgumentException 异常。
     *
     * @param list
     *            首尾相接的几何点，可以组成多边形。
     * @since V1.0.0
     */
    static createPolygonSearchBound(list: ArrayList<LatLonPoint>): PoiSearchBoundV2;
    private doInit;
    /**
     * 返回矩形左下角坐标。
     *
     * @return 矩形左下角坐标。
     * @since V1.0.0
     */
    getLowerLeft(): LatLonPoint | undefined;
    /**
     * 返回矩形右上角坐标。
     *
     * @return 矩形右上角坐标。
     * @since V1.0.0
     */
    getUpperRight(): LatLonPoint | undefined;
    /**
     * 返回矩形中心点坐标。
     *
     * @return 矩形中心点坐标。
     * @since V1.0.0
     */
    getCenter(): LatLonPoint | undefined;
    /**
     * 返回查询范围半径。默认 3000
     * @return 查询范围半径。
     * @since V1.0.0
     */
    getRange(): number;
    /**
     * 返回查询范围形状。
     *
     * @return 查询范围形状。
     * @since V1.0.0
     */
    getShape(): string | undefined;
    /**
     * 返回是否按照距离排序。
     *
     * @return true 按照距离排序，false不按照距离排序。
     * @since V1.0.0
     */
    getIsDistanceSort(): boolean;
    /**
     * 返回首尾相接的几何点，可以组成多边形。
     *
     * @return 组成多边形的点列表
     * @since V1.0.0
     */
    getPolyGonList(): ArrayList<LatLonPoint> | undefined;
    /**
     * 比较两个查询范围是否相同
     *
     * @param obj
     *            比较对象
     * @return 查询范围是否相同
     * @exclude javadoc中不显示。
     */
    equals(obj: PoiSearchBoundV2 | undefined): boolean;
    /**
     * @exclude javadoc中不显示。
     */
    clone(): PoiSearchBoundV2;
}
/**
 * 本类为POI（Point Of Interest，兴趣点）搜索结果的异步处理回调接口。
 *
 * @since V1.0.0
 */
export interface OnPoiSearchListenerV2 {
    /**
     * 返回POI搜索异步处理的结果。
     *
     * @param pageResult
     *            POI的搜索结果，具体说明见PoiResult。
     * @param errorCode
     *            返回结果成功或者失败的响应码。1000为成功，其他为失败（详细信息参见网站开发指南-错误码对照表）。
     * @since V1.0.0
     */
    onPoiSearched: (pageResult: PoiResultV2 | undefined, errorCode: number) => void;
    /**
     * poi id搜索的结果回调
     *
     * @param poiItem
     *            poi信息
     * @param errorCode
     *            返回结果成功或者失败的响应码。1000为成功，其他为失败（详细信息参见网站开发指南-错误码对照表）。
     * @since V1.0.0
     */
    onPoiItemSearched: (poiItem: PoiItemV2 | undefined, errorCode: number) => void;
}
