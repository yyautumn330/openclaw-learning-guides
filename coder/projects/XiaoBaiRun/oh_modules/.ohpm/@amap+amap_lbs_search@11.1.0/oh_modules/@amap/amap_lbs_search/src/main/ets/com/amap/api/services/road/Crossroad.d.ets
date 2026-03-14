// @keepTs
// @ts-nocheck
import { Road } from "./Road";
/**
 * 逆地理编码返回的结果的交叉路口对象。
 * @since V1.0.0
 */
export declare class Crossroad extends Road {
    /**
     * 逆地理坐标点与交叉路口的垂直距离，单位：米。
     */
    private distance;
    /**
     * 方向
     */
    private direction;
    private i66;
    private j66;
    private k66;
    private l66;
    /**
     * Crossroad的构造函数。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    constructor();
    /**
     * 设置逆地理坐标点与交叉路口的垂直距离，单位米。
     * @param distance 逆地理坐标点与交叉路口的垂直距离。
     * @since V1.0.0
     */
    setDistance(distance: number): void;
    /**
     * 返回逆地理坐标点与交叉路口的垂直距离，单位米。
     * @return 逆地理坐标点与交叉路口的垂直距离。
     * @since V1.0.0
     */
    getDistance(): number;
    /**
     * 设置交叉路口相对逆地理坐标点的方向。方向显示为中文名称，如南、 东北。
     * @param direction 交叉路口相对逆地理坐标点的方向。
     * @since V1.0.0
     */
    setDirection(direction: string): void;
    /**
     * 返回交叉路口相对逆地理坐标点的方向。方向显示为中文名称，如南、 东北。
     * @return 交叉路口相对逆地理坐标点的方向。
     * @since V1.0.0
     */
    getDirection(): string | undefined;
    /**
     * 设置交叉路口的第一条道路ID。
     * @param firstRoadId 交叉路口的第一条道路ID。
     * @since V1.0.0
     */
    setFirstRoadId(h66: string): void;
    /**
     * 返回交叉路口的第一条道路ID。
     * @return 交叉路口的第一条道路ID。
     * @since V1.0.0
     */
    getFirstRoadId(): string | undefined;
    /**
     * 设置交叉路口的第一条道路名称。
     * @param firstRoadName 返回交叉路口的第一条道路名称。
     * @since V1.0.0
     */
    setFirstRoadName(g66: string): void;
    /**
     * 返回交叉路口的第一条道路名称。
     * @return 返回交叉路口的第一条道路名称。
     * @since V1.0.0
     */
    getFirstRoadName(): string;
    /**
     * 设置交叉路口的第二条道路ID。
     * @param secondRoadId 交叉路口的第二条道路ID。
     * @since V1.0.0
     */
    setSecondRoadId(f66: string): void;
    /**
     * 返回交叉路口的第二条道路ID。
     * @return 交叉路口的第二条道路ID。
     * @since V1.0.0
     */
    getSecondRoadId(): string | undefined;
    /**
     * 设置交叉路口的第二条道路名称。
     * @param secondRoadName 返回交叉路口的第二条道路名称。
     * @since V1.0.0
     */
    setSecondRoadName(e66: string): void;
    /**
     * 返回交叉路口的第二条道路名称。
     * @return 返回交叉路口的第二条道路名称。
     * @since V1.0.0
     */
    getSecondRoadName(): string | undefined;
}
