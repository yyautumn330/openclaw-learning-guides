// @keepTs
// @ts-nocheck
import { DriveRouteQueryV2 } from "../route/DriveRouteQueryV2";
import { DriveRouteResultV2 } from "../route/DriveRouteResultV2";
import { OnRouteSearchListenerV2 } from "../route/OnRouteSearchListenerV2";
import { WalkRouteQueryV2 } from "../route/WalkRouteQueryV2";
import { WalkRouteResultV2 } from "../route/WalkRouteResultV2";
import { RideRouteQueryV2 } from "../route/RideRouteQueryV2";
import { RideRouteResultV2 } from "../route/RideRouteResultV2";
import { BusRouteQueryV2 } from "../route/BusRouteQueryV2";
import { BusRouteResultV2 } from "../route/BusRouteResultV2";
/**
 * 该类定义了一条路径。此类不可以直接构造，只能通过类的静态（static）方法得到其实例。一条路径，可以是公交路径、步行路径或者自驾路径。根据构造时的参数不同，可以得到不同的路径。
 * @since V2.1.0
 */
export interface t60 {
    /**
     * 路径搜索结果监听接口设置。
     * @param listener 路径搜索结果监听接口。
     * @since V2.1.0
     */
    setRouteSearchListener(listener: OnRouteSearchListenerV2): void;
    /**
     * 根据指定的参数来计算驾车路径。
     * @param driveQuery 查询参数。
     * @throws AMapException
     * @since V2.1.0
     */
    calculateDriveRoute(driveQuery: DriveRouteQueryV2): Promise<DriveRouteResultV2 | undefined>;
    /**
     * 异步处理。根据指定的参数来计算驾车路径的异步处理。
     * @param driveQuery 查询参数。
     * @since V2.1.0
     */
    calculateDriveRouteAsyn(driveQuery: DriveRouteQueryV2): void;
    /**
     * 根据指定的参数来计算骑行路径。
     * @param rideQuery 查询参数。
     * @throws AMapException
     * @since V3.5.0
     */
    calculateRideRoute(rideQuery: RideRouteQueryV2): Promise<RideRouteResultV2 | undefined>;
    /**
     * 异步处理。根据指定的参数来计算骑行路径的异步处理。
     * @param rideQuery 查询参数。
     * @since V3.5.0
     */
    calculateRideRouteAsyn(rideQuery: RideRouteQueryV2): void;
    /**
     * 异步处理。根据指定的参数来计算步行路径的异步处理。
     * @param walkQuery 查询参数。
     * @since V2.1.0
     */
    calculateWalkRoute(walkQuery: WalkRouteQueryV2): Promise<WalkRouteResultV2 | undefined>;
    /**
     * 异步处理。根据指定的参数来计算步行路径的异步处理。
     * @param walkQuery 查询参数。
     * @since V2.1.0
     */
    calculateWalkRouteAsyn(walkQuery: WalkRouteQueryV2): void;
    /**
     * 根据指定的参数来计算公交路径。只支持市内公交换乘。
     * @param busQuery 查询参数。
     * @throws AMapException
     * @since V2.1.0
     */
    calculateBusRoute(busQuery: BusRouteQueryV2): Promise<BusRouteResultV2 | undefined>;
    /**
     * 异步处理。根据指定的参数来计算公交换乘路径的异步处理。只支持市内公交换乘。
     * @param busQuery 查询参数。
     * @since V2.1.0
     */
    calculateBusRouteAsyn(busQuery: BusRouteQueryV2): void;
}
