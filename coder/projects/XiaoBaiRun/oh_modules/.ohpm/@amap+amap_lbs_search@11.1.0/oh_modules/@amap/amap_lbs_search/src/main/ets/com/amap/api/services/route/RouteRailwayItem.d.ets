// @keepTs
// @ts-nocheck
import ArrayList from "@ohos.util.ArrayList";
import { Railway } from "./Railway";
import { RailwaySpace } from "./RailwaySpace";
import { RailwayStationItem } from "./RailwayStationItem";
/**
 * 火车乘坐信息
 * @since V3.4.0
 */
export declare class RouteRailwayItem extends Railway {
    private r68?;
    private g84?;
    private m54?;
    private d60?;
    private h84?;
    private i84?;
    private j84;
    private k84;
    private l84;
    /**
     * RouteRailwayItem构造方法。
     * @since V3.4.0
     * @exclude javadoc中不显示。
     */
    RouteRailwayItem(): void;
    /**
     * 返回该线路车段耗时。
     * @return 改路段耗时，单位：秒。
     * @since V3.4.0
     */
    getTime(): string;
    /**
     * 返回线路车次号。
     * @return 线路车次号。
     * @since V3.4.0
     */
    getTrip(): string;
    /**
     * 返回该换乘段的行车总距离。
     * @return 行车距离。
     * @since V3.4.0
     */
    getDistance(): number;
    /**
     * 返回线路车次信息。
     * @return 线路车次信息。
     * @since V3.4.0
     */
    getType(): string;
    /**
     * 返回火车发站信息。
     * @return 火车发站信息。
     * @since V3.4.0
     */
    getDeparturestop(): RailwayStationItem;
    /**
     * 返回火车到站信息。
     * @return 到站信息。
     * @since V3.4.0
     */
    getArrivalstop(): RailwayStationItem;
    /**
     * 返回途经站信息。
     * @return 途经站信息。
     * @since V3.4.0
     */
    getViastops(): ArrayList<RailwayStationItem>;
    /**
     * 返回备选方案 。
     * @return 备选方案。
     * @since V3.4.0
     */
    getAlters(): ArrayList<Railway>;
    /**
     * 返回舱位及价格信息。
     * @return 舱位及价格信息。
     * @since V3.4.0
     */
    getSpaces(): ArrayList<RailwaySpace>;
    /**
     * 设置该线路车段耗时。
     * @param time 耗时，秒。
     * @since V3.4.0
     * @exclude javadoc中不显示。
     */
    setTime(time: string): void;
    /**
     * 设置线路车次号。
     * @param trip 线路车次号。
     * @since V3.4.0
     * @exclude javadoc中不显示。
     */
    s34(f84: string): void;
    /**
     * 设置该换乘段的行车总距离。
     * @param distance 该换乘段的行车总距离。
     * @since V3.4.0
     * @exclude javadoc中不显示。
     */
    setDistance(distance: number): void;
    /**
     * 设置线路车次类型
     * @param type 线路车次类型。
     * @since V3.4.0
     * @exclude javadoc中不显示。
     */
    setType(type: string): void;
    /**
     * 设置火车发站信息。
     * @param departurestop 火车发站信息。
     * @since V3.4.0
     * @exclude javadoc中不显示。
     */
    t34(e84: RailwayStationItem): void;
    /***
     * 设置火车到站信息。
     * @param arrivalstop 火车到站信息。
     * @since V3.4.0
     * @exclude javadoc中不显示。
     */
    u34(d84: RailwayStationItem): void;
    /**
     * 设置途径站点信息。
     * @param viastops 途径站点信息。
     * @since V3.4.0
     * @exclude javadoc中不显示。
     */
    v34(c84: ArrayList<RailwayStationItem>): void;
    /**
     * 设置备选方案。
     * @param alters 备选方案。
     * @since V3.4.0
     * @exclude javadoc中不显示。
     */
    w34(b84: ArrayList<Railway>): void;
    /**
     * 设置舱位及价格信息。
     * @param spaces 舱位及价格信息。
     * @since V3.4.0
     * @exclude javadoc中不显示。
     */
    x34(a84: ArrayList<RailwaySpace>): void;
    /**
     * @exclude javadoc中不显示。
     */
    q2(): number;
}
