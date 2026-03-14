// @keepTs
// @ts-nocheck
import ArrayList from "@ohos.util.ArrayList";
import { LatLng } from "../api/model/LatLng";
/**
 * 轨迹纠偏回调
 *
 * @author zxy
 * @since 2.2.5
 */
export interface TraceListener {
    /**
     * 轨迹纠偏失败回调
     *
     * @param lineID
     *            用于标示一条轨迹，支持多轨迹纠偏，如果多条轨迹调起纠偏接口，则lineID需不同
     * @param errorInfo
     *            轨迹纠偏失败原因
     * @since 2.2.5
     */
    onRequestFailed: (lineID: number, errorInfo: string) => void;
    /**
     * 轨迹纠偏过程回调，一条轨迹分割为多个段，按索引顺序回调其中一段
     *
     * @param lineID
     *            用于标示一条轨迹，支持多轨迹纠偏，如果多条轨迹调起纠偏接口，则lineID需不同
     * @param index
     *            一条轨迹分割为多个段,标示当前轨迹段索引
     * @param segments
     *            一条轨迹分割为多个段，segments标示当前轨迹段经过纠偏后经纬度点集合
     * @since 2.2.5
     */
    onTraceProcessing: (lineID: number, index: number, segments: ArrayList<LatLng>) => void;
    /**
     * 轨迹纠偏成功回调
     *
     * @param lineID
     *            用于标示一条轨迹，支持多轨迹纠偏，如果多条轨迹调起纠偏接口，则lineID需不同
     * @param linepoints
     *            整条轨迹经过纠偏后点的经纬度集合
     * @param distance
     *            该轨迹经过纠偏后总距离，单位米
     * @param waitingtime
     *            该轨迹中间停止时间，以GPS速度为参考，单位秒
     * @since 2.2.5
     */
    onFinished: (lineID: number, linepoints: ArrayList<LatLng>, distance: number, waitingtime: number) => void;
}
