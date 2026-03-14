// @keepTs
// @ts-nocheck
import { DPoint } from "../location/DPoint";
import ArrayList from "@ohos.util.ArrayList";
/**
 * 行政区划对象
 * @项目名称： AMapLocationSDK
 * @类型名称：DistrictItem
 * @since 3.2.0
 */
export declare class q13 {
    /**
     * 行政区划名称
     */
    private districtName;
    /**
     *城市编码
     */
    private citycode?;
    /**
     * 区域编码
     */
    private adcode?;
    /**
     * 行政区划点坐标
     */
    private polyline?;
    constructor();
    /**
     * 获取城市编码
     * @since 3.2.0
     * @return 城市编码
     * @see <a href="http://lbs.amap.com/api/android-location-sdk/download/" target="_blank">POI分类编码表和城市编码表</a>
     */
    y16(): string | undefined;
    /**
     * 设置城市编码
     * @since 3.2.0
     * @exclude
     */
    p16(x16: string): void;
    /**
     * 获取区域编码
     * @return 区域编码
     * @since 3.2.0
     */
    z16(): string | undefined;
    /**
     * 设置城市编码
     * @since 3.2.0
     * @exclude
     */
    q16(w16: string): void;
    /**
     * 获取行政区划轮廓坐标点
     * @return 行政区划轮廓坐标点
     * @since 3.2.0
     */
    a17(): ArrayList<DPoint> | undefined;
    /**
     * 设置行政区划轮廓坐标点
     * @since 3.2.0
     * @exclude
     */
    s16(polyline: ArrayList<DPoint>): void;
    /**
     * 获取行政区划名称
     * @return
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    b17(): string;
    /**
     * 设置行政区划名称
     * @param districtName
     * @since 3.2.0
     * @author hongming.wang
     * @exclude
     */
    r16(districtName: string): void;
}
