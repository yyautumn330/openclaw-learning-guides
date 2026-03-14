// @keepTs
// @ts-nocheck
import { DriveRoutePlanResult } from "./DriveRoutePlanResult";
/**
 * 未来路径规划回调方法
 *
 * @since 6.9.0
 */
export interface OnRoutePlanSearchListener {
    /**
     * 货车路径规划回调方法
     *
     * @param routePlanResult  驾车路径未来规划的结果集。
     * @param errorCode        返回结果成功或者失败的响应码。1000为成功，其他为失败（详细信息参见网站开发指南-错误码对照表）。
     * @since 6.9.0
     */
    onDriveRoutePlanSearched: (routePlanResult: DriveRoutePlanResult | undefined, errorCode: number) => void;
}
