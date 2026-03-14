// @keepTs
// @ts-nocheck
import { GeoFence } from "./GeoFence";
import ArrayList from "@ohos.util.ArrayList";
/**
 * 地理围栏回调接口
 *
 * @创建时间：2016年11月4日 下午3:27:41 @项目名称： AMapLocationSDK
 * @author hongming.wang
 * @文件名称：GeoFenceListener.java
 * @类型名称：GeoFenceListener
 * @since 3.3.0
 */
export interface GeoFenceListener {
    /**
     * 创建地理围栏的回调
     * @param geoFenceList
     *            本次创建的围栏列表（创建成功才有，不成功为空）
     * @param errorCode
     *            错误码
     * @param customId
     *            本次操作对应的自定义业务ID(如果有，如果添加的时候没有设置customId,回调中也不会有)
     * @since 3.3.0
     * @author hongming.wang
     *
     */
    onGeoFenceCreateFinished: (geoFenceList: ArrayList<GeoFence>, errorCode: number, customId: string) => void;
}
