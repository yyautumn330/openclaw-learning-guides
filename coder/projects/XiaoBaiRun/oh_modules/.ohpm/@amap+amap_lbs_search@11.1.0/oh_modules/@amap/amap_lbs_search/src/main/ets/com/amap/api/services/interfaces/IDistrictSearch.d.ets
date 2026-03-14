// @keepTs
// @ts-nocheck
import { DistrictResult } from "../district/DistrictResult";
import { DistrictSearchQuery } from "../district/DistrictSearchQuery";
import { OnDistrictSearchListener } from "../district/OnDistrictSearchListener";
/**
 * 行政区域查询类。请用 DistrictSearchQuery 类设定搜索参数，如果不设定，默认查询全国。
 * @since V2.3.0
 *
 */
export interface w56 {
    /**
     * 返回查询条件。
     * @return 查询条件。
     * @since V2.3.0
     */
    getQuery(): DistrictSearchQuery | undefined;
    /**
     * 设置查询条件。
     * @param districtSearchQuery 新的查询条件。
     * @since V2.3.0
     */
    setQuery(districtSearchQuery: DistrictSearchQuery): void;
    /**
     * 查询行政区的异步接口。
     * @since V2.3.0
     */
    searchDistrictAsyn(): void;
    /**
     * 查询行政区的异步接口。
     * @deprecated
     * */
    searchDistrictAnsy(): void;
    /**
     * 设置行政区划查询监听。
     * @param districtSearchListener 行政区划查询监听对象。
     * @since V2.3.0
     */
    setOnDistrictSearchListener(districtSearchListener: OnDistrictSearchListener): void;
    /**
     * 查询行政区的同步接口。
     * @since V4.0.0
     */
    searchDistrict(): Promise<DistrictResult | undefined>;
}
