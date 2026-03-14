// @keepTs
// @ts-nocheck
import { BusLineResult } from "../busline/BusLineResult";
/**
 * 此接口定义了公交线路查询异步处理回调接口。
 * @since V2.1.0
 */
export interface OnBusLineSearchListener {
    /**
     * 公交路线的查询异步处理。
     * @param busLinePagedResult 公交线路搜索结果。
     * @param resultID 返回结果成功或者失败的响应码。1000为成功(V3.2.1之后搜索成功响应码为1000，之前版本为0)，其他为失败（详细信息参见网站开发指南-错误码对照表）。
     * @since V2.1.0
     */
    onBusLineSearched: (busLinePagedResult: BusLineResult | undefined, resultID: number) => void;
}
