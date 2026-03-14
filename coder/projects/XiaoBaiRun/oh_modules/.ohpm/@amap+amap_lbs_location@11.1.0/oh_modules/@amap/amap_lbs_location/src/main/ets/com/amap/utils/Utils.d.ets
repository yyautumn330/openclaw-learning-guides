// @keepTs
// @ts-nocheck
import { AMapLocation } from "../location/AMapLocation";
import { DPoint } from "../location/DPoint";
import ArrayList from "@ohos.util.ArrayList";
export declare class Utils {
    static readonly b33 = 2;
    /**
     * 获取时间戳
     */
    static getTime(): number;
    /**
     * 获取两点坐标之间的距离
     * @param pointA
     * @param pointB
     * @returns
     */
    static b12(i39: DPoint, j39: DPoint): number;
    static r39(f39: AMapLocation): boolean;
    /**
     * 判断位置记录是否正确（策略）
     *
     * @param amapLoc
     * @return boolean
     */
    static z11(e39: AMapLocation | undefined): boolean;
    /**
     * 判断坐标点是否在多边形内
     *
     * @param point
     * @param points
     * @return 是否在多边形内 true:在，false：不在
     *
     */
    static h12(point: DPoint, points: ArrayList<DPoint>): boolean;
    private static c33;
    private static multiply;
    private static isIntersect;
    static argb(alpha: number, red: number, green: number, blue: number): number;
    static red(color: number): number;
    static green(color: number): number;
    static blue(color: number): number;
    static alpha(color: number): number;
    private static readonly s39;
    private static readonly t39;
    /**
     * 计算两个 DPoint 之间的距离（米），算法与 AMapUtils.calculateLineDistance 完全一致。
     */
    static calculateLineDistance(start: DPoint, end: DPoint): number;
}
