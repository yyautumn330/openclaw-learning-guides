// @keepTs
// @ts-nocheck
import { s60 } from "../interfaces/IRouteSearch";
import { DriveRouteQuery } from "../route/DriveRouteQuery";
import { DriveRouteResult } from "../route/DriveRouteResult";
import { OnRouteSearchListener } from "../route/OnRouteSearchListener";
import { DrivePlanQuery } from "../route/DrivePlanQuery";
import { OnRoutePlanSearchListener } from "../route/OnRoutePlanSearchListener";
import { DriveRoutePlanResult } from "../route/DriveRoutePlanResult";
import { RideRouteQuery } from "../route/RideRouteQuery";
import { RideRouteResult } from "../route/RideRouteResult";
import { WalkRouteQuery } from "../route/WalkRouteQuery";
import { WalkRouteResult } from "../route/WalkRouteResult";
import { BusRouteQuery } from "../route/BusRouteQuery";
import { TruckRouteQuery } from "../route/TruckRouteQuery";
import { TruckRouteRestult } from "../route/TruckRouteRestult";
import { OnTruckRouteSearchListener } from "../route/OnTruckRouteSearchListener";
import { BusRouteResult } from "../route/BusRouteResult";
export declare class o84 implements s60 {
    private static readonly v44;
    private listener?;
    private g94?;
    private context;
    private r90;
    private h94?;
    /**
     * 根据给定的参数来构造一个RouteSearch的新对象。
     * @param context 对应的Context。
     * @since V2.1.0
     */
    constructor(context: Context);
    setOnRoutePlanSearchListener(e94: OnRoutePlanSearchListener): void;
    calculateDrivePlan(d94: DrivePlanQuery): Promise<DriveRoutePlanResult | undefined>;
    calculateDrivePlanAsyn(b94: DrivePlanQuery): void;
    setRouteSearchListener(listener: OnRouteSearchListener): void;
    /**
     * 根据指定的参数来计算公交路径。只支持市内公交换乘。
     * @param busQuery 查询参数。
     * @throws AMapException
     * @since V2.1.0
     */
    calculateBusRoute(a94: BusRouteQuery): Promise<BusRouteResult>;
    calculateBusRouteAsyn(y93: BusRouteQuery): void;
    calculateWalkRoute(x93: WalkRouteQuery): Promise<WalkRouteResult | undefined>;
    calculateWalkRouteAsyn(v93: WalkRouteQuery): void;
    calculateDriveRoute(u93: DriveRouteQuery): Promise<DriveRouteResult | undefined>;
    calculateDriveRouteAsyn(s93: DriveRouteQuery): void;
    private i94;
    /**
     * 异步处理。根据指定的参数来计算骑行路径的异步处理。
     * @param rideQuery 查询参数。
     * @since V3,5.0
     */
    calculateRideRouteAsyn(p93: RideRouteQuery): void;
    /**
     * 根据指定的参数来计算骑行路径。
     * @param rideQuery 查询参数。
     * @throws AMapException
     * @since V3.5.0
     */
    calculateRideRoute(o93: RideRouteQuery): Promise<RideRouteResult>;
    /**
     * 路径货车搜索结果监听接口设置。
     *
     * @param onTruckRouteSearchListener 货车路径搜索结果监听接口。
     * @since 1.0.1
     */
    setOnTruckRouteSearchListener(n93: OnTruckRouteSearchListener): void;
    /**
     * 根据指定的参数来计算货车路径。
     *
     * @param truckQuery 查询参数。
     * @throws AMapException 途经点太多会返回非法参数
     * @since 1.0.1
     */
    calculateTruckRoute(m93: TruckRouteQuery): Promise<TruckRouteRestult | undefined>;
    /**
     * 异步处理。根据指定的参数来计算货车路径的异步处理。
     *
     * @param truckQuery 查询参数。
     * @since 1.0.1
     */
    calculateTruckRouteAsyn(l93: TruckRouteQuery): void;
}
