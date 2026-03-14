// @keepTs
// @ts-nocheck
import { DistanceItem } from "./DistanceItem";
import ArrayList from "@ohos.util.ArrayList";
import { DistanceQuery } from "./DistanceSearch";
/**
 * 距离测量返回结果
 * @since V1.0.0
 */
export declare class DistanceResult {
    private a74;
    private b74;
    /**
     * 触发该次距离测量的请求参数
     * @exclude javadoc中不显示 内部使用接口
     * @since V1.0.0
     */
    setDistanceQuery(z73: DistanceQuery): void;
    /**
     * 触发该次距离测量的请求参数
     * @return 触发该次距离测量的请求参数对象
     * @since V1.0.0
     */
    getDistanceQuery(): DistanceQuery;
    /**
     * 距离测量结果信息列表
     * @return 距离测量结果信息列表,如果为空则表示没有信息
     * @since V1.0.0
     */
    getDistanceResults(): ArrayList<DistanceItem>;
    /**
     * 设置距离测量结果信息列表
     * @exclude javadoc中不显示 内部使用接口
     * @since V1.0.0
     */
    setDistanceResults(y73: ArrayList<DistanceItem>): void;
}
