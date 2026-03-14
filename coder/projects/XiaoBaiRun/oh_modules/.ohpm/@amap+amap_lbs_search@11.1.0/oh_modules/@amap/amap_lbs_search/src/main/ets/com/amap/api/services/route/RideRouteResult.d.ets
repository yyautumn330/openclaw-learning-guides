// @keepTs
// @ts-nocheck
import { RouteResult } from './RouteResult';
import ArrayList from "@ohos.util.ArrayList";
import { RidePath } from './RidePath';
import { RideRouteQuery } from './RideRouteQuery';
/**
 * 定义了骑行路径规划的结果集。
 * @since V1.0.0
 */
export declare class RideRouteResult extends RouteResult {
    private d69?;
    private v82?;
    /**
     * 返回骑行路径规划方案。
     * @return 骑行路径规划方案。
     * @since V1.0.0
     */
    getPaths(): ArrayList<RidePath>;
    /**
     * 设置骑行路径规划方案。
     * @param paths 骑行路径规划方案。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    setPaths(u82: ArrayList<RidePath>): void;
    /**
     * 返回该结果对应的查询参数。
     * @return 该结果对应的查询参数。
     * @since V1.0.0
     */
    getRideQuery(): RideRouteQuery;
    /**
     * 设置结果对应的查询参数。
     * @param rideQuery 查询参数。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    w82(t82: RideRouteQuery): void;
}
