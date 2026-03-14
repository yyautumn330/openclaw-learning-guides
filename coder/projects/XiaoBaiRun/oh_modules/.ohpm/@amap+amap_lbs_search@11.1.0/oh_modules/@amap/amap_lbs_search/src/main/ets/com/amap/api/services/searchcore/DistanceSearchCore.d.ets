// @keepTs
// @ts-nocheck
import { n60 } from "../interfaces/IDistanceSearch";
import { DistanceResult } from "../route/DistanceResult";
import { DistanceQuery, OnDistanceSearchListener } from "../route/DistanceSearch";
/**
 * Created by zxy on 2018/3/5.
 * 距离测量核心内
 */
export declare class c74 implements n60 {
    private static v44;
    private context;
    private r90;
    private listener;
    constructor(context: Context);
    calculateRouteDistance(p90: DistanceQuery): Promise<DistanceResult | undefined>;
    /**
     * 检查距离测量请求参数是否合法
     * @param distanceQuery
     * @return true 表示不合法，false表示合法
     */
    private s90;
    calculateRouteDistanceAsyn(query: DistanceQuery): void;
    setDistanceSearchListener(listener: OnDistanceSearchListener): void;
}
