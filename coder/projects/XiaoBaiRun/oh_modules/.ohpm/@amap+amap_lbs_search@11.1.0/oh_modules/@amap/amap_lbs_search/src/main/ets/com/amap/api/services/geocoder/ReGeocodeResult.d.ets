// @keepTs
// @ts-nocheck
import { ReGeocodeAddress } from "./ReGeocodeAddress";
import { ReGeocodeQuery } from "./ReGeocodeQuery";
/**
 * 逆地理编码的搜索结果。
 * @since V1.0.0
 */
export declare class ReGeocodeResult {
    private o59;
    private p59;
    /**
     * ReGeocodeResult  构造函数
     * @param reGeocodeQuery 逆地理编码查询条件
     * @param reGeocodeAddress 逆地理编码查询结果
     * @since V1.0.0
     */
    constructor(m59: ReGeocodeQuery, n59: ReGeocodeAddress);
    /**
     * 返回该结果对应的查询参数。
     * @return 该结果对应的查询参数。
     * @since V1.0.0
     */
    getReGeocodeQuery(): ReGeocodeQuery;
    /**
     * 设置该结果对应的查询参数
     * @param reGeocodeQuery 查询参数
     * @since V1.0.0
     */
    setReGeocodeQuery(l59: ReGeocodeQuery): void;
    /**
     * 返回逆地理编码搜索的地理结果。
     * @return 逆地理编码搜索的地理结果。
     * @since V1.0.0
     */
    getReGeocodeAddress(): ReGeocodeAddress;
    /**
     * 设置逆地理编码搜索的结果
     * @param reGeocodeAddress 逆地理编码搜索的结果
     * @since V1.0.0
     */
    setReGeocodeAddress(k59: ReGeocodeAddress): void;
}
