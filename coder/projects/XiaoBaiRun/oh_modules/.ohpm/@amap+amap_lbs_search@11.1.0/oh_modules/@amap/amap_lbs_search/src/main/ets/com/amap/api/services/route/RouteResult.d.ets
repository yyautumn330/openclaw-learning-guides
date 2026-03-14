// @keepTs
// @ts-nocheck
import { LatLonPoint } from "../core/LatLonPoint";
/**
 * 定义了路径规划的结果集。
 * @since 1.0.0
 */
export declare class RouteResult {
    private y83?;
    private z83?;
    /**
     * 返回路径规划起点的位置。
     * @return 起点的位置坐标。
     * @since 1.0.0
     */
    getStartPos(): LatLonPoint;
    /**
     * 设置路径规划起点的位置。
     * @param mStartPos 起点的位置坐标。
     * @since 1.0.0
     * @internal
     */
    s32(n84?: LatLonPoint): void;
    /**
     * 返回路径规划终点的位置。
     * @return 终点的位置坐标。
     * @since 1.0.0
     */
    getTargetPos(): LatLonPoint;
    /**
     * 设置路径规划终点的位置
     * @param mTargetPos 终点的位置坐标
     * @since 1.0.0
     * @internal
     */
    u32(m84?: LatLonPoint): void;
}
