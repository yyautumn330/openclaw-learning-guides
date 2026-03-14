// @keepTs
// @ts-nocheck
import { FromAndTo } from "./FromAndTo";
import ArrayList from "@ohos.util.ArrayList";
import { LatLonPoint } from "../core/LatLonPoint";
/**
 * 此类定义了货车路径的起终点和计算路径的模式。
 *
 * @since 1.0.1
 */
export declare class TruckRouteQuery {
    private p75;
    private h87;
    private mode;
    private t76;
    private i87;
    private j87;
    private k87;
    private l87;
    private m87;
    /**
     * 扩展字段 base表示只返回基础数据，all表示所有数据 ，默认 base
     */
    private z2;
    /**
     * 货车导航请求参数构造
     *
     * @param fromAndTo      必填 路径的起点终点。
     * @param mode           计算路径的模式。可选，默认为躲避拥堵 {@link RouteSearch#TRUCK_AVOID_CONGESTION}。
     * @param passedByPoints 途经点，可选。最多支持6个途经点。
     * @param truckSize      必填 货车大小 默认 {@link #TRUCK_SIZE_LIGHT}
     *                       高德此分类依据国标
     *                       1：微型车，2：轻型车（默认值），3：中型车，4：重型车<br>
     *                       根据新的汽车分类国家标准(GB9417-89)就可方便地区分车型。<br>
     *                       载货汽车： 依公路运行时厂定最大总质量（GA）划分为：<br>
     *                       微型货车（GA≤1．8吨）  {@link RouteSearch#TRUCK_SIZE_MINI}<br>
     *                       轻型货车（1．8吨＜GA≤6吨）  {@link RouteSearch#TRUCK_SIZE_LIGHT}<br>
     *                       中型货车（6．0吨＜GA≤14吨）  {@link RouteSearch#TRUCK_SIZE_MEDIUM}<br>
     *                       重型货车（GA＞14吨）  {@link RouteSearch#TRUCK_SIZE_HEAVY}<br>
     * @since 1.0.1
     */
    constructor(e87: FromAndTo, mode: number, f87: ArrayList<LatLonPoint> | null | undefined, g87: number);
    /**
     * 货车导航计算路径的模式设置
     *
     * @param mode 计算路径的模式, 默认为躲避拥堵 {@link RouteSearch#TRUCK_AVOID_CONGESTION}。
     * @since 1.0.1
     */
    setMode(mode: number): void;
    /**
     * 高德此分类依据国标
     * 1：微型车，2：轻型车（默认值），3：中型车，4：重型车<br>
     * 根据新的汽车分类国家标准(GB9417-89)就可方便地区分车型。<br>
     * 载货汽车： 依公路运行时厂定最大总质量（GA）划分为：<br>
     * 微型货车（GA≤1．8吨）  {@link RouteSearch#TRUCK_SIZE_MINI}<br>
     * 轻型货车（1．8吨＜GA≤6吨）  {@link RouteSearch#TRUCK_SIZE_LIGHT}<br>
     * 中型货车（6．0吨＜GA≤14吨）  {@link RouteSearch#TRUCK_SIZE_MEDIUM}<br>
     * 重型货车（GA＞14吨）  {@link RouteSearch#TRUCK_SIZE_HEAVY}<br>
     *
     * @param truckSize 货车大小 {@link RouteSearch#TRUCK_SIZE_LIGHT}。
     * @since 1.0.1
     */
    setTruckSize(d87: number): void;
    /**
     * 车辆高度
     *
     * @param truckHeight 单位米，取值[0 – 25.5]米，默认 1.6 米，会严格按照填写数字进行限行规避，请按照车辆真实信息合理填写。
     * @since 1.0.1
     */
    setTruckHeight(c87: number): void;
    /**
     * 车辆宽度
     *
     * @param truckWidth 单位米，取值[0 – 25.5]米，默认 2.5 米，会严格按照填写数字进行限行规避，请按照车辆真实信息合理填写。
     * @since 1.0.1
     */
    setTruckWidth(b87: number): void;
    /**
     * 车辆总重
     *
     * @param truckLoad 单位吨，取值[0 – 6553.5]吨，默认 0.9 吨，会严格按照填写数字进行限行规避，请按照车辆真实信息合理填写。
     * @since 1.0.1
     */
    setTruckLoad(a87: number): void;
    /**
     * 货车核定载重
     *
     * @param truckWeight 单位吨，取值[0 – 6553.5]吨，默认 10 吨，会严格按照填写数字进行限行规避，请按照车辆真实信息合理填写。
     * @since 1.0.1
     */
    setTruckWeight(z86: number): void;
    /**
     * 车辆轴数
     *
     * @param truckAxis 单位个，取值[0 –255]个，默认 2个轴，会严格按照填写数字进行限行规避，请按照车辆真实信息合理填写。
     * @since 1.0.1
     */
    setTruckAxis(y86: number): void;
    /**
     * 获取路径的起点终点
     *
     * @return 获取路径的起点和终点
     * @since 1.0.1
     */
    getFromAndTo(): FromAndTo;
    /**
     * 计算路径的模式
     *
     * @return 计算路径的模式
     * @since 1.0.1
     */
    getMode(): number;
    /**
     * 扩展字段 base表示只返回基础数据，all表示所有数据 ，默认 base
     * @since 1.0.1
     */
    getExtensions(): string;
    /**
     * 扩展字段 base表示只返回基础数据，all表示所有数据 ，默认 base
     * @since 1.0.1
     */
    setExtensions(extensions: string): void;
    /**
     * @internal javadoc中不显示。
     */
    r13(): boolean;
    /**
     * 返回设定查询的途经点。
     * @internal javadoc中不显示。
     */
    getPassedByPoints(): ArrayList<LatLonPoint>;
    /**
     * 将途径点位置坐标转换为字符串输出。
     *
     * @return 途径点位置坐标转换为字符串
     * @since 1.0.1
     */
    getPassedPointStr(): string;
    /**
     * 获取设置的车辆大小
     *
     * @return 车辆大小
     * @since 1.0.1
     */
    getTruckSize(): number;
    /**
     * 获取设置的车辆高度
     *
     * @return 车辆高度
     * @since 1.0.1
     */
    getTruckHeight(): number;
    /**
     * 获取设置的车辆宽度
     *
     * @return 车辆宽度
     * @since 1.0.1
     */
    getTruckWidth(): number;
    /**
     * 获取设置的车辆总重
     *
     * @return 车辆总重
     * @since 1.0.1
     */
    getTruckLoad(): number;
    /**
     * 获取设置的车辆核定载重
     *
     * @return 车辆核定载重
     * @since 1.0.1
     */
    getTruckWeight(): number;
    /**
     * 获取设置的车辆轴数
     *
     * @return 车辆轴数
     * @since 1.0.1
     */
    getTruckAxis(): number;
    /**
     * @internal javadoc中不显示。
     */
    clone(): TruckRouteQuery;
}
