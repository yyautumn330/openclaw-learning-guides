// @keepTs
// @ts-nocheck
import { BusStationQuery } from "../busline/BusStationQuery";
import { BusStationResult } from "../busline/BusStationResult";
import { OnBusStationSearchListener } from "./OnBusStationSearchListener";
/**
 * 本类为公交站点搜索的“入口”类，定义此类，开始搜索。在类BusStationSearch中，使用BusStationQuery类设定搜索参数。
 * @since V2.1.0
 */
export interface n4 {
    /**
     * 搜索公交站点。
     * 如果此时查询条件（BusStationQuery）中的行政区划代码已定义，则查询为该城市（地区）内的所有符合条件的公交站点,否则范围为全国。根据指定查询类型和关键字搜索公交站点结果。此接口在网络连接出现问题的情况下，会抛出AMapServicesException。
     * @return 查询公交站点的结果，结果是分页的，通过类BusStationResult 的实例可以检索每一页。
     * @throws AMapException
     * @since V2.1.0
     */
    searchBusStation(): Promise<BusStationResult | undefined>;
    /**
     * 公交站点搜索结果监听接口设置。
     * @param onBusStationSearchListener 公交站点搜索结果监听接口。
     * @since V2.1.0
     */
    setOnBusStationSearchListener(onBusStationSearchListener: OnBusStationSearchListener): void;
    /**
     * 搜索公交站点的异步处理调用。
     * 如果此时查询条件（BusStationQuery）中的行政区划代码已定义，则查询为该城市（地区）内的所有符合条件的公交站点,否则范围为全国。根据指定查询类型和关键字搜索公交站点结果。
     * @since V2.1.0
     */
    searchBusStationAsyn(): void;
    /**
     * 设置查询条件。
     * @param query 新的查询条件。
     * @since V2.1.0
     */
    setQuery(query: BusStationQuery): void;
    /**
     * 返回查询条件。
     * @return 查询条件。
     * @since V2.1.0
     */
    getQuery(): BusStationQuery;
}
