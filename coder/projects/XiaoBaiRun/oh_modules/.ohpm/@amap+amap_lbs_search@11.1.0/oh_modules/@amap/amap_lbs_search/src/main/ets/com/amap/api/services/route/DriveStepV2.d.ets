// @keepTs
// @ts-nocheck
import { RouteSearchCity } from "./RouteSearchCity";
import { LatLonPoint } from "../core/LatLonPoint";
import { TMC } from "./TMC";
import { Cost } from "./Cost";
import { Navi } from "./Navi";
import ArrayList from "@ohos.util.ArrayList";
/**
 * 定义了驾车路径规划的一个路段。
 * @since 1.0.0
 */
export declare class DriveStepV2 {
    private l78?;
    private m78?;
    private w75?;
    private y75;
    private r78;
    private s78;
    private b79;
    private cost?;
    private navi?;
    /**
     * 获取导航信息
     *
     * @return
     */
    getNavi(): Navi;
    /**
     * 设置导航信息
     *
     * @param navi
     */
    setNavi(navi: Navi): void;
    /**
     * 获取路线消耗信息
     *
     * @return
     */
    getCostDetail(): Cost;
    /**
     * 设置路线消耗信息
     *
     * @param cost
     */
    setCostDetail(a79: Cost): void;
    /**
     * 获取分段距离信息
     *
     * @return
     */
    getStepDistance(): number;
    /**
     * 设置分段距离信息
     *
     * @param stepDistance
     */
    setStepDistance(z78: number): void;
    /**
     * 返回驾车路段的行驶指示。
     * @return 驾车路段的行驶指示。
     * @since 1.0.0
     */
    getInstruction(): string;
    /**
     * 设置驾车路段的行驶指示。
     * @param mInstruction 驾车路段的行驶指示。
     * @since 1.0.0
     * @internal
     */
    y32(y78: string): void;
    /**
     * 返回驾车路段的行驶方向。方向为中文名称，如东、西南等。
     * @return 驾车路段的行驶方向。
     * @since 1.0.0
     */
    getOrientation(): string;
    /**
     * 设置驾车路段的行驶方向。方向为中文名称，如东、西南等。
     * @param mOrientation 驾车路段的行驶方向。
     * @since 1.0.0
     * @internal
     */
    setOrientation(x78: string): void;
    /**
     * 返回驾车路段的道路名称。
     * @return 驾车路段的道路名称。
     * @since 1.0.0
     */
    getRoad(): string;
    /**
     * 设置驾车路段的道路名称。
     * @param mRoad 驾车路段的道路名称。
     * @since 1.0.0
     * @internal
     */
    z32(w78: string): void;
    /**
     * 返回驾车路段的坐标点集合。
     * @return 驾车路段的坐标点集合。
     * @since 1.0.0
     */
    getPolyline(): ArrayList<LatLonPoint>;
    /**
     * 设置驾车路段的坐标点集合。
     * @param mPolyline 驾车路段的坐标点集合。
     * @since 1.0.0
     * @internal
     */
    setPolyline(v78: ArrayList<LatLonPoint>): void;
    /**
     * 得到搜索返回的路径规划途径城市和行政区。
     * @return 搜索返回的路径规划途径城市和行政区。
     * @since 1.0.0
     */
    getRouteSearchCityList(): ArrayList<RouteSearchCity>;
    /**
     * 设置搜索返回的路径规划途径城市和行政区。
     * @param mRouteCityList 搜索返回的路径规划途径城市和行政区。
     * @since 1.0.0
     * @internal
     */
    n35(u78: ArrayList<RouteSearchCity>): void;
    /**
     * 获取搜索返回的路径规划交通拥堵信息。
     * @return 交通拥堵信息。
     * @since V3.3.0
     */
    getTMCs(): ArrayList<TMC>;
    /**
     * 设置路径规划的交通拥堵信息。
     * @param tmcs 交通拥堵信息。
     * @internal
     */
    setTMCs(t78: ArrayList<TMC>): void;
}
