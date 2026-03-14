// @keepTs
// @ts-nocheck
import ArrayList from "@ohos.util.ArrayList";
import { LatLng } from "../api/model/LatLng";
import { TraceLocation } from "./TraceLocation";
/**
 * 轨迹记录回调监听
 * <p>
 * @author zxy
 * @since  2.2.5
 */
export interface TraceStatusListener {
    /**
     * 轨迹记录状态回调
     *
     * @param locations 轨迹点
     * @param rectifications 纠偏后的结果
     * @param errorInfo 轨迹纠偏错误信息 {@link LBSTraceClient#TRACE_SUCCESS} 代表纠偏正常
     * @since  2.2.5
     */
    onTraceStatus: (locations?: ArrayList<TraceLocation>, rectifications?: ArrayList<LatLng>, errorInfo?: string) => void;
}
