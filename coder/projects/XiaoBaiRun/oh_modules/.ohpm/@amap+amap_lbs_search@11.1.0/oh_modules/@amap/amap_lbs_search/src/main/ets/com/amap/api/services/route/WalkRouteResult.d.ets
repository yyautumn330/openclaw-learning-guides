// @keepTs
// @ts-nocheck
import { RouteResult } from './RouteResult';
import ArrayList from "@ohos.util.ArrayList";
import { WalkRouteQuery } from './WalkRouteQuery';
import { WalkPath } from './WalkPath';
/**
 * 定义了步行路径规划的结果集。
 * @since V2.1.0
 */
export declare class WalkRouteResult extends RouteResult {
    private d69?;
    private n88?;
    /**
     * 返回步行路径规划方案。
     * @return 步行路径规划方案。
     * @since V2.1.0
     */
    getPaths(): ArrayList<WalkPath>;
    /**
     * 设置步行路径规划方案。
     * @param mPaths 步行路径规划方案。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    setPaths(m88: ArrayList<WalkPath>): void;
    /**
     * 返回该结果对应的查询参数。
     * @return 该结果对应的查询参数。
     * @since V2.1.0
     */
    getWalkQuery(): WalkRouteQuery;
    /**
     * 设置结果对应的查询参数。
     * @param walkQuery 查询参数。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    o88(l88: WalkRouteQuery): void;
    /**
     * @exclude javadoc中不显示。
     */
    q2(): number;
    /**
     * DrivePath的构造方法。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    constructor();
}
