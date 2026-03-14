// @keepTs
// @ts-nocheck
import { LatLonPoint } from "../core/LatLonPoint";
/**
 * 子类POI（Point Of Interest，兴趣点）
 */
export declare class SubPoiItem {
    private l61;
    private o54;
    private y65;
    private m54;
    private z65;
    private p54;
    private a66;
    constructor(id: string);
    /**
     * 返回子POI 的id，即其唯一标识。
     * @return 子poi的ID。
     * @since V1.0.0
     */
    getPoiId(): string;
    /**
     * 设置子poi的ID.
     * @param poiId 子poi的ID。
     * @exclude javadoc中不显示
     */
    setPoiId(x65: string): void;
    /**
     * 返回POI全称，如“北京大学(西2门)”。
     * @return poi名称。
     * @since V1.0.0
     */
    getTitle(): string | undefined;
    /**
     * 设置POI名称。
     * @param title poi名称。
     */
    setTitle(title: string | undefined): void;
    /**
     * 返回子POI的子名称，如“西2门”
     * @return 子POI的子名称。
     * @since V1.0.0
     */
    getSubName(): string | undefined;
    /**
     * 设置子POI的子名称。
     * @param subName 子POI的子名称。
     */
    setSubName(w65: string | undefined): void;
    /**
     * 子poi距离中心点的距离。仅在周边搜索时返回距离，关键字搜索时该字段返回0。
     * @return 子POI 到中心点的距离，单位：米。
     * @since V1.0.0
     */
    getDistance(): number | undefined;
    /**
     * 设置子poi距离中心点的距离。
     * @param distance 子POI 到中心点的距离，单位：米。
     */
    setDistance(distance: number | undefined): void;
    /**
     * 返回子POI的坐标。
     * @return 子poi的坐标。
     * @since V1.0.0
     */
    getLatLonPoint(): LatLonPoint | undefined;
    /**
     * 设置子POI的坐标。
     * @param latLonPoint 子poi的坐标。
     * @exclude javadoc中不显示
     */
    setLatLonPoint(v65: LatLonPoint | undefined): void;
    /**
     * 返回子POI的地址。
     * @return 子POI的地址。
     * @since V1.0.0
     */
    getSnippet(): string | undefined;
    /**
     * 设置子POI的地址。
     * @param snippet 子POI的地址。
     */
    setSnippet(snippet: string | undefined): void;
    /**
     * 返回子POI的类型。
     * @return 子POI的类型。
     * @since V1.0.0
     */
    getSubTypeDes(): string | undefined;
    /**
     * 设置子POI的类型。
     * @param subTypeDes 子POI的类型。
     */
    setSubTypeDes(u65: string | undefined): void;
}
