// @keepTs
// @ts-nocheck
import { Path } from './Path';
import ArrayList from "@ohos.util.ArrayList";
import { WalkStep } from './WalkStep';
/**
 * 定义了步行路径规划的一个方案。
 * @since V2.1.0
 */
export declare class WalkPath extends Path {
    private i67;
    /**
     * 返回步行方案的路段列表。
     * @return 路段列表。
     * @since V2.1.0
     */
    getSteps(): ArrayList<WalkStep>;
    /**
     * 设置步行方案的路段列表。
     * @param mSteps 路段列表。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    setSteps(d88: ArrayList<WalkStep>): void;
    /**
     * @exclude javadoc中不显示。
     */
    q2(): number;
    /**
     * WalkPath的构造方法。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    constructor();
}
