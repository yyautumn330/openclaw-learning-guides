// @keepTs
// @ts-nocheck
import { LatLng } from '../../api/model/LatLng';
import ArrayList from "@ohos.util.ArrayList";
import { Point } from '../../api/model/Point';
/**
 * 计算点到线最短距离工具类
 */
export declare class SpatialRelationUtil {
    static readonly a251: number;
    static readonly b251: number;
    static readonly c251: number;
    static readonly w212: number;
    /**
     * @exclude javadoc中不显示 静态工具类  不显示构造方法
     */
    constructor();
    /**
     * 计算一个点在线上的垂足，如果垂足在线上的某一顶点，则直接返回顶点的下标
     *
     * @param points Point 数组
     * @param point
     * @return
     * @since V4.1.3
     */
    static calShortestDistancePoint(points: ArrayList<Point>, point: Point, bearing?: number): [
        number,
        Point
    ] | undefined;
    static calShortestDistanceLatLng(points: ArrayList<LatLng>, point: LatLng, bearing?: number, distance?: number): [
        number,
        LatLng
    ] | undefined;
    private static d251;
    /**
     * 点P到线段AB的最短距离，不是点到直线的距离<br>
     * 点P到AB上的垂足为C<br>
     * 如果C在AB的两侧则，最短距离为PA或PB，否则为PC<br>
     *
     * @param x  点P的坐标
     * @param y
     * @param x1 点A的坐标
     * @param y1
     * @param x2 点B的坐标
     * @param y2
     * @return
     * @since V4.1.3
     */
    private static e251;
}
