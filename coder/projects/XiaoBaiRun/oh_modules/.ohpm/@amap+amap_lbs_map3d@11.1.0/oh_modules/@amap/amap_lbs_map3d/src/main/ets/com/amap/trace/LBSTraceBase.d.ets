// @keepTs
// @ts-nocheck
import ArrayList from "@ohos.util.ArrayList";
import { TraceListener } from "./TraceListener";
import { TraceLocation } from "./TraceLocation";
import { TraceStatusListener } from "./TraceStatusListener";
/**
 * @author zxy
 * @exclude javadoc中不显示
 */
export interface u288 {
    /**
     * 发起轨迹纠偏
     * @param lineID
     *            用于标示一条轨迹，支持多轨迹纠偏，如果多条轨迹调起纠偏接口，则lineID需不同
     * @param locations
     *            一条轨迹的点集合，目前支持该点集合为一条行车GPS高精度定位轨迹
     * @param type
     *            轨迹坐标系，目前支持高德 LBSTraceClient.TYPE_AMAP;GPS
     *            LBSTraceClient.TYPE_GPS;百度 LBSTraceClient.TYPE_BAIDU
     * @param listener
     *            轨迹纠偏回调
     * @since 2.2.5
     */
    queryProcessedTrace(lineID: number, locations: ArrayList<TraceLocation>, type: number, listener: TraceListener): void;
    /**
     * 设置定位间隔，默认为2000毫秒
     * @param locationInterval
     * @since 2.2.5
     */
    t290(locationInterval: number): void;
    /**
     * 设置多少个点后回调一次轨迹状态，默认为20
     * @param interval
     * @since 2.2.5
     */
    u290(interval: number): void;
    /**
     * 开始记录轨迹
     * @param traceStatusListener
     * @since 2.2.5
     */
    startTrace(traceStatusListener: TraceStatusListener): void;
    /**
     * 停止记录轨迹
     * @since 2.2.5
     */
    stopTrace(): void;
    /**
     * 销毁轨迹纠偏实例
     * @since 2.2.5
     */
    destroy(): void;
}
