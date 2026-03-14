// @keepTs
// @ts-nocheck
import { LatLonPoint } from "../core/LatLonPoint";
/**
 * 逆地理编码返回结果的门牌信息对象。
 * @since V1.0.0
 *
 */
export declare class StreetNumber {
    /**
     *  街道名称
     */
    private street;
    /**
     *  门牌号
     */
    private number;
    /**
     *  坐标点
     */
    private w3;
    /**
     *  方向
     */
    private direction;
    /**
     *  距离
     */
    private distance;
    /**
     * StreetNumber的构造方法。
     * @since V1.0.0
     */
    constructor();
    /**
     * 返回门牌信息中的街道名称。
     * @return 结果的街道名称。
     * @since V1.0.0
     */
    getStreet(): string | undefined;
    /**
     * 设置门牌信息中的街道名称。
     * @param street 街道名称。
     * @since V1.0.0
     */
    setStreet(street: string): void;
    /**
     * 返回门牌信息中的门牌号码。
     * @return 结果的门牌号码。
     * @since V1.0.0
     */
    getNumber(): string | undefined;
    /**
     * 设置门牌信息中的门牌号码。
     * @param number 门牌号码。
     * @since V1.0.0
     */
    setNumber(number: string): void;
    /**
     * 返回门牌信息中的经纬度坐标。
     * @return 结果的经纬度坐标。
     * @since V1.0.0
     */
    getLatLonPoint(): LatLonPoint | undefined;
    /**
     * 设置门牌信息中的经纬度坐标。
     * @param latLonPoint 经纬度坐标。
     * @since V1.0.0
     */
    setLatLonPoint(s59: LatLonPoint | undefined): void;
    /**
     * 返回门牌信息中的方向 ，指结果点相对地理坐标点的方向。方向显示为英文名称，如South、NorthEast。
     * @return 结果的方向。
     * @since V1.0.0
     */
    getDirection(): string | undefined;
    /**
     * 设置门牌信息中的方向 ，指结果点相对地理坐标点的方向。
     * @param direction 方向显示为英文名称，如South、NorthEast。
     * @since V1.0.0
     */
    setDirection(direction: string): void;
    /**
     * 返回门牌信息中地理坐标点与结果点的垂直距离。单位米。
     * @return 结果的距离。
     * @since V1.0.0
     */
    getDistance(): number;
    /**
     * 设置门牌信息中地理坐标点与结果点的垂直距离。单位米。
     * @param distance 距离。
     * @since V1.0.0
     */
    setDistance(distance: number): void;
}
