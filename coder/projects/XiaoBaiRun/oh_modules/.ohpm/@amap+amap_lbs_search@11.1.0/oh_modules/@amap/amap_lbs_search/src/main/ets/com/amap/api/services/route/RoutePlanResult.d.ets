// @keepTs
// @ts-nocheck
import { LatLonPoint } from "../core/LatLonPoint";
export declare class RoutePlanResult {
    private y83?;
    private z83?;
    /**
     * 返回路径规划起点的位置。
     * @return 起点的位置坐标。
     * @since V6.9.0
     */
    getStartPos(): LatLonPoint;
    /**
     * 设置路径规划起点的位置。
     * @param mStartPos 起点的位置坐标。
     * @since V6.9.0
     * @exclude javadoc中不显示。
     */
    s32(x83: LatLonPoint): void;
    /**
     * 返回路径规划终点的位置。
     * @return 终点的位置坐标。
     * @since V6.9.0
     */
    getTargetPos(): LatLonPoint;
    /**
     * 设置路径规划终点的位置
     * @param mTargetPos 终点的位置坐标
     * @since V6.9.0
     * @exclude javadoc中不显示。
     */
    u32(w83: LatLonPoint): void;
}
