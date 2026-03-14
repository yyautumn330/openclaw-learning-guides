// @keepTs
// @ts-nocheck
import { RouteResult } from "./RouteResult";
import ArrayList from "@ohos.util.ArrayList";
import { BusPathV2 } from "./BusPathV2";
import { BusRouteQueryV2 } from "./BusRouteQueryV2";
/**
 * 定义了公交路径规划的结果集。
 * @since V2.1.0
 */
export declare class BusRouteResultV2 extends RouteResult {
    private c69;
    private d69;
    private e69?;
    private m54;
    /**
     * 返回规划的公交路线对应的打车费用，单位元。
     * 费用是以驾车路线最短距离估计出租车的费用。
     * @return 打车所需费用。
     * @since V2.1.0
     */
    getTaxiCost(): number;
    /**
     * 设置规划路线对应的打车费用，单位元。
     * @param mTaxiCost 打车所需费用。
     * @exclude javadoc中不显示。
     */
    f33(i69: number): void;
    /**
     * 返回公交路径规划方案。
     * @return 公交路径规划方案。
     * @since V2.1.0
     */
    getPaths(): ArrayList<BusPathV2>;
    /**
     * 设置公交路径规划方案 。
     * @param mPaths 公交路径规划方案。
     * @exclude javadoc中不显示。
     */
    setPaths(h69: ArrayList<BusPathV2>): void;
    /**
     * 返回该结果对应的查询参数。
     * @return 该结果对应的查询参数。
     * @since V2.1.0
     */
    getBusQuery(): BusRouteQueryV2;
    /**
     * 设置该结果对应的查询参数。
     * @param busQuery 对应的查询参数。
     * @exclude javadoc中不显示。
     */
    f69(g69: BusRouteQueryV2): void;
    /**
     * 总距离
     *
     * @return
     */
    getDistance(): number;
    /**
     * 总距离
     *
     * @param distance
     */
    setDistance(distance: number): void;
    /**
     * BusRouteResult的构造方法。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    constructor();
}
