// @keepTs
// @ts-nocheck
import ArrayList from "@ohos.util.ArrayList";
import { LatLonPoint } from "../core/LatLonPoint";
import { BusStationItem } from "./BusStationItem";
/**
 * 此类定义了公交线路信息。
 * @since V2.1.0
 */
export declare class BusLineItem {
    private distance?;
    private l1?;
    private m1?;
    private cityCode?;
    private n1;
    private bounds;
    private o1?;
    private q1?;
    private s1?;
    private t1?;
    private u1?;
    private v1?;
    private w1?;
    private z1?;
    private a2;
    /**
     * BusLineItem的构造方法。
     * @since V2.1.0
     * @exclude javadoc中不显示 内部使用接口
     */
    constructor();
    /**
     * 返回公交线路全程里程，单位千米。
     * @return 公交线路全程里程。
     * @since V2.1.0
     */
    getDistance(): number;
    /**
     * 设置公交线路全程里程，单位千米。
     * @param distance 公交线路全程里程数。
     * @since V2.1.0
     * @exclude javadoc中不显示 内部使用接口
     */
    setDistance(distance: number): void;
    /**
     * 返回公交线路的名称，包含线路编号和文字名称、类型、首发站、终点站。
     * @return 公交线路的名称，包含线路编号和文字名称、类型、首发站、终点站。。
     * @since V2.1.0
     */
    getBusLineName(): string;
    /**
     * 设置公交线路的名称。
     * @param busLineName 公交线路的名称。
     * @since V2.1.0
     * @exclude javadoc中不显示 内部使用接口
     */
    b2(z66: string): void;
    /**
     * 返回公交线路的类型，类型为中文名称。
     * 公交线路的类型有普通公交、地铁、轻轨、 有轨电车、无轨电车、 旅游专线、 机场大巴、 社区专车、 磁悬浮列车、 轮渡、 索道交通、 其他。
     * @return 公交线路的类型
     * @since V2.1.0
     */
    getBusLineType(): string;
    /**
     * 设置公交线路的类型。
     * @param busLineType 公交线路的类型。
     * @since V2.1.0
     * @exclude javadoc中不显示 内部使用接口
     */
    c2(y66: string): void;
    /**
     * 返回公交线路的城市编码。城市编码参考请在网站“相关下载”处获取。
     * @return 公交线路的城市编码。
     * @since V2.1.0
     */
    getCityCode(): string;
    /**
     * 设置公交线路的城市编码。城市编码参考请在网站“相关下载”处获取。
     * @param cityCode 公交线路的城市编码。
     * @since V2.1.0
     * @exclude javadoc中不显示 内部使用接口
     */
    setCityCode(cityCode: string): void;
    /**
     * 返回公交线路的沿途坐标，包含首发站和终点站坐标。
     * @return 公交线路的沿途坐标。
     * @since V2.1.0
     */
    getDirectionsCoordinates(): ArrayList<LatLonPoint>;
    /**
     * 设置公交线路的沿途坐标，包含首发站和终点站坐标。
     * @param directionsCoordinates 公交线路的沿途坐标。
     * @since V2.1.0
     * @exclude javadoc中不显示 内部使用接口
     */
    d2(x66: ArrayList<LatLonPoint>): void;
    /**
     * 返回公交线路外包矩形的左下与右上顶点坐标。
     * @return 公交线路外包矩形的左下右上顶点坐标。
     * @since V2.1.0
     */
    getBounds(): ArrayList<LatLonPoint>;
    /**
     * 设置公交线路外包矩形的左下与右上顶点坐标。
     * @param bounds 公交线路外包矩形的左下右上顶点坐标。
     * @since V2.1.0
     * @exclude javadoc中不显示 内部使用接口
     */
    setBounds(bounds: ArrayList<LatLonPoint>): void;
    /**
     * 返回公交线路的唯一ID。
     * @return 公交线路的唯一ID。
     * @since V2.1.0
     */
    getBusLineId(): string;
    /**
     * 设置公交线路的唯一ID。
     * @param busLineId 公交线路的唯一ID。
     * @since V2.1.0
     * @exclude javadoc中不显示 内部使用接口
     */
    e2(w66: string): void;
    /**
     * 返回公交线路的始发站名称。
     * @return 公交线路的始发站名称。
     * @since V2.1.0
     */
    getOriginatingStation(): string;
    /**
     * 设置公交线路的始发站名称。
     * @param originatingStation 公交线路的始发站名称。
     * @since V2.1.0
     * @exclude javadoc中不显示 内部使用接口
     */
    f2(v66: string): void;
    /**
     * 返回公交线路的终点站名称。
     * @return 公交线路的终点站名称。
     * @since V2.1.0
     */
    getTerminalStation(): string;
    /**
     * 设置公交线路的终点站名称。
     * @param terminalStation 公交线路的终点站名称。
     * @since V2.1.0
     * @exclude javadoc中不显示 内部使用接口
     */
    g2(u66: string): void;
    /**
     * 返回公交线路的首班车时间。格式为“HHMM”,时间为24小时制(0000--2359)。
     * @return 公交线路的首班车时间。
     * @since V2.1.0
     */
    getFirstBusTime(): Date;
    /**
     * 设置公交线路的首班车时间。格式为“HHMM”,时间为24小时制(0000--2359)。
     * @param firstBusTime 公交线路的首班车时间。
     * @since V2.1.0
     * @exclude javadoc中不显示 内部使用接口
     */
    h2(t66: Date): void;
    /**
     * 返回公交线路的末班车时间。格式为“HHMM”,时间为24小时制(0000--2359)。
     * @return 返回公交线路的末班车时间。
     * @since V2.1.0
     *
     */
    getLastBusTime(): Date;
    /**
     * 设置公交线路的末班车时间。格式为“HHMM”,时间为24小时制(0000--2359)。
     * @param lastBusTime 返回公交线路的末班车时间。
     * @since V2.1.0
     * @exclude javadoc中不显示 内部使用接口
     */
    i2(s66: Date): void;
    /**
     * 返回公交线路所属的公交公司。
     * @return 公交线路所属的公交公司。
     * @since V2.1.0
     */
    getBusCompany(): string;
    /**
     * 设置公交线路所属的公交公司。
     * @param busCompany 公交线路所属的公交公司。
     * @since V2.1.0
     * @exclude javadoc中不显示 内部使用接口
     */
    j2(r66: string): void;
    /**
     * 返回公交线路的起步价，单位元。
     * @return 公交线路的起步价。
     * @since V2.1.0
     */
    getBasicPrice(): number;
    /**
     * 设置公交线路的起步价，单位元。
     * @param basicPrice 公交线路的起步价。
     * @since V2.1.0
     * @exclude javadoc中不显示 内部使用接口
     */
    l2(q66: number): void;
    /**
     * 返回公交线路的全程票价，单位元。
     * @return 公交线路的全程票价。
     * @since V2.1.0
     */
    getTotalPrice(): number;
    /**
     * 设置公交线路的全程票价，单位元。
     * @param totalPrice 公交线路的全程票价。
     * @since V2.1.0
     * @exclude javadoc中不显示 内部使用接口
     */
    m2(p66: number): void;
    /**
     * 返回公交线路的站点列表。此列表返回的公交站数据有ID、站名、经纬度、序号。
     * @return 公交线路的站点列表。
     * @since V2.1.0
     */
    getBusStations(): ArrayList<BusStationItem>;
    /**
     * 设置公交线路的站点列表。
     * @param busStations 公交线路的站点列表。
     * @since V2.1.0
     * @exclude javadoc中不显示 内部使用接口
     */
    n2(o66: ArrayList<BusStationItem>): void;
    /**
     * 将公交线路信息转换为字符串输出。
     * @return 返回公交线路名称和首末班车时间的字符串。
     */
    toString(): string;
    /**
     * @exclude javadoc中不显示。
     */
    q2(): number;
}
