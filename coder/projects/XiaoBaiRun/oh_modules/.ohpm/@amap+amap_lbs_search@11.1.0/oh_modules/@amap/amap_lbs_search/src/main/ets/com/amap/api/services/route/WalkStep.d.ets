// @keepTs
// @ts-nocheck
import { LatLonPoint } from "../core/LatLonPoint";
import ArrayList from "@ohos.util.ArrayList";
/**
 * 定义了步行路径规划的一个路段。
 * @since V2.1.0
 */
export declare class WalkStep {
    private l78?;
    private m78?;
    private w75?;
    private m54;
    private o78;
    private y75;
    private p78?;
    private q78?;
    private h83;
    /**
     * 返回步行路段的行进指示。
     * @return 步行路段的行进指示。
     * @since V2.1.0
     */
    getInstruction(): string;
    /**
     * 设置步行路段的行进指示。
     * @param mInstruction 步行路段的行进指示。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    y32(z88: string): void;
    /**
     * 返回步行路段的行进方向，方向为中文名称，如东、西南等。
     * @return 步行路段的行进方向。
     * @since V2.1.0
     */
    getOrientation(): string;
    /**
     * 设置步行路段的行进方向。
     * @param mOrientation 步行路段的行进方向。方向为中文名称，如东、西南等。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    setOrientation(y88: string): void;
    /**
     * 返回步行路段的道路名称。
     * @return 步行路段的道路名称。
     * @since V2.1.0
     */
    getRoad(): string;
    /**
     * 设置步行路段的道路名称。
     * @param mRoad 步行路段的道路名称。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    z32(x88: string): void;
    /**
     * 返回步行路段的距离，单位米。
     * @return 步行路段的距离。
     * @since V2.1.0
     */
    getDistance(): number;
    /**
     * 设置步行路段的距离，单位米。
     * @param mDistance 步行路段的距离。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    setDistance(w88: number): void;
    /**
     * 返回步行路段的预计时间，单位为秒。时间根据当时路况估算。
     * @return 步行路段的预计时间。
     * @since V2.1.0
     */
    getDuration(): number;
    /**
     * 设置步行路段的预计时间，单位为秒。应考虑实时路况。
     * @param mDuration 步行路段的预计时间。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    setDuration(v88: number): void;
    /**
     * 返回步行路段的坐标点集合。
     * @return 步行路段的坐标点集合。
     * @since V2.1.0
     */
    getPolyline(): ArrayList<LatLonPoint>;
    /**
     * 设置步行路段的坐标点集合。
     * @param mPolyline 步行路段的坐标点集合。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    setPolyline(u88: ArrayList<LatLonPoint>): void;
    /**
     * 返回步行路段的导航主要操作。
     * @return 步行路段的导航主要操作。
     * @since V2.1.0
     */
    getAction(): string;
    /**
     * 设置步行路段的导航主要操作。
     * @param mAction 步行路段的导航主要操作。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    setAction(t88: string): void;
    /**
     * 返回步行路段的导航辅助操作。
     * @return 步行路段的导航辅助操作。
     * @since V2.1.0
     */
    getAssistantAction(): string;
    /**
     * 设置步行路段的导航辅助操作。
     * @param mAssistantAction 步行路段的导航辅助操作。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    setAssistantAction(s88: string): void;
    /**
     * 0，普通道路 1，人行横道 3，地下通道 4，过街天桥
     *
     * 5，地铁通道 6，公园 7，广场 8，扶梯 9，直梯
     *
     * 10，索道 11，空中通道 12，建筑物穿越通道
     *
     * 13，行人通道 14，游船路线 15，观光车路线 16，滑道
     *
     * 18，扩路 19，道路附属连接线 20，阶梯 21，斜坡
     *
     * 22，桥 23，隧道 30，轮渡
     */
    getRoadType(): number;
    /**
     * 0，普通道路 1，人行横道 3，地下通道 4，过街天桥
     *
     * 5，地铁通道 6，公园 7，广场 8，扶梯 9，直梯
     *
     * 10，索道 11，空中通道 12，建筑物穿越通道
     *
     * 13，行人通道 14，游船路线 15，观光车路线 16，滑道
     *
     * 18，扩路 19，道路附属连接线 20，阶梯 21，斜坡
     *
     * 22，桥 23，隧道 30，轮渡
     */
    setRoadType(r88: number): void;
    /**
     * @exclude javadoc中不显示。
     */
    q2(): number;
    /**
     * WalkStep的构造方法。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    constructor();
}
