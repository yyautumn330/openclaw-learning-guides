// @keepTs
// @ts-nocheck
import { t14 } from "./ChargeStationInfo";
import { Cost } from "./Cost";
import { DriveStepV2 } from "./DriveStepV2";
import { s14 } from "./ElecConsumeInfo";
import { Path } from "./Path";
import ArrayList from "@ohos.util.ArrayList";
/**
 * 定义了驾车路径规划的一个方案。
 * @since 1.0.0
 */
export declare class DrivePathV2 extends Path {
    private u74?;
    private i67;
    private y74;
    private cost?;
    private f75?;
    private g75;
    /**
     * 获取电量消耗信息
     *
     * @internal
     *
     * @return
     */
    h75(): s14;
    /**
     * 设置电量消耗信息
     *
     * @internal
     *
     * @param elecConsumeInfo
     */
    s35(e75: s14): void;
    /**
     * 获取充电站信息
     *
     * @internal
     *
     * @return
     */
    i75(): ArrayList<t14>;
    /**
     *
     * 设置充电站信息
     *
     * @internal
     *
     * @param chargeStationInfo
     */
    u35(d75: ArrayList<t14>): void;
    /**
     *
     * 获取方案所需时间及费用成本
     *
     * @return
     */
    getCost(): Cost;
    /**
     *
     * 设置方案所需时间及费用成本
     *
     * @param cost
     */
    setCost(c75: Cost): void;
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
     * @internal。
     */
    q35(b75: string): void;
    /**
     * 返回驾车规划方案的路段列表。
     * @return 驾车规划方案的路段列表。
     * @since 1.0.0
     */
    getSteps(): ArrayList<DriveStepV2>;
    /**
     * 设置驾车规划方案的路段列表。
     * @param mSteps 驾车规划方案的路段列表。
     * @since 1.0.0
     * @internal。
     */
    setSteps(a75: ArrayList<DriveStepV2>): void;
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
    setRestriction(z74: number): void;
}
