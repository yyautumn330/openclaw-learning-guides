// @keepTs
// @ts-nocheck
import { TruckRouteRestult } from "./TruckRouteRestult";
/**
 * 货车路径规划回调方法
 *
 * @since 1.0.1
 */
export interface OnTruckRouteSearchListener {
    /**
     * 货车路径规划回调方法
     *
     * @param truckRouteResult 货车路径规划的结果集。
     * @param errorCode        返回结果成功或者失败的响应码。1000为成功，其他为失败（详细信息参见网站开发指南-错误码对照表）。
     * @since 1.0.1
     */
    onTruckRouteSearched: (truckRouteResult: TruckRouteRestult, errorCode: number) => void;
}
