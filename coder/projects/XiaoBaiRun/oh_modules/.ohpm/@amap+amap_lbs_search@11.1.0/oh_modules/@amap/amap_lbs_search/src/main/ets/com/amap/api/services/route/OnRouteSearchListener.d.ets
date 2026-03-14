// @keepTs
// @ts-nocheck
import { BusRouteResult } from "./BusRouteResult";
import { DriveRouteResult } from "./DriveRouteResult";
import { RideRouteResult } from "./RideRouteResult";
import { WalkRouteResult } from "./WalkRouteResult";
export interface OnRouteSearchListener {
    /**
     * 驾车路径规划结果的回调方法。
     *
     * @param driveRouteResult 驾车路径规划的结果集。
     * @param errorCode        返回结果成功或者失败的响应码。1000为成功(V3.2.1之后搜索成功响应码为1000，之前版本为0)，其他为失败（详细信息参见网站开发指南-错误码对照表）。
     * @since 1.0.0
     */
    onDriveRouteSearched: (driveRouteResult: DriveRouteResult, errorCode: number) => void;
    /**
     * 骑行路径规划结果的回调方法。
     *
     * @param rideRouteResult 骑行路径规划的结果集。
     * @param errorCode       返回结果成功或者失败的响应码。1000为成功，其他为失败（详细信息参见网站开发指南-错误码对照表）。
     * @since V1.0.0
     */
    onRideRouteSearched: (rideRouteResult: RideRouteResult, errorCode: number) => void;
    /**
     * 步行路径规划结果的回调方法。
     *
     * @param walkRouteResult 步行路径规划的结果集。
     * @param errorCode       返回结果成功或者失败的响应码。1000为成功(V3.2.1之后搜索成功响应码为1000，之前版本为0)，其他为失败（详细信息参见网站开发指南-错误码对照表）。
     * @since 1.0.0
     */
    onWalkRouteSearched: (walkRouteResult: WalkRouteResult, errorCode: number) => void;
    /**
     * 公交换乘路径规划结果的回调方法。
     *
     * @param busRouteResult 公交路径规划的结果集。
     * @param errorCode      返回结果成功或者失败的响应码。1000为成功(V3.2.1之后搜索成功响应码为1000，之前版本为0)，其他为失败（详细信息参见网站开发指南-错误码对照表）。
     * @since 1.0.0
     */
    onBusRouteSearched: (busRouteResult: BusRouteResult, errorCode: number) => void;
}
