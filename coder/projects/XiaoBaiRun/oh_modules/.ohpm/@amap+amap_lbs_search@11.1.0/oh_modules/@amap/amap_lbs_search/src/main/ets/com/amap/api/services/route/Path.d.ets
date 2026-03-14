// @keepTs
// @ts-nocheck
import { LatLonPoint } from "../core/LatLonPoint";
import ArrayList from "@ohos.util.ArrayList";
export declare class Path {
    private m54;
    private o78;
    private y75;
    /**
     * 返回路线的坐标点集合。
     * @return 路线的坐标点集合。
     * @since 1.0.0
     */
    getPolyline(): ArrayList<LatLonPoint>;
    /**
     * 设置路段的坐标点集合。
     * @param mPolyline 路段的坐标点集合。
     * @since 1.0.0
     * @internal
     */
    setPolyline(r81: ArrayList<LatLonPoint>): void;
    /**
     * 返回此规划方案的距离，单位米。
     * 公交换乘路径规划时，此距离为方案的步行距离与公交距离之和。
     * @return 此规划方案的距离。
     * @since 1.0.0
     */
    getDistance(): number;
    /**
     * 设置路径规划方案的大约距离，单位米。
     * @param mDistance 路径规划方案的大约距离。
     * @since 1.0.0
     * @internal
     */
    setDistance(q81: number): void;
    /**
     * 返回方案的预计消耗时间，单位秒。
     * @return 方案的预计消耗时间。
     * @since 1.0.0
     */
    getDuration(): number;
    /**
     * 设置方案的预计消耗时间，单位秒。
     * @param mDuration 方案的预计消耗时间。
     * @since 1.0.0
     * @internal
     */
    setDuration(p81: number): void;
}
