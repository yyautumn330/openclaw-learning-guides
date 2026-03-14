// @keepTs
// @ts-nocheck
import { BusRouteQuery } from "../route/BusRouteQuery";
import { BusRouteResult } from "../route/BusRouteResult";
import { DrivePlanQuery } from "../route/DrivePlanQuery";
import { DriveRoutePlanResult } from "../route/DriveRoutePlanResult";
import { DriveRouteQuery } from "../route/DriveRouteQuery";
import { DriveRouteResult } from "../route/DriveRouteResult";
import { OnRoutePlanSearchListener } from "../route/OnRoutePlanSearchListener";
import { OnRouteSearchListener } from "../route/OnRouteSearchListener";
import { OnTruckRouteSearchListener } from "../route/OnTruckRouteSearchListener";
import { RideRouteQuery } from "../route/RideRouteQuery";
import { RideRouteResult } from '../route/RideRouteResult';
import { TruckRouteQuery } from "../route/TruckRouteQuery";
import { TruckRouteRestult } from "../route/TruckRouteRestult";
import { WalkRouteQuery } from "../route/WalkRouteQuery";
import { WalkRouteResult } from "../route/WalkRouteResult";
export interface s60 {
    /**
     * 路径搜索结果监听接口设置。
     * @param listener 路径搜索结果监听接口。
     * @since 1.0.0
     */
    setRouteSearchListener(listener: OnRouteSearchListener): void;
    /**
     * 根据指定的参数来计算步行路径。
     * @param walkQuery 查询参数。
     * @throws AMapException
     * @since 1.0.0
     */
    calculateWalkRoute(walkQuery: WalkRouteQuery): Promise<WalkRouteResult | undefined>;
    /**
     * 异步处理。根据指定的参数来计算步行路径的异步处理。
     * @param walkQuery 查询参数。
     * @since 1.0.0
     */
    calculateWalkRouteAsyn(walkQuery: WalkRouteQuery): void;
    /**
     * 根据指定的参数来计算驾车路径。
     * @param driveQuery 查询参数。
     * @throws AMapException
     * @since 1.0.0
     */
    calculateDriveRoute(driveQuery: DriveRouteQuery): Promise<DriveRouteResult | undefined>;
    /**
     * 异步处理。根据指定的参数来计算驾车路径的异步处理。
     * @param driveQuery 查询参数。
     * @since 1.0.0
     */
    calculateDriveRouteAsyn(driveQuery: DriveRouteQuery): void;
    /**
     * 未来规划路径搜索结果监听接口设置。
     * @param onRoutePlanSearchListener
     * @since 1.0.0
     */
    setOnRoutePlanSearchListener(onRoutePlanSearchListener: OnRoutePlanSearchListener): void;
    /**
     * 根据指定的参数来计算驾车路径。
     * @param drivePlanQuery 查询参数。
     * @throws AMapException
     * @since 1.0.0
     */
    calculateDrivePlan(drivePlanQuery: DrivePlanQuery): Promise<DriveRoutePlanResult | undefined>;
    /**
     * 异步处理。根据指定的参数来计算驾车路径的异步处理。
     * @param drivePlanQuery 查询参数。
     * @since 1.0.0
     */
    calculateDrivePlanAsyn(drivePlanQuery: DrivePlanQuery): void;
    /**
     * 根据指定的参数来计算骑行路径。
     * @param rideQuery 查询参数。
     * @throws AMapException
     * @since 1.0.0
     */
    calculateRideRoute(rideQuery: RideRouteQuery): Promise<RideRouteResult | undefined>;
    /**
     * 异步处理。根据指定的参数来计算骑行路径的异步处理。
     * @param rideQuery 查询参数。
     * @since 1.0.0
     */
    calculateRideRouteAsyn(rideQuery: RideRouteQuery): void;
    /**
     * 根据指定的参数来计算公交路径。只支持市内公交换乘。
     * @param busQuery 查询参数。
     * @throws AMapException
     * @since 1.0.0
     */
    calculateBusRoute(busQuery: BusRouteQuery): Promise<BusRouteResult | undefined>;
    /**
     * 异步处理。根据指定的参数来计算公交换乘路径的异步处理。只支持市内公交换乘。
     * @param busQuery 查询参数。
     * @since 1.0.0
     */
    calculateBusRouteAsyn(busQuery: BusRouteQuery): void;
    /**
     * 异步处理。根据指定的参数来计算货车路径的异步处理。
     * @param truckQuery 查询参数。
     * @since 1.0.1
     */
    calculateTruckRoute(truckQuery: TruckRouteQuery): Promise<TruckRouteRestult | undefined>;
    /**
     * 异步处理。根据指定的参数来计算货车路径的异步处理。
     * @param truckQuery 查询参数。
     * @since 1.0.1
     */
    calculateTruckRouteAsyn(truckQuery: TruckRouteQuery): void;
    /**
     *
     * @param onTruckRouteSearchListener
     * @since 1.0.1
     */
    setOnTruckRouteSearchListener(onTruckRouteSearchListener: OnTruckRouteSearchListener): void;
    /**
     * 根据指定的参数来计算公交路径。只支持市内公交换乘。
     * @param busQuery 查询参数。
     * @throws AMapException
     * @since 1.0.0
     */
    calculateBusRoute(busQuery: BusRouteQuery): Promise<BusRouteResult | undefined>;
}
