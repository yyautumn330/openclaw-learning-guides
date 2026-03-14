// @keepTs
// @ts-nocheck
import { LatLonPoint } from "../core/LatLonPoint";
/**
 * 逆地理编码返回结果的道路对象。
 * @since V1.0.0
 *
 */
export declare class ReGeocodeRoad {
    /**
     * 道路ID
     */
    private id;
    /**
     *  道路名称
     */
    private name;
    /**
     * 逆地理坐标点与道路的垂直距离，单位：米。
     */
    private distance;
    /**
     * 方向
     */
    private direction;
    /**
     * 坐标点
     */
    private r59;
    /**
     * ReGeocodeRoad  的构造方法。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    constructor();
    /**
     * 返回道路对象中的道路ID。
     * @return 结果的道路ID。
     * @since V1.0.0
     */
    getId(): string | undefined;
    /**
     * 设置道路对象中的道路ID
     * @param id 道路ID
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    setId(id: string): void;
    /**
     * 返回道路对象中的道路名称。
     * @return 结果的道路名称。
     * @since V1.0.0
     */
    getName(): string | undefined;
    /**
     * 设置道路对象中的道路名称。
     * @param name 道路名称。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    setName(name: string): void;
    /**
     * 返回道路对象中地理坐标点与道路的垂直距离，单位米。
     * @return 地理坐标点与道路的垂直距离。
     * @since V1.0.0
     */
    getDistance(): number;
    /**
     * 设置道路对象中地理坐标点与道路的垂直距离，单位米。
     * @param distance 地理坐标点与道路的垂直距离。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    setDistance(distance: number): void;
    /**
     * 返回道路对象中道路中心点相对地理坐标点的方向。方向显示为英文名称，如South、 NorthEast。
     * @return 道路中心点相对地理坐标点的方向。
     * @since V1.0.0
     */
    getDirection(): string | undefined;
    /**
     * 设置道路对象中道路中心点相对地理坐标点的方向。
     * @param direction 道路中心点相对地理坐标点的方向。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    setDirection(direction: string): void;
    /**
     * 返回道路中心点的经纬度坐标。
     * @return 道路中心点的经纬度坐标。
     * @since V1.0.0
     */
    getLatLngPoint(): LatLonPoint | undefined;
    /**
     * 设置道路中心点的经纬度坐标。
     * @param latLngPoint 道路中心点的经纬度坐标。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    x37(q59: LatLonPoint | undefined): void;
}
