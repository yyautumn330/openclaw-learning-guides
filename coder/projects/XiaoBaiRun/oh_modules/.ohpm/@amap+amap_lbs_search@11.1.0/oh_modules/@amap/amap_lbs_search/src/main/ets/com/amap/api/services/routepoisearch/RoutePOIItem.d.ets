// @keepTs
// @ts-nocheck
import { LatLonPoint } from "../core/LatLonPoint";
/**
 * 定义一个沿途搜索POI（Point Of Interest，兴趣点）。
 * @since V1.0.0
 */
export declare class RoutePOIItem {
    private b82;
    private o54;
    private n54;
    private m54;
    private o78;
    private h61;
    /**
     * 返回沿途POI的id。
     * @return 沿途POI的id。
     * @since V1.0.0
     */
    getID(): string | undefined;
    /**
     * 设置沿途POI的id。
     * @param id 沿途POI 的id标识。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    setID(id: string | undefined): void;
    /**
     * 返回沿途POI的名称。
     * @return 沿途POI的名称。
     * @since V1.0.0
     */
    getTitle(): string | undefined;
    /**
     * 设置沿途POI的名称。
     * @param title 沿途POI的名称。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    setTitle(title: string | undefined): void;
    /**
     * 返回沿途POI的位置。
     * @return 该POI的位置。
     * @since V1.0.0
     */
    getPoint(): LatLonPoint | undefined;
    /**
     * 设置沿途POI的位置。
     * @param point 沿途POI的位置。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    setPoint(point: LatLonPoint | undefined): void;
    /**
     * 返回用户起点经过途经点POI再到终点的距离，单位是米。
     * @return 用户起点经过途经点再到终点的距离。
     * @since V1.0.0
     */
    getDistance(): number | undefined;
    /**
     * 设置经过该POI再到终点的距离。
     * @param distance 距离。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    setDistance(distance: number | undefined): void;
    /**
     * 返回用户起点经过途经点再到终点的时间，单位为秒。
     * @return 用户起点经过途经点再到终点的时间。
     * @since V1.0.0
     */
    getDuration(): number | undefined;
    /**
     * 设置用户途径该POI再到终点的耗时。
     * @param duration 途径该POI的总耗时。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    setDuration(duration: number | undefined): void;
    /**
     * 获取cpid
     * @return
     */
    getCPID(): string | undefined;
    /**
     * 设置cpid
     * @return
     */
    setCPID(a89: string | undefined): void;
}
