// @keepTs
// @ts-nocheck
import { t60 } from "../interfaces/IRouteSearchV2";
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
export declare class f85 implements t60 {
    private static readonly v44;
    private listener?;
    private context;
    private r90;
    /**
     * 根据给定的参数来构造一个RouteSearch的新对象。
     * @param context 对应的Context。
     * @since V2.1.0
     */
    constructor(context: Context);
    setRouteSearchListener(listener: OnRouteSearchListenerV2): void;
    calculateBusRoute(v94: BusRouteQueryV2): Promise<BusRouteResultV2>;
    calculateBusRouteAsyn(t94: BusRouteQueryV2): void;
    calculateWalkRoute(s94: WalkRouteQueryV2): Promise<WalkRouteResultV2>;
    calculateWalkRouteAsyn(q94: WalkRouteQueryV2): void;
    calculateDriveRoute(p94: DriveRouteQueryV2): Promise<DriveRouteResultV2 | undefined>;
    calculateDriveRouteAsyn(n94: DriveRouteQueryV2): void;
    private i94;
    /**
     * 根据指定的参数来计算骑行路径。
     * @param rideQuery 查询参数。
     * @throws AMapException
     * @since V9.4.0
     */
    calculateRideRoute(l94: RideRouteQueryV2): Promise<RideRouteResultV2 | undefined>;
    /**
     * 异步处理。根据指定的参数来计算骑行路径的异步处理。
     * @param rideQuery 查询参数。
     * @since V3,5.0
     */
    calculateRideRouteAsyn(j94: RideRouteQueryV2): void;
}
