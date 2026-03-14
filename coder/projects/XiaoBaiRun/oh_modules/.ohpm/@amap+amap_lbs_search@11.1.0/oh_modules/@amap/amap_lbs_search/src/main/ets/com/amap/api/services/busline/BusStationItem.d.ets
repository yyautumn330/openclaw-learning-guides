// @keepTs
// @ts-nocheck
import { LatLonPoint } from "../core/LatLonPoint";
import ArrayList from "@ohos.util.ArrayList";
import { BusLineItem } from "./BusLineItem";
/**
 * 此类定义了公交站点信息。
 * @since V2.1.0
 */
export declare class BusStationItem {
    private u3;
    private v3;
    private w3?;
    private cityCode;
    private x3;
    private y3;
    /**
     * BusStationItem的构造方法。
     * @since V2.1.0
     * @exclude javadoc中不显示 内部使用接口
     */
    constructor();
    /**
     * 返回车站ID。
     * @return 车站ID。
     * @since V2.1.0
     */
    getBusStationId(): string;
    /**
     * 设置车站ID。
     * @param busStationId 车站ID。
     * @since V2.1.0
     * @exclude javadoc中不显示 内部使用接口
     */
    z3(t3: string): void;
    /**
     * 返回车站名称。
     * @return 车站名称。
     * @since V2.1.0
     */
    getBusStationName(): string;
    /**
     * 设置车站名称。
     * @param busStationName 车站名称。
     * @since V2.1.0
     * @exclude javadoc中不显示 内部使用接口
     */
    a4(s3: string): void;
    /**
     * 返回车站经纬度坐标。
     * @return 车站经纬度坐标。
     * @since V2.1.0
     */
    getLatLonPoint(): LatLonPoint;
    /**
     * 设置车站经纬度坐标。
     * @param latLonPoint 车站经纬度坐标。
     * @since V2.1.0
     * @exclude javadoc中不显示 内部使用接口
     */
    setLatLonPoint(r3: LatLonPoint): void;
    /**
     * 返回车站城市编码。城市编码参考请在网站“相关下载”处获取。
     * @return 车站城市编码。
     * @since V2.1.0
     */
    getCityCode(): string;
    /**
     * 设置车站城市编码。城市编码参考请在网站“相关下载”处获取。
     * @param cityCode 车站城市编码。
     * @since V2.1.0
     * @exclude javadoc中不显示 内部使用接口
     */
    setCityCode(cityCode: string): void;
    /**
     * 返回车站区域编码。
     * @return 车站区域编码。
     * @since V2.1.0
     */
    getAdCode(): string;
    /**
     * 设置车站区域编码。
     * @param adCode 车站区域编码。
     * @since V2.1.0
     * @exclude javadoc中不显示 内部使用接口
     */
    setAdCode(q3: string): void;
    /**
     * 返回途径此公交站的公交路线。列表内的公交路线信息为基本信息。
     * @return 途径此公交站的公交路线。
     * @since V2.1.0
     */
    getBusLineItems(): ArrayList<BusLineItem>;
    /**
     * 设置途径此公交站的公交路线。
     * @param busLineItems 途径此公交站的公交路线。
     * @since V2.1.0
     * @exclude javadoc中不显示 内部使用接口
     */
    b4(p3: ArrayList<BusLineItem>): void;
    /**
     * 将公交站点信息转换为字符串输出。
     * @return 返回公交站名称、经纬度、途径站点、城市编码和车站区域编码的字符串。
     */
    toString(): string;
    private c4;
    /**
     * @exclude javadoc中不显示。
     */
    q2(): number;
}
