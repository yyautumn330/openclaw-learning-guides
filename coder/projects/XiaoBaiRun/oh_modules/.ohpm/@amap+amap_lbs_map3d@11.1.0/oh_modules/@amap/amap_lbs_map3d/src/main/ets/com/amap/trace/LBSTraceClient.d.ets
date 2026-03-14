// @keepTs
// @ts-nocheck
import ArrayList from "@ohos.util.ArrayList";
import { TraceLocation } from "./TraceLocation";
import { TraceListener } from "./TraceListener";
import { TraceStatusListener } from "./TraceStatusListener";
/**
 * 轨迹纠偏类，对行车GPS高精度定位轨迹集合纠偏
 *
 * @author zxy
 * @since 2.2.5
 */
export declare class LBSTraceClient {
    /**
     * 用于{@link #queryProcessedTrace(int, List, int, TraceListener)} type 坐标系类型为高德
     * @since 2.2.5
     */
    static readonly TYPE_AMAP: number;
    /**
     * 用于{@link #queryProcessedTrace(int, List, int, TraceListener)} type 坐标系类型为GPS原始坐标
     * @since 2.2.5
     */
    static readonly TYPE_GPS: number;
    /**
     * 用于{@link #queryProcessedTrace(int, List, int, TraceListener)} type 坐标系类型为百度
     * @since 2.2.5
     */
    static readonly TYPE_BAIDU: number;
    /**
     * 轨迹纠偏错误信息，轨迹点太少或距离太近,轨迹纠偏失败
     * @since 2.2.5
     */
    static readonly MIN_GRASP_POINT_ERROR: string;
    /**
     * 轨迹纠偏错误信息，定位超时
     * @since 2.2.5
     */
    static readonly LOCATE_TIMEOUT_ERROR: string;
    /**
     * 轨迹纠偏错误信息，纠偏运行正常
     * @since 2.2.5
     */
    static readonly TRACE_SUCCESS: string;
    private static f292?;
    private static g292?;
    /**
     * 轨迹纠偏构造函数
     *
     * @param context context对象，不能为空。
     * @since 2.2.5
     */
    constructor(context?: Context);
    /**
     * 获取LBSTraceClient
     * @param context context对象，不能为空。
     * @return 返回LBSTraceClient对象
     * @since 2.2.5
     */
    static getInstance(context: Context): LBSTraceClient;
    private static init;
    /**
     *
     * @param lineID
     *            用于标示一条轨迹，支持多轨迹纠偏，如果多条轨迹调起纠偏接口，则lineID需不同
     * @param locations
     *            一条轨迹的点集合，目前支持该点集合为一条行车GPS高精度定位轨迹
     * @param type
     *            轨迹坐标系，目前支持高德 {@link #TYPE_AMAP};GPS
     *            {@link #TYPE_GPS}TYPE_GPS;百度 {@link #TYPE_BAIDU}
     * @param listener
     *            轨迹纠偏回调
     * @since 2.2.5
     */
    queryProcessedTrace(e292: number, locations: ArrayList<TraceLocation>, type: number, listener: TraceListener): void;
    /**
     * 设置定位间隔
     * @param locationInterval 时间间隔，单位为毫秒，默认为2000毫秒
     * @since 2.2.5
     */
    private t290;
    /**
     * 设置多少个点后回调一次轨迹状态
     * @param interval 默认为20，最小间隔为2
     * @since 2.2.5
     */
    private u290;
    /**
     * 开始记录轨迹，定位间隔2s，每隔5个点合并请求一次纠偏并回调。
     * @param traceStatusListener 回调监听
     * @since 2.2.5
     */
    startTrace(c292: TraceStatusListener): void;
    /**
     * 停止记录轨迹
     * @since 2.2.5
     */
    stopTrace(): void;
    /**
     * 销毁LBSTraceClient
     * @since 2.2.5
     */
    destroy(): void;
    private static i107;
}
