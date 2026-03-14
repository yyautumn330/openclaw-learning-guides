// @keepTs
// @ts-nocheck
import { LatLonPoint } from "../core/LatLonPoint";
/**
 * 定义了一个子POI类
 * @since V1.0.0
 */
export declare class SubPoiItemV2 {
    private l61;
    private o54;
    private z65;
    private p54;
    private a66;
    private h55;
    /**
     * SubPoiItemV2 构造函数
     * @param id POI 的标识。
     * @param point 该POI的位置。
     * @param title 该POI的名称。
     * @param snippet POI的地址。
     * @since V1.0.0
     */
    constructor(id: string | undefined, point: LatLonPoint | undefined, title: string | undefined, snippet: string | undefined);
    /**
     * 返回子POI 的id，即其唯一标识。
     * @return 子poi的ID。
     * @since V1.0.0
     */
    getPoiId(): string | undefined;
    /**
     * 设置子poi的ID.
     * @param poiId 子poi的ID。
     * @exclude javadoc中不显示
     */
    setPoiId(d66: string | undefined): void;
    /**
     * 返回POI全称，如“北京大学(西2门)”。
     * @return poi名称。
     * @since V1.0.0
     */
    getTitle(): string | undefined;
    /**
     * 设置POI名称。
     * @param title poi名称。
     * @exclude javadoc中不显示
     */
    setTitle(title: string | undefined): void;
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
    setLatLonPoint(c66: LatLonPoint | undefined): void;
    /**
     * 返回子POI的地址。
     * @return 子POI的地址。
     * @since V1.0.0
     */
    getSnippet(): string | undefined;
    /**
     * 设置子POI的地址。
     * @param snippet 子POI的地址。
     * @exclude javadoc中不显示
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
    setSubTypeDes(b66: string | undefined): void;
    /**
     * 返回子POI的分类编码
     * @return 子POI的分类编码。
     * @since V1.0.0
     */
    getTypeCode(): string | undefined;
    /**
     * 设置子POI的分类编码。
     * @param typeCode 子POI的分类编码。
     */
    setTypeCode(typeCode: string | undefined): void;
}
