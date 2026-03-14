// @keepTs
// @ts-nocheck
import { OnLocationChangedListener } from "../../api/LocationSource";
import { u288 } from "../LBSTraceBase";
import geoLocationManager from "@ohos.geoLocationManager";
import { TraceListener } from "../TraceListener";
import { TraceLocation } from "../TraceLocation";
import { TraceStatusListener } from "../TraceStatusListener";
import ArrayList from "@ohos.util.ArrayList";
export declare class c285 implements u288, OnLocationChangedListener {
    static readonly w286: number;
    static readonly x286: number;
    static readonly y286: number;
    static readonly v286: string;
    static readonly y289: number;
    static readonly i286: number;
    static readonly a251: number;
    /**
     * 安卓默认是毫秒，我们是秒
     */
    private z289;
    private a290;
    private b290?;
    private c290?;
    /**所有定位点*/
    private d290;
    private e290;
    private f290;
    private g290;
    private h290?;
    /**
     * 每次请求最多点数
     */
    private static readonly i290;
    /**
     * 默认的轨迹请求id
     */
    private static readonly j290;
    /**
     * 两个定位点距离如果超过这个值，则认为是发生定位点漂移
     */
    private static readonly k290;
    /**
     * 最终纠偏结果列表，已经确认的纠偏结果，即请求滑块之前的数据
     */
    private l290;
    /**
     * 返回用户的纠偏数据，由 最终纠偏结果列表 和 缓存纠偏结果列表 组合而成
     */
    private m290;
    /**
     * 缓存纠偏结果列表
     */
    private n290;
    private mContext?;
    private o290?;
    private p290?;
    private q290;
    private r290;
    /**
     * 回传用户数据
     * @param lineID
     * @param linepoints
     */
    private s290;
    /**
     * 轨迹纠偏构造函数
     *
     * @param context
     */
    constructor(context: Context);
    /**
     * @param lineID    用于标示一条轨迹，支持多轨迹纠偏，如果多条轨迹调起纠偏接口，则lineID需不同
     * @param locations 一条轨迹的点集合，目前支持该点集合为一条行车GPS高精度定位轨迹
     * @param type      轨迹坐标系，目前支持高德 LBSTraceClient.TYPE_AMAP;GPS
     *                  LBSTraceClient.TYPE_GPS;百度 LBSTraceClient.TYPE_BAIDU
     * @param listener  轨迹纠偏回调
     */
    queryProcessedTrace(m289: number, locations: ArrayList<TraceLocation>, type: number, listener: TraceListener): void;
    t290(l289: number): void;
    u290(interval: number): void;
    /**
     * 开始采集
     *
     * @param traceStatusListener
     */
    startTrace(k289: TraceStatusListener): void;
    /**
     * 停止记录轨迹,表示一单完成，需要清除当前已记录的所有东西
     */
    stopTrace(): void;
    /**
     * 停止定位
     */
    private v290;
    /**
     * 停止轨迹纠偏请求 清空轨迹记录
     */
    private w290;
    destroy(): void;
    onLocationChanged(location: geoLocationManager.Location): void;
    private x290;
    private y290;
    /**
     * 获取两点间距离
     * @param x1
     * @param y1
     * @param x2
     * @param y2
     * @return
     */
    private getDistance;
    /**
     * 通过距离法 去纠偏列表中获取纠偏数据
     */
    private z290;
}
