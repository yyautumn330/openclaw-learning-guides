// @keepTs
// @ts-nocheck
import { DistrictResult } from "../district/DistrictResult";
import { DistrictSearchQuery } from "../district/DistrictSearchQuery";
import { OnDistrictSearchListener } from "../district/OnDistrictSearchListener";
import { w56 } from "../interfaces/IDistrictSearch";
/**
 * 行政区域查询类。请用 DistrictSearchQuery 类设定搜索参数，如果不设定，默认查询全国。
 * @since V2.3.0
 *
 */
export declare class x56 implements w56 {
    private context;
    private y89;
    private z90;
    private pageCount;
    private a91;
    private b91;
    private c91;
    constructor(context: Context);
    private z89;
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
    setQuery(x90: DistrictSearchQuery): void;
    private h4;
    protected a90(w90: number): DistrictResult | undefined;
    private b90;
    searchDistrictAsyn(): void;
    searchDistrictAnsy(): void;
    setOnDistrictSearchListener(u90: OnDistrictSearchListener): void;
    searchDistrict(): Promise<DistrictResult | undefined>;
}
