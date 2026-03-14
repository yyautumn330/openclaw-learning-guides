// @keepTs
// @ts-nocheck
import { BusRouteResultV2 } from "./BusRouteResultV2";
import { DriveRouteResultV2 } from "./DriveRouteResultV2";
import { RideRouteResultV2 } from "./RideRouteResultV2";
import { WalkRouteResultV2 } from "./WalkRouteResultV2";
export interface OnRouteSearchListenerV2 {
    /**
     * 驾车路径规划结果的回调方法。
     *
     * @param driveRouteResult 驾车路径规划的结果集。
     * @param errorCode        返回结果成功或者失败的响应码。1000为成功(V3.2.1之后搜索成功响应码为1000，之前版本为0)，其他为失败（详细信息参见网站开发指南-错误码对照表）。
     * @since 1.0.0
     */
    onDriveRouteSearched: (driveRouteResult: DriveRouteResultV2, errorCode: number) => void;
    /**
     * 步行路径规划结果的回调方法。
     *
     * @param walkRouteResult 步行路径规划的结果集。
     * @param errorCode       返回结果成功或者失败的响应码。1000为成功(V3.2.1之后搜索成功响应码为1000，之前版本为0)，其他为失败（详细信息参见网站开发指南-错误码对照表）。
     * @since 1.0.0
     */
    onWalkRouteSearched: (walkRouteResult: WalkRouteResultV2, errorCode: number) => void;
    /**
     * 骑行路径规划结果的回调方法。
     *
     * @param rideRouteResult 骑行路径规划的结果集。
     * @param errorCode       返回结果成功或者失败的响应码。1000为成功，其他为失败（详细信息参见网站开发指南-错误码对照表）。
     * @since 1.0.0
     */
    onRideRouteSearched: (rideRouteResult: RideRouteResultV2, errorCode: number) => void;
    /**
     * 公交换乘路径规划结果的回调方法。
     *
     * @param busRouteResult 公交路径规划的结果集。
     * @param errorCode      返回结果成功或者失败的响应码。1000为成功(V3.2.1之后搜索成功响应码为1000，之前版本为0)，其他为失败（详细信息参见网站开发指南-错误码对照表）。
     * @since V9.4.0
     */
    onBusRouteSearched: (busRouteResult: BusRouteResultV2, errorCode: number) => void;
}
