// @keepTs
// @ts-nocheck
import { LatLonPoint } from "../core/LatLonPoint";
import ArrayList from "@ohos.util.ArrayList";
/**
 * 交通信息类
 * @author qsh
 * @since 1.0.0
 */
export declare class TMC {
    private m54;
    private n86?;
    private y75?;
    /**
     * 返回路况距离。
     * @return 距离长度。
     * @since 1.0.0
     */
    getDistance(): number;
    /**
     * 返回路况。
     * 未知、畅通、缓行、拥堵
     * @return 路况
     * @since 1.0.0
     */
    getStatus(): string;
    /**
     * 设置路况距离。
     * @param distance 距离长度。
     * @since 1.0.0
     * @internal
     */
    setDistance(distance: number): void;
    /**
     * 设置路况。
     * @param status 路况。
     * @since 1.0.0
     * @internal
     */
    setStatus(status: string): void;
    /**
     * 获取本段路况的坐标点集合。
     * @return 此段路况的坐标点集合。
     * @since 1.0.0
     */
    getPolyline(): ArrayList<LatLonPoint>;
    /**
     * 设置路段的坐标点集合。
     * @param polyline 路段的坐标点集合。
     * @since 1.0.0
     * @internal
     */
    setPolyline(polyline?: ArrayList<LatLonPoint>): void;
}
