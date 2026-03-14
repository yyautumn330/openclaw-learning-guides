// @keepTs
// @ts-nocheck
import { RoutePOISearchQuery } from "./RoutePOISearchQuery";
import { RoutePOISearchResult } from "./RoutePOISearchResult";
/**
 * 本类为沿途POI搜索的“入口”类，定义此类，开始搜索。
 * @since V1.0.0
 */
export declare class RoutePOISearch {
    /**
     * 速度优先。
     *
     * @since V1.0.0
     */
    static DrivingDefault: number;
    /**
     * 费用优先（不走收费路的最快道路）。
     *
     * @since V1.0.0
     */
    static DrivingSaveMoney: number;
    /**
     * 距离优先。
     *
     * @since V1.0.0
     */
    static DrivingShortDistance: number;
    /**
     * 不走快速路。
     *
     * @since V1.0.0
     */
    static DrivingNoExpressways: number;
    /**
     * 避免拥堵。
     *
     * @since V1.0.0
     */
    static DrivingAvoidCongestion: number;
    /**
     * 不走高速。
     *
     * @since V1.0.0
     */
    static DrivingNoHighWay: number;
    /**
     * 不走高速且避免收费。
     *
     * @since V1.0.0
     */
    static DrivingNoHighWaySaveMoney: number;
    /**
     * 避免收费与拥堵。
     *
     * @since V1.0.0
     */
    static DrivingSaveMoneyAvoidCongestion: number;
    /**
     * 不走高速且躲避收费和拥堵。
     *
     * @since V1.0.0
     */
    static DrivingNoHighAvoidCongestionSaveMoney: number;
    private search;
    /**
     * 沿途搜索构造方法。
     * @param context 对应的Context。
     * @param query 查询条件。
     *
     * @since V1.0.0
     */
    constructor(context: Context, query: RoutePOISearchQuery);
    /**
     * 设置查询监听接口。
     *
     * @param listener
     *            查询监听接口。
     * @since V1.0.0
     */
    setPoiSearchListener(listener: OnRoutePOISearchListener): void;
    /**
     * 设置查询条件。
     *
     * @param query 查询条件。
     *
     * @since V1.0.0
     */
    setQuery(query: RoutePOISearchQuery): void;
    /**
     * 沿途搜索POI异步查询接口。
     *
     * @since V1.0.0
     */
    searchRoutePOIAsyn(): void;
    /**
     * 沿途搜索同步查询接口。
     *
     * @return 沿途搜索结果。具体说明见RoutePOISearchResult。
     *
     * @throws AMapException
     *
     * @since V1.0.0
     */
    searchRoutePOI(): Promise<RoutePOISearchResult | undefined>;
}
/**
 * 搜索的type类型
 * TypeGasStation 加油站；TypeMaintenanceStation 维修站；TypeATM 自助银行；TypeToilet 卫生间。
 *
 * @since V1.0.0
 */
export declare enum RoutePOISearchType {
    /**
     * 加油站
     * @since V1.0.0
     */
    TypeGasStation = 0,
    /**
     * 维修站
     * @since V1.0.0
     */
    TypeMaintenanceStation = 1,
    /**
     * 自助银行
     * @since V1.0.0
     */
    TypeATM = 2,
    /**
     * 卫生间
     * @since V1.0.0
     */
    TypeToilet = 3,
    /**
     * 加气站
     * @since V1.0.0
     */
    TypeFillingStation = 4,
    /**
     * 服务区
     * @since V1.0.0
     */
    TypeServiceArea = 5,
    /**
     * 充电站
     * @since V1.0.0
     */
    TypeChargeStation = 6,
    /**
     * 美食
     * @since V1.0.0
     */
    TypeFood = 7,
    /**
     * 酒店
     * @since V1.0.0
     */
    TypeHotel = 8
}
/**
 * 本类为沿途搜索POI（Point Of Interest，兴趣点）结果的异步处理回调接口。
 *
 * @since V1.0.0
 */
export interface OnRoutePOISearchListener {
    /**
     * 返回POI搜索异步处理的结果。
     *
     * @param result    沿途POI的搜索结果，具体说明见RoutePOISearchResult。
     * @param errorCode 返回结果成功或者失败的响应码。1000为成功（详细信息参见网站开发指南-错误码对照表）。
     *
     * @since V1.0.0
     */
    onRoutePoiSearched: (result: RoutePOISearchResult | undefined, errorCode: number) => void;
}
