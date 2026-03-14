// @keepTs
// @ts-nocheck
import { LatLonPoint } from "../core/LatLonPoint";
import { RouteSearchCity } from "./RouteSearchCity";
import { TMC } from "./TMC";
import ArrayList from "@ohos.util.ArrayList";
/**
 * 定义了驾车路径规划的一个路段。
 * @since 1.0.0
 */
export declare class DriveStep {
    private l78?;
    private m78?;
    private w75?;
    private m54;
    private v74;
    private w74;
    private n78?;
    private o78;
    private y75?;
    private p78?;
    private q78?;
    private r78;
    private s78;
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
    y32(k78: string): void;
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
    setOrientation(j78: string): void;
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
    z32(i78: string): void;
    /**
     * 返回驾车路段的距离，单位米。
     * @return 驾车路段的距离。
     * @since 1.0.0
     */
    getDistance(): number;
    /**
     * 设置驾车路段的距离，单位米。
     * @param mDistance 驾车路段的距离。
     * @since 1.0.0
     * @internal
     */
    setDistance(h78: number): void;
    /**
     * 返回驾车路段的收费价格，单位元。
     * @return 驾车路段的收费价格。
     * @since 1.0.0
     */
    getTolls(): number;
    /**
     * 设置驾车路段的收费价格，单位元。
     * @param mTolls 驾车路段的收费价格。
     * @since 1.0.0
     * @internal
     */
    setTolls(g78: number): void;
    /**
     * 返回驾车收费路段的距离，单位米。
     * @return 返回驾车收费路段的距离。
     * @since 1.0.0
     */
    getTollDistance(): number;
    /**
     * 设置驾车收费路段的距离，单位米。
     * @param mTollDistance 驾车收费路段的距离。
     * @since 1.0.0
     * @internal
     */
    setTollDistance(f78: number): void;
    /**
     * 返回驾车路段的主要收费道路。
     * @return 驾车路段的主要收费道路。
     * @since 1.0.0
     */
    getTollRoad(): string;
    /**
     * 设置驾车路段的主要收费道路。
     * @param mTollRoad 驾车路段的主要收费道路。
     * @since 1.0.0
     * @internal
     */
    setTollRoad(e78: string): void;
    /**
     * 返回驾车路段的预计时间，单位秒。时间根据当时路况估算。
     * @return 驾车路段的预计时间。
     * @since 1.0.0
     */
    getDuration(): number;
    /**
     * 设置驾车路段的预计时间，单位秒。应考虑实时路况。
     * @param mDuration 驾车路段的预计时间。
     * @since 1.0.0
     * @internal
     */
    setDuration(d78: number): void;
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
    setPolyline(c78?: ArrayList<LatLonPoint>): void;
    /**
     * 返回驾车路段的导航主要操作。
     * @return 驾车路段的导航主要操作。
     * @since 1.0.0
     */
    getAction(): string;
    /**
     * 设置驾车路段的导航主要操作。
     * @param mAction 驾车路段的导航主要操作。
     * @since 1.0.0
     * @internal
     */
    setAction(b78: string): void;
    /**
     * 返回驾车路段的导航辅助操作。
     * @return 驾车路段的导航辅助操作。
     * @since 1.0.0
     */
    getAssistantAction(): string;
    /**
     * 设置驾车路段的导航辅助操作。
     * @param mAssistantAction 驾车路段的导航辅助操作。
     * @since 1.0.0
     * @internal
     */
    setAssistantAction(a78: string): void;
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
    n35(z77: ArrayList<RouteSearchCity>): void;
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
    setTMCs(y77: ArrayList<TMC>): void;
}
