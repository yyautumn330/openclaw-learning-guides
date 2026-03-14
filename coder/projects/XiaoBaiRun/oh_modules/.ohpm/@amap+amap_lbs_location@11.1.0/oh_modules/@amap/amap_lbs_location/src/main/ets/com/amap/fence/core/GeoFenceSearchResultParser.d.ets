// @keepTs
// @ts-nocheck
import ArrayList from "@ohos.util.ArrayList";
import HashMap from "@ohos.util.HashMap";
import { GeoFence } from "../GeoFence";
/**
 * 创建时间：2016-11-7 下午9:09:50
 * 项目名称：AMapLocationSDK2.0
 * @author liqi
 * @version 1.0
 * @since JDK 1.6.0_21
 * 文件名称：FenSearchParse.java
 * 类说明：
 */
export declare class m1 {
    /**
     * 抽稀的阀值
     */
    private static readonly a16;
    /**
     * 达到多少点数再抽稀
     */
    private static readonly b16;
    private static readonly c16;
    private static d16;
    /**
     * 抽稀需要最小的点数
     */
    private static readonly e16;
    constructor();
    /**
     * 解析关键字搜索结果
     * @param str 结果字符串
     * @param geoFenceList geofence结果集合
     * @param bundle geofence属性
     * @return
     */
    a11(str: string, k15: ArrayList<GeoFence>, bundle: HashMap<string, ESObject>): number;
    /**
     * 解析周边搜索结果
     * @param str 结果字符串
     * @param geoFenceList geofence结果集合
     * @param bundle geofence属性
     * @return
     */
    b11(str: string, j15: ArrayList<GeoFence>, bundle: HashMap<string, ESObject>): number;
    /**
     * 解析行政区划搜索结果
     * @param str 结果字符串
     * @param geoFenceList geofence结果集合
     * @param bundle geofence属性
     * @return
     */
    c11(str: string, q14: ArrayList<GeoFence>, bundle: HashMap<string, ESObject>): Promise<number>;
    static nextId(): number;
    /***************************抽稀算法*************************************/
    private u16;
    private reducerDouglas;
    /**
     * 计算当前点到线的垂线距离
     * @param p 当前点
     * @param lineBegin 线的起点
     * @param lineEnd 线的终点
     * @return
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    private v16;
}
export interface Point {
    lat: number;
    lon: number;
}
