// @keepTs
// @ts-nocheck
import { LatLonPoint } from "../core/LatLonPoint";
/**
 * 此类定义了打车路段信息
 * @since V3.4.0
 */
export declare class TaxiItem {
    private u83?;
    private v83?;
    private m54?;
    private o78?;
    private y85?;
    private z85?;
    /**
     * TaxiItem构造方法
     * @since V3.4.0
     * @exclude javadoc中不显示。
     */
    constructor();
    /**
     * 获取Taxi起点坐标
     * @return Taxi起点坐标
     * @since V3.4.0
     */
    getOrigin(): LatLonPoint;
    /**
     * 获取Taxi终点坐标
     * @return Taxi终点坐标
     * @since V3.4.0
     */
    getDestination(): LatLonPoint;
    /**
     * 获取方案总距离，单位米。
     * @return 方案总距离，米。
     * @since V3.4.0
     */
    getDistance(): number;
    /**
     * 获取方案耗时，单位秒。
     * @return 方案耗时，秒。
     * @since V3.4.0
     */
    getDuration(): number;
    /**
     * 获取起点名称。
     * @return 起点名称。
     * @since V3.4.0
     */
    getmSname(): string;
    /**
     * 获取终点名称。
     * @return 终点名称。
     * @since V3.4.0
     */
    getmTname(): string;
    /**
     * 设置Taxi起点坐标。
     * @param originpoint 起点坐标。
     * @since V3.4.0
     * @exclude javadoc中不显示。
     */
    e33(x85: LatLonPoint): void;
    /**
     * 设置Taxi终点坐标。
     * @param destination 终点坐标。
     * @since V3.4.0
     * @exclude javadoc中不显示。
     */
    setDestination(destination: LatLonPoint): void;
    /**
     * 设置方案总距离。
     * @param distance 方案总距离。
     * @since V3.4.0
     * @exclude javadoc中不显示。
     */
    setDistance(distance: number): void;
    /**
     * 设置方案耗时。
     * @param duration 方案耗时。
     * @since V3.4.0
     * @exclude javadoc中不显示。
     */
    setDuration(duration: number): void;
    /**
     * 设置起点名称。
     * @param sname 起点名称。
     * @since V3.4.0
     * @exclude javadoc中不显示。
     */
    x33(w85: string): void;
    /**
     * 设置终点名称。
     * @param tname 终点名称。
     * @since V3.4.0
     * @exclude javadoc中不显示。
     */
    y33(v85: string): void;
    /**
     * @exclude javadoc中不显示。
     */
    q2(): number;
}
