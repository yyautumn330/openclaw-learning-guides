// @keepTs
// @ts-nocheck
import { LatLng } from "../../api/model/LatLng";
/**
 * 坐标加偏类
 *
 * @author Ton
 * @version V3.2.0
 * @项目名称： AMapSDK
 * @文件名称: OffsetUtil.java
 * @类型名称: OffsetUtil
 * @since V3.2.0
 */
export declare class k7 {
    private static readonly TAG;
    /**
     * 是否已经加载集团加偏库
     */
    private static i118;
    /**
     * 对原始坐标进行加偏处理
     *
     * @param context
     * @param source  WCJ84坐标
     * @return 加偏后的坐标
     */
    static offset(context: Context, source: LatLng): LatLng | undefined;
    /**
     * 对原始坐标进行加偏处理
     *
     * @param context
     * @param lon     经度
     * @param lat     纬度
     * @return 加偏后的坐标
     */
    static k118(context: Context, g118: number, h118: number): LatLng | undefined;
    /**
     * 坐标转换
     *
     * @param latLng  WCG84原始坐标
     * @param isGroup 是否使用集团加偏算法
     * @return
     */
    private static j118;
    static PI: number;
    static r7(context: Context, latLng: LatLng): LatLng | undefined;
    static n118(x: number, y: number): number;
    static o118(x: number, y: number): number;
    /**
     * mapbar284
     *
     * @param x
     * @param y
     */
    private static m118;
    /**
     * The Constant AVG_X.
     */
    static readonly p118: number;
    /**
     * The Constant AVG_Y.
     */
    static readonly q118: number;
    /**
     * Cover.
     *
     * @param latLng the coors
     * @return the string
     */
    static p7(latLng: LatLng): LatLng | undefined;
    /**
     * Gets the _delta_r.
     *
     * @param y the y
     * @return the _delta_r
     */
    private static u118;
    /**
     * Gets the _delta_t.
     *
     * @param x the x
     * @return the _delta_t
     */
    private static v118;
    /**
     * Conver g2 b.
     *
     * @param x the x
     * @param y the y
     * @return the point
     */
    private static w118;
    /**
     * Gets the double by precision.
     *
     * @param val       the val
     * @param precision the precision
     * @return the double by precision
     */
    private static x118;
    /**
     * Conver b2 g.
     *
     * @param dpx   the p
     * @param num the num
     * @return the point
     */
    private static r118;
    /**
     * Conver b2 g.
     *
     * @param x  the x
     * @param y  the y
     * @param ax the ax
     * @param ay the ay
     * @return the point
     */
    private static y118;
    /**
     * 台湾的左上角（西北角）坐标
     */
    private static readonly z118;
    /**
     * 台湾的右下角（东南角）坐标
     */
    private static readonly a119;
    /**
     * 台湾边界坐标点
     */
    private static readonly b119;
    private static c119;
    private static d119;
    /**
     * 判断点是否在台湾内
     * @param lat
     * @param lng
     * @return
     */
    static s118(k117: number, l117: number): boolean;
    /**
     * 02转84
     * @param lat
     * @param lon
     * @return
     */
    private static t118;
    static a: number;
    static f119: number;
    private static transform;
    static g119(x: number, y: number): number;
    static h119(x: number, y: number): number;
}
