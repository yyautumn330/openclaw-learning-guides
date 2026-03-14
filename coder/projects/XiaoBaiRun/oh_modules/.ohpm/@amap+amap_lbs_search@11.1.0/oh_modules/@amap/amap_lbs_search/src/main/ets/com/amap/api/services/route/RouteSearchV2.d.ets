// @keepTs
// @ts-nocheck
import { DriveRouteQueryV2 } from "./DriveRouteQueryV2";
import { OnRouteSearchListenerV2 } from "./OnRouteSearchListenerV2";
import { WalkRouteQueryV2 } from "./WalkRouteQueryV2";
import { RideRouteQueryV2 } from "./RideRouteQueryV2";
import { BusRouteQueryV2 } from "./BusRouteQueryV2";
/**
 * 该类路径规划搜索的入口，定义此类开始路径规划搜索
 *
 * @since V1.0.0
 */
export declare class RouteSearchV2 {
    private static readonly v44;
    private search?;
    /**
     * 根据给定的参数来构造一个RouteSearch的新对象。
     *
     * @param context 对应的Context。
     * @since V1.0.0
     */
    constructor(context: Context);
    /**
     * 路径搜索结果监听接口设置。
     *
     * @param listener 路径搜索结果监听接口。
     * @since V1.0.0
     */
    setRouteSearchListener(listener: OnRouteSearchListenerV2): void;
    /**
     * 根据指定的参数来计算驾车路径。
     *
     * @param driveQuery 查询参数。
     * @throws AMapException 途经点太多或避让区域太大会返回非法参数
     * @since V1.0.0
     */
    calculateDriveRoute(n85: DriveRouteQueryV2): Promise<import("./DriveRouteResultV2").DriveRouteResultV2>;
    /**
     * 异步处理。根据指定的参数来计算驾车路径的异步处理。
     *
     * @param driveQuery 查询参数。
     * @since V1.0.0
     */
    calculateDriveRouteAsyn(m85: DriveRouteQueryV2): void;
    /**
     * 根据指定的参数来计算骑行路径，同步接口。
     *
     * @param rideQuery 查询参数。
     * @throws AMapException
     * @since V1.0.0
     */
    calculateRideRoute(l85: RideRouteQueryV2): Promise<import("./RideRouteResultV2").RideRouteResultV2>;
    /**
     * 异步处理。根据指定的参数来计算骑行路径的异步处理。
     *
     * @param rideQuery 查询参数。
     * @since V1.0.0
     */
    calculateRideRouteAsyn(k85: RideRouteQueryV2): void;
    /**
     * 根据指定的参数来计算步行路径。
     *
     * @param walkQuery 查询参数。
     * @throws AMapException
     * @since V1.0.0
     */
    calculateWalkRoute(j85: WalkRouteQueryV2): Promise<import("./WalkRouteResultV2").WalkRouteResultV2>;
    /**
     * 异步处理。根据指定的参数来计算步行路径的异步处理。
     *
     * @param walkQuery 查询参数。
     * @since V1.0.0
     */
    calculateWalkRouteAsyn(i85: WalkRouteQueryV2): void;
    /**
     * 根据指定的参数来计算公交路径。只支持市内公交换乘。
     *
     * @param busQuery 查询参数。
     * @throws AMapException
     * @since V9.4.0
     */
    calculateBusRoute(h85: BusRouteQueryV2): Promise<import("./BusRouteResultV2").BusRouteResultV2>;
    /**
     * 异步处理。根据指定的参数来计算公交换乘路径的异步处理。只支持市内公交换乘。
     *
     * @param busQuery 查询参数。
     * @since V9.4.0
     */
    calculateBusRouteAsyn(g85: BusRouteQueryV2): void;
}
