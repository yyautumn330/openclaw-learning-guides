// @keepTs
// @ts-nocheck
import ArrayList from "@ohos.util.ArrayList";
import { LatLonPoint } from "../core/LatLonPoint";
import { RouteSearchCity } from "./RouteSearchCity";
import { TMC } from "./TMC";
/**
 * 定义了货车路径规划的一个路段。
 *
 * @since 1.0.1
 */
export declare class TruckStep {
    private instruction?;
    private orientation?;
    private a88?;
    private s71;
    private distance;
    private q71;
    private r71?;
    private duration;
    private polyline;
    private action?;
    private e80?;
    private b88;
    private c88;
    /**
     * @internal
     */
    y32(instruction: string): void;
    /**
     * @internal
     */
    setOrientation(orientation: string): void;
    /**
     * @internal
     */
    z32(z87: string): void;
    /**
     * @internal
     */
    setTolls(y87: number): void;
    /**
     * @internal
     */
    setDistance(distance: number): void;
    /**
     * @internal
     */
    setTollDistance(x87: number): void;
    /**
     * @internal
     */
    setTollRoad(w87: string): void;
    /**
     * @internal
     */
    setDuration(duration: number): void;
    /**
     * @internal
     */
    setPolyline(polyline: ArrayList<LatLonPoint>): void;
    /**
     * @internal
     */
    setAction(action: string): void;
    /**
     * @internal
     */
    setAssistantAction(v87: string): void;
    /**
     * @internal
     */
    n35(u87: ArrayList<RouteSearchCity>): void;
    /**
     * @internal
     */
    setTMCs(t87: ArrayList<TMC>): void;
    /**
     * 行驶指示	例如：沿火器营路向南行驶112米左转
     * @return 行驶指示	例如：沿火器营路向南行驶112米左转
     * @since 1.0.1
     */
    getInstruction(): string;
    /**
     * 方向	例如：南
     * @return 方向	例如：南
     * @since 1.0.1
     */
    getOrientation(): string;
    /**
     * 道路名称	例如：火器营路
     * @return 道路名称	例如：火器营路
     * @since 1.0.1
     */
    getRoad(): string;
    /**
     * 此段收费	单位：元
     * @return 此段收费	单位：元
     * @since 1.0.1
     */
    getTolls(): number;
    /**
     * 此路段距离	单位：米
     * @return 此路段距离	单位：米
     * @since 1.0.1
     */
    getDistance(): number;
    /**
     * 收费路段距离	单位：米
     * @return 收费路段距离	单位：米
     * @since 1.0.1
     */
    getTollDistance(): number;
    /**
     * 主要收费道路
     * @return 主要收费道路
     * @since 1.0.1
     */
    getTollRoad(): string;
    /**
     * 此路段预计时间
     * @return 此路段预计时间
     * @since 1.0.1
     */
    getDuration(): number;
    /**
     * 此路段坐标点串 存放到 List中
     * @return 此路段坐标点串
     * @since 1.0.1
     */
    getPolyline(): ArrayList<LatLonPoint>;
    /**
     *  导航主要动作<br>
     *  例如：左转 <br>
     * 目前已知会有如下动作：<br>
     * 左转、右转、
     * 向左前方行驶、向右前方行驶、向左后方行驶、向右后方行驶、
     * 直行、靠左、靠右、
     * 进入环岛、离开环岛、
     * 减速行驶、插入直行
     * @return 导航主要动作
     * @since 1.0.1
     */
    getAction(): string;
    /**
     * 列表参见 {@link #getAction()}
     * @return 导航辅助动作
     * @since 1.0.1
     */
    getAssistantAction(): string;
    /**
     * 途径城市列表
     * @return 途径城市列表
     * @since 1.0.1
     */
    getRouteSearchCityList(): ArrayList<RouteSearchCity>;
    /**
     * 获取搜索返回的路径规划交通拥堵信息。
     * @return 交通拥堵信息。
     * @since 1.0.1
     */
    getTMCs(): ArrayList<TMC>;
}
