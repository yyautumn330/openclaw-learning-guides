// @keepTs
// @ts-nocheck
import ArrayList from "@ohos.util.ArrayList";
import { Doorway } from "./Doorway";
import { RouteBusLineItem } from "./RouteBusLineItem";
import { RouteBusWalkItem } from "./RouteBusWalkItem";
import { RouteRailwayItem } from "./RouteRailwayItem";
import { TaxiItem } from "./TaxiItem";
/**
 * 定义了公交路径规划的一个路段。
 * 路段最多包含一段步行信息和公交导航信息。可能出现路段中没有步行信息的情况。
 * @since V2.1.0
 */
export declare class BusStep {
    private y69?;
    private z69;
    private a70?;
    private b70?;
    private c70?;
    private d70?;
    /**
     * 返回此路段的步行信息。
     * @return 此路段的步行信息。
     * @since V2.1.0
     */
    getWalk(): RouteBusWalkItem;
    /**
     * 设置此路段的步行信息。
     * @param mWalk 此路段的步行信息。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    n33(x69: RouteBusWalkItem): void;
    /**
     * 返回此路段的公交导航信息。目前只返回一条公交线路信息。
     * @return 此路段的公交导航信息。
     * @since V2.1.0
     * @deprecated 此接口废弃。
     */
    getBusLine(): RouteBusLineItem;
    /**
     * 返回此路段的公交导航信息。目前返回多条公交线路信息。
     * @return 此路段的公交导航信息。
     * @since V2.7.0
     */
    getBusLines(): ArrayList<RouteBusLineItem>;
    /**
     * 设置此路段的公交导航信息。
     * @param mBusLine 此路段的公交导航信息。
     * @since V2.1.0
     * @deprecated 此接口废弃。
     * @exclude javadoc中不显示。
     */
    e70(w69: RouteBusLineItem): void;
    /**
     * 设置此路段的公交导航信息。
     * @param mBusLines 此路段的公交导航信息。
     * @since V2.7.0
     * @exclude javadoc中不显示。
     */
    p33(v69: ArrayList<RouteBusLineItem>): void;
    /**
     * 返回此路段的入口信息。
     * 入口信息指换乘地铁时的进站口。
     * @return 此路段的入口信息。
     * @since V2.1.0
     */
    getEntrance(): Doorway;
    /**
     * 设置此路段的入口信息。
     * 入口信息指换乘地铁时的进站口。
     * @param mEntrance 此路段的入口信息。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    r33(u69: Doorway): void;
    /**
     * 返回此路段的出口信息。
     * 出口信息指乘地铁之后的出站口信息。
     * @return 此路段的出口信息。
     * @since V2.1.0
     */
    getExit(): Doorway;
    /**
     * 设置此路段的出口信息。
     * 出口信息指乘地铁之后的出站口信息。
     * @param mExit 此路段的出口信息。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    setExit(t69: Doorway): void;
    /**
     * 返回此路段的火车乘坐信息。
     * @return 此路段的火车乘坐信息。
     * @since V3.4.0
     */
    getRailway(): RouteRailwayItem;
    /**
     * 设置此路段的火车乘坐信息。
     * @param railway 此路段的火车乘坐信息。
     * @since V3.4.0
     * @exclude javadoc中不显示。
     */
    t33(s69: RouteRailwayItem): void;
    /**
     * 返回此路段的出租车信息。
     * @return 此路段的出租车信息。
     * @since V3.4.0
     */
    getTaxi(): TaxiItem;
    /**
     * 设置此路段的出租车信息。
     * @param taxiItem 出租车信息类。
     * @since V3.4.0
     * @exclude javadoc中不显示。
     */
    v33(r69: TaxiItem): void;
    /**
     * @exclude javadoc中不显示。
     */
    q2(): number;
    /**
     * BusStep构造方法。
     * @exclude javadoc中不显示。
     */
    constructor();
}
