// @keepTs
// @ts-nocheck
import { CoordType } from "./CoordType";
import { DPoint } from "./DPoint";
/**
 * 坐标转换类
 * @author hongming.wang
 * @since 2.1.0
 * @version 2.1.0
 */
export declare class CoordinateConverter {
    private static i21;
    private static p29;
    private static q29;
    private static r29;
    private static s29;
    private static t29;
    private static u29;
    private static v29;
    private ctx;
    private coordType?;
    private source?;
    w29?: DPoint;
    /** 弧度 PI/180 **/
    private static readonly R;
    /**
     * 构造方法
     *
     * @param context
     * @since 2.1.0
     */
    constructor(context: Context);
    /**
     * 设置偏转源类型
     *
     * @param type
     *            类型见CoordType
     * @return
     * @since 2.1.0
     */
    from(type: CoordType): CoordinateConverter;
    /**
     * 设置偏转数据源
     *
     * @param latLng
     *            需要转换的坐标点
     * @return 包含需要转换的坐标点的CoordinateConverter对象
     * @since 2.1.0
     */
    coord(latLng: DPoint): CoordinateConverter;
    convert(): DPoint | undefined;
    /**
     * 是否是高德地图可用数据
     *
     * @param latitude
     *            纬度
     * @param longitude
     *            经度
     * @return 是否是高德地图可用数据
     * @since 2.1.0
     */
    static isAMapDataAvailable(latitude: number, longitude: number): boolean;
    /**
     * 计算两点间距离 单位：米
     * @param startLatlng 起点
     * @param endLatlng 终点
     * @return 两点间距离 单位：米
     * @since 3.3.0
     */
    static calculateLineDistance(l29: DPoint, m29: DPoint): number;
}
