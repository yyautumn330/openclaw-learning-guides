// @keepTs
// @ts-nocheck
import ArrayList from "@ohos.util.ArrayList";
import { Path } from './Path';
import { TruckStep } from "./TruckStep";
/**
 * 定义了货车路径规划的一个方案。
 *
 * @since 1.0.1
 */
export declare class TruckPath extends Path {
    private distance;
    private duration;
    private strategy?;
    private s71;
    private q71;
    private u86;
    private v86;
    private steps;
    /**
     * @internal
     */
    setDistance(distance: number): void;
    /**
     * @internal
     */
    setDuration(duration: number): void;
    /**
     * @internal
     */
    q35(strategy: string): void;
    /**
     * @internal
     */
    setTolls(t86: number): void;
    /**
     * @internal
     */
    setTollDistance(s86: number): void;
    /**
     * @internal
     */
    a36(r86: number): void;
    /**
     * @internal
     */
    setRestriction(q86: number): void;
    /**
     * @internal
     */
    setSteps(steps: ArrayList<TruckStep>): void;
    /**
     * 此方案的行驶距离	单位：米
     * @return 此方案的行驶距离	单位：米
     * @since 1.0.1
     */
    getDistance(): number;
    /**
     * 此方案的耗时	单位：秒
     * @return 此方案的耗时	单位：秒
     * @since 1.0.1
     */
    getDuration(): number;
    /**
     * 此方案的路径规划模式
     * @return 此方案路径规划模式
     * @since 1.0.1
     */
    getStrategy(): string;
    /**
     * 此导航方案道路收费金额 单位：元
     * @return 此导航方案道路收费金额 单位：元
     * @since 1.0.1
     */
    getTolls(): number;
    /**
     * 此导航方案道路收费距离长度	单位：米
     * @return 此导航方案道路收费距离长度	单位：米
     * @since 1.0.1
     */
    getTollDistance(): number;
    /**
     * 此方案红绿灯总数	单位：个
     * @return 此方案红绿灯总数	单位：个
     * @since 1.0.1
     */
    getTotalTrafficlights(): number;
    /**
     * 限行结果
     * 0，未知（未输入完整/正确车牌号信息时候显示）
     * 1，已规避限行
     * 2，起点限行
     * 3，途径点在限行区域内（设置途径点才出现此报错）
     * 4，途径限行区域
     * 5，终点限行
     * @return 限行结果
     * @since 1.0.1
     */
    getRestriction(): number;
    /**
     * 具体的方案细节
     * @return 具体的方案
     * @since 1.0.1
     */
    getSteps(): ArrayList<TruckStep>;
}
