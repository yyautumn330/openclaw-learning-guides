// @keepTs
// @ts-nocheck
import { DistrictResult } from "./DistrictResult";
/**
 * 本类为 District（行政区域）搜索结果的异步处理回调接口。
 * @since 1.0.1
 */
export interface OnDistrictSearchListener {
    /**
     * 返回District（行政区划）异步处理的结果。
     * @param districtResult 行政区域的搜索结果，具体说明见 {@link DistrictResult DistrictResult}。
     * @since 1.0.1
     */
    onDistrictSearched: (districtResult: DistrictResult | undefined) => void;
}
