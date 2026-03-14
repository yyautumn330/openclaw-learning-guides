// @keepTs
// @ts-nocheck
import { AMapLocation } from "./AMapLocation";
/**
 * 定位回调接口
 * @创建时间： 2015年10月21日 下午3:52:52
 * @项目名称： AMapLocationSDK
 * @author liqi
 * @version 2.0.0
 * @since 2.0.0
 * @文件名称: AMapLocationListener.java
 * @类型名称: AMapLocationListener
 */
export interface j1 {
    /**
     * 定位回调监听，当定位完成后调用此方法
     * @param location 定位结果信息
     * @since 2.0.0
     */
    onLocationChanged: (location: AMapLocation) => void;
}
