// @keepTs
// @ts-nocheck
import { FromAndTo } from "./FromAndTo";
import { LatLonPoint } from "../core/LatLonPoint";
import { y76 } from "./NewEnergy";
import { DrivingStrategy } from "./DrivingStrategy";
import ArrayList from "@ohos.util.ArrayList";
/**
 * 此类定义了驾车路径查询规划。
 *
 * @since 1.0.0
 */
export declare class DriveRouteQueryV2 {
    private s67;
    private o77?;
    private t67;
    private t76?;
    private u76?;
    private v76;
    /**
     * 轮渡
     */
    private w76;
    /**
     * 车辆类型, 默认为普通汽车
     */
    private r75;
    /**
     * 网约车模式, 默认为非网约车模式
     */
    /**
     * 规避道路类型，可选值：toll-收费道路；motorway-高速路；ferry-渡船 默认无
     */
    private x76;
    /**
     * 扩展字段 {@link ShowFields}
     * 默认 cost
     */
    private p77;
    /**
     * DriveRouteQuery构造函数。
     *
     * @param fromAndTo             路径的起点终点。
     * @param mode                  计算路径的模式。可选，默认为速度优先 {@link DrivingStrategy}。
     * @param passedByPoints        途经点，可选。最多支持6个途经点。
     * @param avoidpolygons         避让区域，可选。区域避让，支持32个避让区域，每个区域最多可有16个顶点。如果是四边形则有4个坐标点，如果是五边形则有5个坐标点。同时传入避让区域及避让道路，仅支持避让道路。
     * @param avoidRoad             避让道路名称，可选。目前只支持一条避让道路。
     * @since 1.0.0
     */
    constructor(k77: FromAndTo, mode: number, l77: ArrayList<LatLonPoint> | undefined, m77: ArrayList<ArrayList<LatLonPoint>> | undefined, n77: string);
    getNewEnergy(): y76;
    setNewEnergy(j77: y76 | undefined): void;
    /**
     * 返回查询路径的起终点。
     *
     * @return 查询路径的起终点。
     * @since 1.0.0
     */
    getFromAndTo(): FromAndTo;
    /**
     * 返回计算路径的模式。
     *
     * @return 计算路径的模式。
     * @since 1.0.0
     */
    getMode(): DrivingStrategy;
    /**
     * 返回车辆类型。
     *
     * @return 车辆类型。
     * @since 6.9.0
     */
    getCarType(): number;
    /**
     * 返回网约车模式。
     *
     * @return 网约车模式。
     * @exclude javadoc中不显示。
     * @since 6.7.0
     */
    /**
     * 返回设定查询的途经点。
     *
     * @return 设定查询的途经点。
     * @since 1.0.0
     */
    getPassedByPoints(): ArrayList<LatLonPoint>;
    /**
     * 返回设定查询的避让区域。
     *
     * @return 设定查询的避让区域。
     * @since 1.0.0
     */
    getAvoidpolygons(): ArrayList<ArrayList<LatLonPoint>>;
    /**
     * 返回设定查询的避让道路。
     *
     * @return 设定查询的避让道路。
     * @since 1.0.0
     */
    getAvoidRoad(): string;
    /**
     * @exclude javadoc中不显示。
     */
    r13(): boolean;
    /**
     * 将途径点位置坐标转换为字符串输出。
     *
     * @return 途径点坐标的字符串
     * @since 1.0.0
     */
    getPassedPointStr(): string;
    /**
     * 将避让区域转换为字符串输出。
     *
     * @return 避让区域坐标的字符串。
     * @since 1.0.0
     */
    getAvoidpolygonsStr(): string;
    /**
     * @exclude javadoc中不显示。
     */
    s13(): boolean;
    /**
     * @exclude javadoc中不显示。
     */
    t13(): boolean;
    /**
     * 海外生效
     * 规避道路类型，可选值：toll-收费道路；motorway-高速路；ferry-渡船，默认不规避
     * @since 7.4.0
     */
    getExclude(): string;
    /**
     * 海外生效
     * 规避道路类型，默认不规避
     * 可选值：
     * {@link #DRIVING_EXCLUDE_TOLL} toll-收费道路； <br>
     * {@link #DRIVING_EXCLUDE_MOTORWAY} motorway-高速路；<br>
     * {@link #DRIVING_EXCLUDE_FERRY} ferry-渡船;<br>
     * @since 7.4.0
     */
    setExclude(c77: string | undefined): void;
    /**
     * 扩展字段
     *
     * @return
     */
    getShowFields(): number;
    /**
     * 扩展字段 {@link ShowFields} 说明
     * @param showFields
     */
    setShowFields(b77: number): void;
    /**
     * @exclude javadoc中不显示。
     */
    clone(): DriveRouteQueryV2;
    /**
     * 是否使用轮渡，默认使用
     *
     * @since V6.5.0
     */
    isUseFerry(): boolean;
    /**
     * 是否使用轮渡，默认使用
     *
     * @param useFerry 使用轮渡，true
     * @since V6.5.0
     */
    setUseFerry(a77: boolean): void;
    /**
     * 设置车辆类型，默认为普通汽车
     *
     * @param carType 车辆类型,支持0：普通汽车，1：纯电动车，2：插电混动车
     * @since 6.9.0
     */
    setCarType(z76: number): void;
}
