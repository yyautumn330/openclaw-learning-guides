// @keepTs
// @ts-nocheck
import { Path } from './Path';
import ArrayList from "@ohos.util.ArrayList";
import { RideStep } from './RideStep';
/**
 * 定义了骑行路径规划的一个方案。
 * @since V1.0.0
 */
export declare class RidePath extends Path {
    private i67;
    /**
     * 返回骑行方案的路段列表。
     * @return 路段列表。
     * @since V1.0.0
     */
    getSteps(): ArrayList<RideStep>;
    /**
     * 设置骑行方案的路段列表。
     * @param steps 路段列表。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    setSteps(l82: ArrayList<RideStep>): void;
    constructor();
}
