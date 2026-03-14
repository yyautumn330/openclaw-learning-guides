// @keepTs
// @ts-nocheck
import { LatLonPoint } from "../core/LatLonPoint";
import ArrayList from "@ohos.util.ArrayList";
export declare class DrivePlanStep {
    private w75?;
    private j54?;
    private m54;
    private x75;
    private y75;
    /**
     * 返回驾车路段的道路名称。
     * @return 驾车路段的道路名称。
     * @since V6.9.0
     */
    getRoad(): string;
    /**
     * 设置驾车路段区域代码。
     * @param adCode 驾车路段区域代码。
     * @since V6.9.0
     * @exclude javadoc中不显示。
     */
    setAdCode(v75: string): void;
    /**
     * 返回驾车路段的区域代码。
     * @return 驾车路段的区域代码。
     * @since V6.9.0
     */
    getAdCode(): string;
    /**
     * 设置驾车路段的道路名称。
     * @param road 驾车路段的道路名称。
     * @since V6.9.0
     * @exclude javadoc中不显示。
     */
    z32(u75: string): void;
    /**
     * 返回驾车路段的距离，单位米。
     * @return 驾车路段的距离。
     * @since V6.9.0
     */
    getDistance(): number;
    /**
     * 设置驾车路段的距离，单位米。
     * @param distance 驾车路段的距离。
     * @since V6.9.0
     * @exclude javadoc中不显示。
     */
    setDistance(distance: number): void;
    /**
     * 返回驾车路段是否收费。
     * @return 驾车路段的收费价格。
     * @since V6.9.0
     */
    getToll(): boolean;
    /**
     * 设置驾车路段是否收费。
     * @param toll 驾车路段的收费价格。
     * @since V6.9.0
     * @exclude javadoc中不显示。
     */
    d35(t75: boolean): void;
    /**
     * 返回驾车路段的坐标点集合。
     * @return 驾车路段的坐标点集合。
     * @since V6.9.0
     */
    getPolyline(): ArrayList<LatLonPoint>;
    /**
     * 设置驾车路段的坐标点集合。
     * @param polyline 驾车路段的坐标点集合。
     * @since V6.9.0
     * @exclude javadoc中不显示。
     */
    setPolyline(polyline: ArrayList<LatLonPoint>): void;
}
