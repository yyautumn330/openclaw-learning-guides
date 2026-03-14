// @keepTs
// @ts-nocheck
import { LatLonPoint } from "../core/LatLonPoint";
import ArrayList from "@ohos.util.ArrayList";
import { RoutePOISearchType } from "./RoutePOISearch";
/**
 * 此类定义了沿途POI搜索的参数。
 * @since V1.0.0
 */
export declare class RoutePOISearchQuery {
    private static v44;
    private v79;
    private w79;
    private t67;
    private g89;
    private h89;
    private i89;
    private channel;
    /**
     * 根据给定的参数来构造一个 RoutePOISearchQuery 的新对象。
     * @param fromPoint 沿途搜的起点坐标，应和路径规划的起点一致。
     * @param toPoint 沿途搜的终点坐标，应和路径规划的终点一致。
     * @param mode 计算路径的模式，路径规划方式。
     * @param type 搜索的type类型，参考 {@link RoutePOISearchType}。
     * @param range 道路周围搜索的范围，(0,500]米,；
     * @since V1.0.0
     */
    constructor(e89: LatLonPoint, f89: LatLonPoint, mode: number, type: RoutePOISearchType, range: number);
    /**
     * 根据给定的参数来构造一个 RoutePOISearchQuery 的新对象。<br>
     * 如导航过程中想知道接下来一段路线周边路口，可以将改路段经纬度点取出，使用此接口进行查询。
     * @param polyline 沿途搜索的坐标点集合。
     * @param type 搜索的type类型，参考{@link RoutePOISearchType}。
     * @param range 道路周围搜索的范围，0~500米；
     * @since V5.1.0
     */
    static RoutePOISearchQueryForPolyline(polyline: ArrayList<LatLonPoint>, type: RoutePOISearchType, range: number): RoutePOISearchQuery;
    /**
     * 返回沿途搜索路径规划的起点坐标。
     * @return 路径规划的起点坐标。
     * @since V1.0.0
     */
    getFrom(): LatLonPoint | undefined;
    /**
     * 返回路径规划的终点坐标。
     *
     * @return 路径规划的终点坐标。
     * @since V1.0.0
     */
    getTo(): LatLonPoint | undefined;
    /**
     * 返回计算路径的模式。
     *
     * @return 计算路径的模式。
     * @since V1.0.0
     */
    getMode(): number | undefined;
    /**
     * 返回沿途搜索的POI类型。
     *
     * @return POI类型，RoutePOISearchType枚举类表示
     * @since V1.0.0
     */
    getSearchType(): RoutePOISearchType | undefined;
    /**
     * 返回道路周围搜索的范围。
     * @return 道路周围搜索的范围。
     * @since V1.0.0
     */
    getRange(): number | undefined;
    /**
     * 返回沿途搜索设置的坐标点集合。
     * @return 沿途搜索设置的坐标点集合。
     * @since V5.1.0
     */
    getPolylines(): ArrayList<LatLonPoint>;
    /**
     * 设置channel
     *
     * @param channel
     * @since V1.0.0
     */
    setChannel(channel: string | undefined): void;
    /**
     * 获取channel
     *
     * @since V1.0.0
     */
    getChannel(): string | undefined;
    /**
     * @exclude javadoc中不显示。
     */
    clone(): RoutePOISearchQuery;
}
