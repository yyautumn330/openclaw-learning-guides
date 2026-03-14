// @keepTs
// @ts-nocheck
import { Point } from '../api/model/Point';
export declare class VirtualEarthProjection {
    static readonly b38: number;
    static readonly k266: number;
    static readonly l266: number;
    static readonly m266: number;
    static readonly n266: number;
    static readonly o266: number;
    static readonly p266: number;
    static readonly q266: number;
    /** 256 * 1<<20 */
    private static readonly r266;
    private static readonly s266;
    private static readonly t266;
    static readonly u266: number;
    constructor();
    static clip(n: number, minValue: number, maxValue: number): number;
    /**
     * 转角度
     * @param xARc
     * @return
     */
    private static v266;
    private static w266;
    static latLongToPixels(latitude: number, longitude: number, z265: number): Point;
    static o8(o265: number, p265: number, q265: number): Point;
}
