// @keepTs
// @ts-nocheck
import { LatLonPoint } from "../core/LatLonPoint";
import { WalkPath } from "./WalkPath";
/**
 * 定义了公交换乘路径规划的一个换乘段的步行信息。
 * @since V2.1.0
 */
export declare class RouteBusWalkItem extends WalkPath {
    private u83?;
    private v83?;
    /**
     * 返回此路段步行导航信息的起点坐标。
     * @return 此路段步行导航信息的起点坐标。
     * @since V2.1.0
     */
    getOrigin(): LatLonPoint;
    /**
     * 设置此路段步行导航信息的起点坐标。
     * @param mOrigin 此路段步行导航信息的起点坐标。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    e33(t83: LatLonPoint): void;
    /**
     * 返回此路段步行导航信息的终点坐标。
     * @return 此路段步行导航信息的终点坐标。
     * @since V2.1.0
     */
    getDestination(): LatLonPoint;
    /**
     * 设置此路段步行导航信息的终点坐标。
     * @param mDestination 此路段步行导航信息的终点坐标。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    setDestination(s83: LatLonPoint): void;
    /**
     * @exclude javadoc中不显示。
     */
    q2(): number;
    /**
     * RouteBusWalkItem的构造方法。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    constructor();
}
