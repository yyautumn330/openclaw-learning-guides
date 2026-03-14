// @keepTs
// @ts-nocheck
import { DriveStep } from './DriveStep';
import { Path } from './Path';
import ArrayList from "@ohos.util.ArrayList";
/**
 * 定义了驾车路径规划的一个方案。
 * @since 1.0.0
 */
export declare class DrivePath extends Path {
    private u74?;
    private v74;
    private w74;
    private x74;
    private i67;
    private y74;
    /**
     * 返回导航策略，显示为中文，如返回“速度最快”。
     * @return 导航策略。
     * @since 1.0.0
     */
    getStrategy(): string;
    /**
     * 设置导航策略。
     * @param mStrategy 导航策略。
     * @since 1.0.0
     * @internal
     */
    q35(t74: string): void;
    /**
     * 返回此方案中的收费道路的总费用，单位元。
     * @return 此方案中的收费道路的总费用。
     * @since 1.0.0
     */
    getTolls(): number;
    /**
     * 设置此方案中的收费道路的总费用，单位元。
     * @param mTolls 此方案中的收费道路的总费用。
     * @since 1.0.0
     * @internal
     */
    setTolls(s74: number): void;
    /**
     * 返回此方案中的收费道路的总长度，单位米。
     * @return 此方案中的收费道路的总长度。
     * @since 1.0.0
     */
    getTollDistance(): number;
    /**
     * 设置此方案中的收费道路的总长度，单位米。
     * @param mTollDistance 此方案中的收费道路的总长度。
     * @since 1.0.0
     * @internal
     */
    setTollDistance(r74: number): void;
    /**
     * 返回此方案中的红绿灯个数。
     * @return 红绿灯个数。
     * @since 1.0.0
     */
    getTotalTrafficlights(): number;
    /**
     * 设置此方案中的红绿灯个数。
     * @param trafficLights 红绿灯数。
     * @internal
     */
    a36(q74: number): void;
    /**
     * 返回驾车规划方案的路段列表。
     * @return 驾车规划方案的路段列表。
     * @since 1.0.0
     */
    getSteps(): ArrayList<DriveStep>;
    /**
     * 设置驾车规划方案的路段列表。
     * @param mSteps 驾车规划方案的路段列表。
     * @since 1.0.0
     * @internal
     */
    setSteps(p74: ArrayList<DriveStep>): void;
    /**
     * 返回驾车规划方案的限行结果
     * @return 限行结果 0 代表限行已规避或未限行； 1 代表限行无法规避
     * @since 1.0.0
     */
    getRestriction(): number;
    /**
     * 设置驾车规划方案限行结果
     * @param restriction  0 代表限行已规避或未限行； 1 代表限行无法规避
     * @since 1.0.0
     */
    setRestriction(o74: number): void;
    /**
     * DrivePath的构造方法。
     * @since 1.0.0
     * @internal
     */
    constructor();
}
