// @keepTs
// @ts-nocheck
import { DPoint } from "../location/DPoint";
export declare class j29 {
    static readonly y32: number;
    static readonly z32: number;
    static readonly WIDTH: number;
    static readonly HEIGHT: number;
    private static readonly a33;
    static readonly b33: number;
    static a30(lat: number, x32: number): boolean;
    /**
     * 判断坐标点是否在多边形内
     *
     * @param point
     * @param points
     * @return 是否在多边形内 true:在，false：不在
     *
     */
    static h12(point: DPoint, points: DPoint[]): boolean;
    private static c33;
    private static multiply;
    private static isIntersect;
}
