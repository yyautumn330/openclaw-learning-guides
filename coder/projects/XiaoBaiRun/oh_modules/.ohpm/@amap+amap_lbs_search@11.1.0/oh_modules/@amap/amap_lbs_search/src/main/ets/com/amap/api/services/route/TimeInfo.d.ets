// @keepTs
// @ts-nocheck
import ArrayList from "@ohos.util.ArrayList";
import { TimeInfosElement } from "./TimeInfosElement";
export declare class TimeInfo {
    private g86;
    private h86;
    /**
     * 返回驾车未来路径规划开始时间。
     * @return 未来路径规划开始时间，Unix时间戳精确到秒
     * @since V6.9.0
     */
    getStartTime(): number;
    /**
     * 设置驾车未来路径规划开始时间。
     * @param startTime 未来路径规划开始时间，Unix时间戳精确到秒。
     * @since V6.9.0
     * @exclude javadoc中不显示。
     */
    e35(startTime: number): void;
    /**
     * 返回驾车未来路径不同时间的规划以及信息列表。
     * @return 不同时间的规划以及信息列表
     * @since V6.9.0
     */
    getElements(): ArrayList<TimeInfosElement>;
    /**
     * 设置驾车未来路径不同时间的规划以及信息列表。
     * @param elements 不同时间的规划以及信息列表。
     * @since V6.9.0
     * @exclude javadoc中不显示。
     */
    g35(elements: ArrayList<TimeInfosElement>): void;
}
