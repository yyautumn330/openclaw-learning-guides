// @keepTs
// @ts-nocheck
import { DrivePath } from "./DrivePath";
import { DriveRouteQuery } from "./DriveRouteQuery";
import { RouteResult } from "./RouteResult";
import ArrayList from "@ohos.util.ArrayList";
/**
 * 定义了驾车路径规划的结果集。
 * @since 1.0.0
 */
export declare class DriveRouteResult extends RouteResult {
    private c69;
    private d69?;
    private t77?;
    /**
     * 返回从起点到终点打车的费用，单位元。
     * 费用是以驾车路线最短距离估计出租车的费用。
     * @return 打车所需费用。
     * @since 1.0.0
     */
    getTaxiCost(): number;
    /**
     *
     * @internal
     * @param mTaxiCost
     */
    f33(s77: number): void;
    /**
     * 返回驾车路径规划方案。
     * @return 驾车路径规划方案。
     * @since 1.0.0
     */
    getPaths(): ArrayList<DrivePath>;
    /**
     * 设置驾车路径规划方案。
     * @param mPaths 驾车路径规划方案。
     * @since 1.0.0
     * @internal
     */
    setPaths(r77: ArrayList<DrivePath>): void;
    /**
     * 返回该结果对应的查询参数。
     * @return 该结果对应的查询参数。
     * @since 1.0.0
     */
    getDriveQuery(): DriveRouteQuery;
    /**
     * 设置结果对应的查询参数。
     * @param driveQuery 查询参数。
     * @since 1.0.0
     * @internal
     */
    u77(q77: DriveRouteQuery): void;
}
