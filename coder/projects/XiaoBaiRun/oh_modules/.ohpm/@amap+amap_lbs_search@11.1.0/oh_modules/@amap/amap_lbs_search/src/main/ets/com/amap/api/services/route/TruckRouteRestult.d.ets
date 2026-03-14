// @keepTs
// @ts-nocheck
import { TruckRouteQuery } from "./TruckRouteQuery";
import ArrayList from "@ohos.util.ArrayList";
import { RouteResult } from "./RouteResult";
import { TruckPath } from "./TruckPath";
import { LatLonPoint } from "../core/LatLonPoint";
/**
 * 定义了货车路径规划的结果集。
 *
 * @since 1.0.1
 */
export declare class TruckRouteRestult extends RouteResult {
    private q87?;
    private paths;
    private startPos?;
    private r87?;
    /**
     * @internal
     */
    s87(p87: TruckRouteQuery): void;
    /**
     * @internal
     */
    setPaths(o87: ArrayList<TruckPath>): void;
    /**
     * @internal
     */
    s32(startPos?: LatLonPoint): void;
    /**
     * @internal
     */
    u32(n87?: LatLonPoint): void;
    /**
     * 请求时填写的参数配置
     * @return 请求时填写的参数配置
     * @since 1.0.1
     */
    getTruckQuery(): TruckRouteQuery;
    /**
     * 里面包含具体货车路线的方案
     * @return 货车路线的具体方案
     * @since 1.0.1
     */
    getPaths(): ArrayList<TruckPath>;
    /**
     * 路线起点坐标
     * @return 起点坐标
     * @since 1.0.1
     */
    getStartPos(): LatLonPoint;
    /**
     * 路线终点坐标
     * @return 终点坐标
     * @since 1.0.1
     */
    getTargetPos(): LatLonPoint;
}
