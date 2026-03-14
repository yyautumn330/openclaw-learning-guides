// @keepTs
// @ts-nocheck
import { LatLonPoint } from "../core/LatLonPoint";
import ArrayList from "@ohos.util.ArrayList";
/**
 * 定义了骑行路径规划的一个路段。
 * @since V1.0.0
 */
export declare class RideStep {
    private l78?;
    private m78?;
    private w75?;
    private m54;
    private o78;
    private y75?;
    private p78?;
    private q78?;
    private h83;
    /**
     * 返回骑行路段的行进指示。
     * @return 骑行路段的行进指示。
     * @since V1.0.0
     */
    getInstruction(): string;
    /**
     * 设置骑行路段的行进指示。
     * @param instruction 骑行路段的行进指示。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    y32(instruction: string): void;
    /**
     * 返回骑行路段的行进方向，方向为中文名称，如东、西南等。
     * @return 骑行路段的行进方向。
     * @since V1.0.0
     */
    getOrientation(): string;
    /**
     * 设置骑行路段的行进方向。
     * @param orientation 骑行路段的行进方向。方向为中文名称，如东、西南等。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    setOrientation(g83: string): void;
    /**
     * 返回骑行路段的道路名称。
     * @return 骑行路段的道路名称。
     * @since V1.0.0
     */
    getRoad(): string;
    /**
     * 设置骑行路段的道路名称。
     * @param road 骑行路段的道路名称。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    z32(f83: string): void;
    /**
     * 返回骑行路段的距离，单位米。
     * @return 骑行路段的距离。
     * @since V1.0.0
     */
    getDistance(): number;
    /**
     * 设置骑行路段的距离，单位米。
     * @param distance 骑行路段的距离。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    setDistance(e83: number): void;
    /**
     * 返回骑行路段的预计时间，单位为秒。时间根据当时路况估算。
     * @return 骑行路段的预计时间。
     * @since V1.0.0
     */
    getDuration(): number;
    /**
     * 设置骑行路段的预计时间，单位为秒。
     * @param duration 骑行路段的预计时间。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    setDuration(d83: number): void;
    /**
     * 返回骑行路段的坐标点集合。
     * @return 骑行路段的坐标点集合。
     * @since V1.0.0
     */
    getPolyline(): ArrayList<LatLonPoint>;
    /**
     * 设置骑行路段的坐标点集合。
     * @param polyline 骑行路段的坐标点集合。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    setPolyline(c83?: ArrayList<LatLonPoint>): void;
    /**
     * 返回骑行路段的导航主要操作。
     * @return 骑行路段的导航主要操作。
     * @since V1.0.0
     */
    getAction(): string;
    /**
     * 设置骑行路段的导航主要操作。
     * @param action 骑行路段的导航主要操作。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    setAction(b83: string): void;
    /**
     * 返回骑车路段的导航辅助操作。
     * @return 步行路段的导航辅助操作。
     * @since V1.0.0
     */
    getAssistantAction(): string;
    /**
     * 设置骑车路段的导航辅助操作。
     * @param mAssistantAction 步行路段的导航辅助操作。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    setAssistantAction(a83: string): void;
    getRoadType(): number;
    setRoadType(z82: number): void;
}
