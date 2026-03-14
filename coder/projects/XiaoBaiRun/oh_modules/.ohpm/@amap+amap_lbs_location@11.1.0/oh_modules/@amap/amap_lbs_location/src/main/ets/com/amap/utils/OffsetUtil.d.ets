// @keepTs
// @ts-nocheck
import { DPoint } from "../location/DPoint";
/**
 * 坐标加偏类
 * @创建时间： 2015年11月23日 下午2:40:37
 * @项目名称： AMapLocationSDK
 * @author hongming.wang
 * @version V2.1.0
 * @since V2.1.0
 * @文件名称: OffsetUtil.java
 * @类型名称: OffsetUtil
 */
export declare class k29 {
    /** The Constant AVG_X. */
    static readonly g35: number;
    /** The Constant AVG_Y. */
    static readonly h35: number;
    static PI: number;
    static readonly a: number;
    static readonly i35: number;
    /**
     * 台湾边界坐标点
     */
    private static readonly j35;
    /**
     * Cover.
     *
     * @param latLng bd09坐标
     * @return 转换后的坐标
     */
    static y29(latLng: DPoint): DPoint;
    static z29(context: Context, latLng: DPoint): DPoint | undefined;
    /**
     * 对原始坐标进行加偏处理
     *
     * @param context
     * @param source
     *            WGS84坐标
     * @return 加偏后的坐标
     */
    static offset(context: Context, source: DPoint): DPoint | undefined;
    /**
     * 坐标转换
     *
     * @param latLng
     *            WCG84原始坐标
     * @param isGroup
     *            是否使用集团加偏算法
     * @return
     */
    private static o35;
    /**
     * mapbar284
     *
     * @param x
     * @param y
     */
    private static n35;
    static q35(x: number, y: number): number;
    static r35(x: number, y: number): number;
    /**
     * 02转84
     * @param lat
     * @param lon
     * @return
     */
    private static m35;
    private static transform;
    static s35(x: number, y: number): number;
    static t35(x: number, y: number): number;
    /**
     * 判断点是否在台湾内
     * @param lat
     * @param lng
     * @return
     */
    static l35(lat: number, p34: number): boolean;
    /**
     * Conver b2 g.
     *
     * @param p
     *            the p
     * @param num
     *            the num
     * @return the point
     */
    private static k35;
    /**
     * Conver b2 g.
     *
     * @param x
     *            the x
     * @param y
     *            the y
     * @param ax
     *            the ax
     * @param ay
     *            the ay
     * @return the point
     */
    private static u35;
    /**
     * Conver g2 b.
     *
     * @param x
     *            the x
     * @param y
     *            the y
     * @return the point
     */
    private static v35;
    /**
     * Gets the double by precision.
     *
     * @param val
     *            the val
     * @param precision
     *            the precision
     * @return the double by precision 对绝对值进行四舍五入
     */
    private static w35;
    /**
     * Gets the _delta_r.
     *
     * @param y
     *            the y
     * @return the _delta_r
     */
    private static y35;
    /**
     * Gets the _delta_t.
     *
     * @param x
     *            the x
     * @return the _delta_t
     */
    private static x35;
}
