// @keepTs
// @ts-nocheck
import { DistrictResult } from "./DistrictResult";
import { DistrictSearchQuery } from "./DistrictSearchQuery";
import { OnDistrictSearchListener } from "./OnDistrictSearchListener";
/**
 * 行政区域查询类。请用 DistrictSearchQuery 类设定搜索参数，如果不设定，默认查询全国。
 * @since 1.0.1
 *
 */
export declare class DistrictSearch {
    private search?;
    constructor(context: Context);
    /**
     * 返回查询条件。
     * @return 查询条件。
     * @since 1.0.1
     */
    getQuery(): DistrictSearchQuery | undefined;
    /**
     * 设置查询条件。
     * @param districtSearchQuery 新的查询条件。
     * @since 1.0.1
     */
    setQuery(z56: DistrictSearchQuery): void;
    /**
     * 查询行政区的同步接口。
     * @return 行政区域的搜索结果，具体说明见 {@link DistrictResult DistrictResult}。
     * @throws AMapException <br>
     *    在网络连接出现问题的情况下，会抛出{@link AMapException#AMAP_CLIENT_NETWORK_EXCEPTION}。<br>
     *      在Query参数不正确的时候会抛出 {@link AMapException#AMAP_CLIENT_INVALID_PARAMETER}
     * @since 1.0.1
     */
    searchDistrict(): Promise<DistrictResult | undefined> | undefined;
    /**
     * 查询行政区的异步接口。
     * @since 1.0.1
     */
    searchDistrictAsyn(): void;
    /**
     * 查询行政区的异步接口。
     * @deprecated 请参考 {@link DistrictSearch #searchDistrictAsyn()}
     * @since 1.0.1
     * */
    searchDistrictAnsy(): void;
    /**
     * 设置行政区划查询监听。
     * @param districtSearchListener 行政区划查询监听对象。
     * @since 1.0.1
     */
    setOnDistrictSearchListener(y56: OnDistrictSearchListener): void;
}
