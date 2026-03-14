// @keepTs
// @ts-nocheck
import { LatLonPoint } from "../core/LatLonPoint";
/**
 * 定义了火车站点信息
 * @since V3.4.0
 */
export declare class RailwayStationItem {
    private b82?;
    private n74?;
    private j64?;
    private h82?;
    private r68?;
    private i82;
    private j82;
    private k82?;
    /**
     * RailwayStationItem构造方法。
     * @since V3.4.0
     */
    constructor();
    /**
     * 返回站点ID。
     * @return 站点ID。
     * @since V3.4.0
     */
    getID(): string;
    /**
     * 返回站点名称。
     * @return 站点名称。
     * @since V3.4.0
     */
    getName(): string;
    /**
     * 返回站点经纬度。
     * @return 站点经纬度。
     * @since V3.4.0
     */
    getLocation(): LatLonPoint;
    /**
     * 返回站点所在城市adcode。
     * @return 站点所在城市adcode。
     * @since V3.4.0
     */
    getAdcode(): string;
    /**
     * 返回进站时间。发车站即为，发车时间。下车站即为到站时间。
     * @return 火车进站时间。
     * @since V3.4.0
     */
    getTime(): string;
    /**
     * 返回是否为始发站。
     * @return true表示始发站，false表示为非始发站。
     * @since V3.4.0
     */
    isStart(): boolean;
    /**
     * 返回是否为终点站。
     * @return true表示终点站，false表示非终点站。
     * @since V3.4.0
     */
    isEnd(): boolean;
    /**
     * 返回途经站的站点停靠时间，单位，秒（途径站才有这个值）。
     * @return 途经站的站点停靠时间。
     * @since V3.4.0
     */
    getWait(): number;
    /**
     * 设置站点ID。
     * @param id 站点ID。
     * @since V3.4.0
     * @exclude javadoc中不显示。
     */
    setID(id: string): void;
    /**
     * 设置站点名称。
     * @param name 站点名称。
     * @since V3.4.0
     * @exclude javadoc中不显示。
     */
    setName(name: string): void;
    /**
     * 设置站点经纬度。
     * @param location 站点经纬度。
     * @since V3.4.0
     * @exclude javadoc中不显示。
     */
    setLocation(location: LatLonPoint): void;
    /**
     * 设置站点所在城市的adcode。
     * @param adcode 站点所在城市adcode。
     * @since V3.4.0
     * @exclude javadoc中不显示。
     */
    j34(g82: string): void;
    /**
     * 设置进站时间。
     * @param time 火车进站时间。
     * @since V3.4.0
     * @exclude javadoc中不显示。
     */
    setTime(time: string): void;
    /**
     * 设置是否为始发站。
     * @param isStart 是否为始发站。
     * @since V3.4.0
     * @exclude javadoc中不显示。
     */
    k34(f82: boolean): void;
    /**
     * 设置是否为终点站。
     * @param isEnd 是否为终点站。
     * @since V3.4.0
     * @exclude javadoc中不显示。
     */
    l34(isEnd: boolean): void;
    /**
     * 设置途径站点的等候时间，秒。
     * @param waittime 途经站的等候时间。
     * @since V3.4.0
     * @exclude javadoc中不显示。
     */
    n34(e82: number): void;
    /**
     * @exclude javadoc中不显示。
     */
    q2(): number;
}
