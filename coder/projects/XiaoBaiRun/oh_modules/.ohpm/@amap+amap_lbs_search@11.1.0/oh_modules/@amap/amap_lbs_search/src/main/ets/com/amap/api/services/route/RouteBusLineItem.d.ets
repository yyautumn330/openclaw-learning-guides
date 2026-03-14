// @keepTs
// @ts-nocheck
import ArrayList from "@ohos.util.ArrayList";
import { LatLonPoint } from "../core/LatLonPoint";
import { BusLineItem } from "../busline/BusLineItem";
import { BusStationItem } from "../busline/BusStationItem";
/**
 * 定义了公交换乘路径规划的一个换乘段的公交信息。
 * @since V2.1.0
 */
export declare class RouteBusLineItem extends BusLineItem {
    private o83?;
    private p83?;
    private y75;
    private q83?;
    private r83;
    private o78?;
    /**
     * 返回此公交换乘路段的出发站。此站有可能不是公交线路的始发车站。
     * @return 此公交换乘路段的出发站。
     * @since V2.1.0
     */
    getDepartureBusStation(): BusStationItem;
    /**
     * 设置此公交换乘路段的出发站。
     * @param mDepartureBusStation 此公交换乘路段的出发站。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    b34(n83: BusStationItem): void;
    /**
     * 返回此公交换乘路段的到达站。此站有可能不是公交线路的终点站。
     * @return 此公交换乘路段的到达站。
     * @since V2.1.0
     */
    getArrivalBusStation(): BusStationItem;
    /**
     * 设置此公交换乘路段的到达站。
     * @param mArrivalBusStation 此公交换乘路段的到达站。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    c34(m83: BusStationItem): void;
    /**
     * 返回此公交换乘路段（出发站-到达站）的坐标点集合。
     * @return 此公交换乘路段（出发站-到达站）的坐标点集合。
     * @since V2.1.0
     */
    getPolyline(): ArrayList<LatLonPoint>;
    /**
     * 设置此公交换乘路段（出发站-到达站）的坐标点集合。
     * @param mPolyline 此公交换乘路段（出发站-到达站）的坐标点集合。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    setPolyline(l83: ArrayList<LatLonPoint>): void;
    /**
     * 返回此公交换乘路段经过的站点数目（除出发站、到达站）。
     * @return 此公交换乘路段经过的站点数目（除出发站、到达站）。
     * @since V2.1.0
     */
    getPassStationNum(): number;
    /**
     * 设置此公交换乘路段经过的站点数目（除出发站）。
     * @param mPassStationNum 此公交换乘路段经过的站点数目（除出发站）。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    d34(k83: number): void;
    /**
     * 返回此公交换乘路段经过的站点名称 。
     * @return 此公交换乘路段经过的站点名称 。
     * @since V2.1.0
     */
    getPassStations(): ArrayList<BusStationItem>;
    /**
     * 设置此公交换乘路段经过的站点名称 。
     * @param mPassStations 此公交换乘路段经过的站点名称。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    f34(j83: ArrayList<BusStationItem>): void;
    /**
     * 返回此公交换乘路段公交预计行驶时间 。
     * @return 此公交换乘路段公交预计行驶时间 。
     * @since V2.1.0
     */
    getDuration(): number;
    /**
     * 设置此公交换乘路段公交预计行驶时间 。
     * @param mDuration 此公交换乘路段公交预计行驶时间 。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    setDuration(i83: number): void;
    /**
     * @exclude javadoc中不显示。
     */
    q2(): number;
    /**
     * RouteBusLineItem的构造方法。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    constructor();
}
