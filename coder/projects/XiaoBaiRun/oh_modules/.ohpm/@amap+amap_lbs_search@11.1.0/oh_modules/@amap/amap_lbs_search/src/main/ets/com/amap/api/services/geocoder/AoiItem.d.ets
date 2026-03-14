// @keepTs
// @ts-nocheck
import { LatLonPoint } from "../core/LatLonPoint";
/**
 * 定义了逆地理编码返回的一个面状数据信息。
 * @since V1.0.0
 */
export declare class AoiItem {
    private v57;
    private w57;
    private x3;
    private x57;
    private y57;
    private distance;
    private type;
    /**
     * 构造AoiItem对象。
     * @exclude javadoc中不显示。
     */
    constructor();
    /**
     * 返回AOI的id，即其唯一标识。AOI的id，同POI的id。
     * @return AOI的id。
     * @since V1.0.0
     */
    getAoiId(): string | undefined;
    /**
     * 返回AOI的名称。
     * @return AOI的名称。
     * @since V1.0.0
     */
    getAoiName(): string | undefined;
    /**
     * 返回AOI的行政区划代码。
     * @return AOI的行政区划代码。
     * @since V1.0.0
     */
    getAdCode(): string | undefined;
    /**
     * 返回AOI的中心点坐标。
     * @return AOI的中心点坐标。
     * @since V1.0.0
     */
    getAoiCenterPoint(): LatLonPoint | undefined;
    /**
     * 返回AOI覆盖区域面积，单位平方米。
     * @return AOI覆盖区域面积。
     * @since V1.0.0
     */
    getAoiArea(): number;
    /**
     * 设置AOI的id。
     * @param aoiId AOI的id。
     * @exclude javadoc中不显示。
     */
    setId(u57: string): void;
    /**
     * 设置AOI名称。
     * @param aoiName AOI名称。
     * @exclude javadoc中不显示。
     */
    setName(t57: string): void;
    /**
     * 设置AOI的行政区划代码。
     * @param adCode AOI的行政区划代码。
     * @exclude javadoc中不显示。
     */
    setAdCode(s57: string): void;
    /**
     * 设置AOI的中心点坐标。
     * @param aoiCenterPoint AOI的中心点坐标。
     * @exclude javadoc中不显示。
     */
    setLocation(r57: LatLonPoint | undefined): void;
    /**
     * 设置AOI覆盖区域面积。
     * @param aoiArea AOI覆盖区域面积，单位平方米。
     * @exclude javadoc中不显示。
     */
    c38(q57: number): void;
    /**
     * 返回AOI到当前逆地理编码点的距离。
     * @exclude javadoc中不显示。
     * @return
     */
    getDistance(): number;
    /**
     * 设置AOI到当前逆地理编码点的距离。
     * @exclude javadoc中不显示。
     * @param distance
     */
    setDistance(distance: number): void;
    /**
     * 返回AOI的类型
     * @exclude javadoc中不显示。
     * @return
     */
    getType(): string | undefined;
    /**
     * 设置AOI的类型
     * @exclude javadoc中不显示。
     * @param type
     */
    setType(type: string): void;
}
