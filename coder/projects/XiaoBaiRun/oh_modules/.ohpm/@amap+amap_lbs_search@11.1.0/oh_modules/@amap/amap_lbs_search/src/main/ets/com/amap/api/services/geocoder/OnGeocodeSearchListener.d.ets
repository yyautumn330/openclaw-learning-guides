// @keepTs
// @ts-nocheck
import { GeocodeResult } from "./GeocodeResult";
import { ReGeocodeResult } from "./ReGeocodeResult";
/**
 * 此接口定义了逆地理编码异步处理回调接口。
 * @since V1.0.0
 */
export interface OnGeocodeSearchListener {
    /**
     * 根据给定的经纬度和最大结果数返回逆地理编码的结果列表。逆地理编码兴趣点返回结果最大返回数目为10，道路和交叉路口返回最大数目为3。
     * @param reGeocodeResult 逆地理编码返回的结果。
     * @param errorCode 返回结果成功或者失败的响应码。1000为成功(V3.2.1之后搜索成功响应码为1000，之前版本为0)，其他为失败（详细信息参见网站开发指南-错误码对照表）。
     * @since V1.0.0
     */
    onReGeocodeSearched: (reGeocodeResult: ReGeocodeResult | undefined, errorCode: number) => void;
    /**
     * 根据给定的地理名称和查询城市，返回地理编码的结果列表。地理编码返回结果集默认最大返回数目为10。
     * @param geocodeResult 地理编码返回的结果。
     * @param errorCode 返回结果成功或者失败的响应码。1000为成功(V3.2.1之后搜索成功响应码为1000，之前版本为0)，其他为失败（详细信息参见网站开发指南-错误码对照表）。
     * @since V1.0.0
     */
    onGeocodeSearched: (geocodeResult: GeocodeResult | undefined, errorCode: number) => void;
}
