// @keepTs
// @ts-nocheck
import { DrivePlanStep } from "./DrivePlanStep";
import ArrayList from "@ohos.util.ArrayList";
export declare class DrivePlanPath {
    m54: number;
    k75: number;
    private i67;
    /**
     * 返回行驶距离，单位：米。
     * @return 行驶距离。
     * @since V6.9.0
     */
    getDistance(): number;
    /**
     * 设置行驶距离，单位：米。
     * @param distance 行驶距离。
     * @since V6.9.0
     * @exclude javadoc中不显示。
     */
    setDistance(distance: number): void;
    /**
     * 返回红绿灯个数。
     * @return 红绿灯个数。
     * @since V6.9.0
     */
    getTrafficLights(): number;
    /**
     * 设置红绿灯个数。
     * @param trafficLights 红绿灯个数。
     * @since V6.9.0
     * @exclude javadoc中不显示。
     */
    setTrafficLights(j75: number): void;
    /**
     * 返回导航路段。
     * @return 导航路段。
     * @since V6.9.0
     */
    getSteps(): ArrayList<DrivePlanStep>;
    /**
     * 设置导航路段。
     * @return 导航路段。
     * @since V6.9.0
     */
    setSteps(steps: ArrayList<DrivePlanStep>): void;
}
