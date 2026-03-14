// @keepTs
// @ts-nocheck
import { DPoint } from "./DPoint";
import { LatLng } from "./LatLng";
export declare class WeightedLatLng {
    /**
     * 位置点默认权值1.0
     *
     * @since 2.2.3
     */
    static readonly DEFAULT_INTENSITY: number;
    /**
     * @internal
     */
    private mPoint;
    /**
     * 强度权值
     *
     * @since 2.2.3
     */
    readonly intensity: number;
    /**
     * 地理位置
     *
     * @since 2.2.3
     */
    readonly latLng?: LatLng;
    /**
     * 构造函数
     *
     * @param latLng    经纬度
     * @param intensity 权值，大于零；两个权值等于一的位置点等同于一个权值等于二的点。
     * @since 2.2.3
     */
    constructor(latLng: LatLng, intensity?: number);
    /**
     * @return
     * @internal
     */
    d34(): DPoint;
    /**
     * @internal
     * @param latLng
     * @returns
     */
    static g47(latLng: LatLng): DPoint;
}
