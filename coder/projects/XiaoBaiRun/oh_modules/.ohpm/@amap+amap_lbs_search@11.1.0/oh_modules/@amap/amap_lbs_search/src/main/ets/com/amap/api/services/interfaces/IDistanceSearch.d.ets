// @keepTs
// @ts-nocheck
import { DistanceResult } from "../route/DistanceResult";
import { DistanceQuery, OnDistanceSearchListener } from "../route/DistanceSearch";
/**
 * 距离测量
 * 0：直线距离
 * 1：驾车导航距离（仅支持国内坐标）。
 * 必须指出，当为1时会考虑路况，故在不同时间请求返回结果可能不同。
 * 此策略和driving接口的 strategy=4策略一致
 * 2：公交规划距离（仅支持同城坐标,QPS不可超过1，否则可能导致意外）
 * 3：步行规划距离（仅支持5km之间的距离）
 */
export interface n60 {
    /**
     * 测量距离请求接口，调用后会发起距离测量请求。
     * 该接口为同步接口，由于带有网络操作需要在子线程中调用。
     * @param query 请求参数
     * @return 距离测量结果
     */
    calculateRouteDistance(query: DistanceQuery): Promise<DistanceResult | undefined>;
    /**
     * 测量距离请求接口，调用后会发起距离测量请求。
     * 该接口为同步接口，由于带有网络操作需要在子线程中调用。
     * @param query 请求参数
     * @return 距离测量结果
     */
    calculateRouteDistanceAsyn(query: DistanceQuery): void;
    /**
     * 设置距离测量异步请求监听回调
     * @param listener 监听回到实现
     */
    setDistanceSearchListener(listener: OnDistanceSearchListener): void;
}
