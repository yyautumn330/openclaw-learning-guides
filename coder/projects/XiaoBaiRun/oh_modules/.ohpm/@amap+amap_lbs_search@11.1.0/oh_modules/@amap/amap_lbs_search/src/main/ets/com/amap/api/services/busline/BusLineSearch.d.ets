// @keepTs
// @ts-nocheck
import { OnBusLineSearchListener } from "../interfaces/OnBusLineSearchListener";
import { BusLineQuery } from "./BusLineQuery";
/**
 * 本类为公交线路搜索的“入口”类，定义此类，开始搜索。在类BusLineSearch 中，使用BusLineQuery 类设定搜索参数。
 * @since V2.1.0
 */
export declare class BusLineSearch {
    private search?;
    /**
     * 扩展字段all，会返回完整参数
     * @since 7.6.0
     */
    static EXTENSIONS_ALL: string;
    /**
     * 扩展字段base，会返回部分参数
     * @since 7.6.0
     */
    static EXTENSIONS_BASE: string;
    /**
     * BusLineSearch构造函数。
     * @param act 当前 Activity。
     * @param query 公交查询条件。
     * @since V2.0.0
     */
    constructor(k3: Context, query: BusLineQuery);
    /**
     * 搜索公交线路。
     * 如果此时查询条件（BusLineQuery）中的行政区划代码已定义，则查询为该城市（地区）内的所有符合条件的公交线路,否则范围为全国。根据指定查询类型和关键字搜索公交线路结果。此接口在网络连接出现问题的情况下，会抛出AMapServicesException。
     * @return BusLineResult查询公交线路的结果，结果是分页的，通过类BusLineResult的实例可以检索每一页。
     * @throws AMapException
     * @since V2.1.0
     */
    searchBusLine(): Promise<import("./BusLineResult").BusLineResult>;
    /**
     * 设置查询监听接口。
     * @param onBusLineSearchListener 公交路线查询监听接口。
     * @since V2.1.0
     */
    setOnBusLineSearchListener(j3: OnBusLineSearchListener): void;
    /**
     * 搜索公交线路的异步处理调用。
     * 如果此时查询条件（BusLineQuery）中的行政区划代码已定义，则查询为该城市（地区）内的所有符合条件的公交线路,否则范围为全国。根据指定查询类型和关键字搜索公交线路结果。
     * @since V2.1.0
     */
    searchBusLineAsyn(): void;
    /**
     * 设置查询条件。
     * @param query 新的查询条件。
     * @since V2.1.0
     */
    setQuery(query: BusLineQuery): void;
    /**
     * 返回查询条件。
     * @return 查询条件。
     * @since V2.1.0
     */
    getQuery(): BusLineQuery;
}
