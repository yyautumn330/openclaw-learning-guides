// @keepTs
// @ts-nocheck
import { GeocodeAddress } from "./GeocodeAddress";
import { GeocodeQuery } from "./GeocodeQuery";
import ArrayList from "@ohos.util.ArrayList";
/**
 * 地理编码的搜索结果。
 * @since V1.0.0
 */
export declare class GeocodeResult {
    private o58;
    private p58;
    /**
     * 依据给定的参数构造地理编码的搜索结果对象。
     * @param geocodeQuery 查询条件
     * @param geocodeAddressList 地理编码搜索的结果
     * @since V1.0.0
     */
    constructor(m58: GeocodeQuery, n58: ArrayList<GeocodeAddress>);
    /**
     * 返回该结果对应的查询参数。
     * @return 该结果对应的查询参数。
     * @since V1.0.0
     */
    getGeocodeQuery(): GeocodeQuery;
    /**
     * 设置查询结果对应的查询参数
     * @param geocodeQuery 查询条件
     * @since V1.0.0
     */
    setGeocodeQuery(l58: GeocodeQuery): void;
    /**
     * 返回地理编码搜索的地理结果。
     * @return 地理编码搜索的地理结果。
     * @since V1.0.0
     */
    getGeocodeAddressList(): ArrayList<GeocodeAddress>;
    /**
     * 设置地理编码搜索的结果
     * @param geocodeAddressList 地理编码搜索的结果
     * @since V1.0.0
     */
    setGeocodeAddressList(k58: ArrayList<GeocodeAddress>): void;
}
