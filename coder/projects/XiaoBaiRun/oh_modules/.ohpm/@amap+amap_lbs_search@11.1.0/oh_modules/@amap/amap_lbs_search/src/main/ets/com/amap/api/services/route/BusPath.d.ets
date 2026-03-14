// @keepTs
// @ts-nocheck
import ArrayList from "@ohos.util.ArrayList";
import { BusStep } from "./BusStep";
import { Path } from './Path';
/**
 * 定义了公交换乘路径规划的一个方案。
 * @since V2.1.0
 */
export declare class BusPath extends Path {
    private f61?;
    private f67?;
    private g67?;
    private h67?;
    private i67;
    /**
     * 返回公交换乘方案的花费，单位元。
     * @return 公交换乘方案的花费。
     * @since V2.1.0
     */
    getCost(): number;
    /**
     * 设置公交换乘方案的花费，单位元。
     * @param mCost 公交换乘方案的花费。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    setCost(e67: number): void;
    /**
     * 返回是否包含夜班车。
     * @return 是否包含夜班车。true，包含夜班车；false，不包含。
     * @since V2.1.0
     */
    isNightBus(): boolean;
    /**
     * 设置是否包含夜班车。
     * @param mNightBus 是否包含夜班车。true，包含夜班车；false，不包含。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    h33(d67: boolean): void;
    /**
     * 返回此方案的总步行距离，单位米。
     * @return 此方案的总步行距离。
     * @since V2.1.0
     */
    getWalkDistance(): number;
    /**
     * 设置此方案的总步行距离，单位米。
     * @param mWalkDistance 此方案的总步行距离。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    j33(c67: number): void;
    /**
     * 返回此方案的公交行驶的总距离 ，单位米。
     * @return 此方案的公交行驶的总距离。
     * @since V2.1.0
     */
    getBusDistance(): number;
    /**
     * 设置此方案的公交行驶的总距离 ，单位米。
     * @param mBusDistance 此方案的公交行驶的总距离。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    l33(b67: number): void;
    /**
     * 返回公交路径规划方案的路段列表。
     * @return 公交路径规划方案的路段列表。
     * @since V2.1.0
     */
    getSteps(): ArrayList<BusStep>;
    /**
     * 设置公交路径规划方案的路段列表。
     * @param mSteps 公交路径规划方案的路段列表。
     * @since V2.1.0
     */
    setSteps(a67: ArrayList<BusStep>): void;
    /**
     * @exclude javadoc中不显示。
     */
    q2(): number;
    /**
     * BusPath的构造方法。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    constructor();
}
