// @keepTs
// @ts-nocheck
import { BusStationResult } from "../busline/BusStationResult";
/**
 * 此接口定义了公交站点查询异步处理回调接口。
 * @since V2.1.0
 */
export interface OnBusStationSearchListener {
    /**
     * 公交站点的查询异步处理。
     * @param busStationPagedResult 公交站点的搜索结果。
     * @param resultID 返回结果成功或者失败的响应码。1000为成功(V3.2.1之后搜索成功响应码为1000，之前版本为0)，其他为失败（详细信息参见网站开发指南-错误码对照表）。
     * @since V2.1.0
     */
    onBusStationSearched: (busStationPagedResult: BusStationResult | undefined, resultID: number) => void;
}
