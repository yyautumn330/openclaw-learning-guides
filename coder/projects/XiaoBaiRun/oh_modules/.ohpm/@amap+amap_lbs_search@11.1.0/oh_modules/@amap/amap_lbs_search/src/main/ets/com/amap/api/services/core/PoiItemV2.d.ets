// @keepTs
// @ts-nocheck
import { Business } from "../poisearch/Business";
import { IndoorDataV2 } from "../poisearch/IndoorDataV2";
import { Photo } from "../poisearch/Photo";
import { PoiNavi } from "../poisearch/PoiNavi";
import { LatLonPoint } from "./LatLonPoint";
import ArrayList from "@ohos.util.ArrayList";
import { SubPoiItemV2 } from "../poisearch/SubPoiItemV2";
/**
 * 定义一个POI（Point Of Interest，兴趣点）。一个POI 由如下成员组成:
 * <p>POI 的唯一标识，即id。这个标识在不同的数据版本中延续。</p>
 * <p>POI 的名称。</p>
 * <p>POI 的经纬度。</p>
 * <p>POI 的地址。</p>
 * <p>POI 的类型代码。</p>
 * <p>POI 的类型描述。</p>
 * <p>POI 的行政区划代码。</p>
 * <p>POI 的行政区划名称。</p>
 * <p>POI 的电话号码。</p>
 * <p>POI 的城市编码。</p>
 * <p>POI 的城市名称。</p>
 * <p>POI 的省/自治区/直辖市/特别行政区名称</p>
 * @since V1.0.0
 */
export declare class PoiItemV2 {
    private h54;
    private j54;
    private k54;
    private l54;
    private n54;
    private o54;
    private p54;
    private h55;
    private w54;
    private x54;
    private y54;
    private b55;
    private e55;
    private w55;
    private a55;
    private x55;
    private f55;
    /**
     * 根据给定的参数构造一个PoiItem 的新对象。
     * @param id  POI 的标识。
     * @param point 该POI的位置。
     * @param title 该POI的名称。
     * @param snippet POI的地址。
     * @since V1.0.0
     */
    constructor(id: string, point: LatLonPoint | undefined, title: string, snippet: string);
    /**
     * 返回POI 的行政区划名称。
     * @return POI 的行政区划名称。
     * @since V1.0.0
     */
    getAdName(): string | undefined;
    /**
     * 设置POI 的行政区划名称。
     * @param adname POI 的行政区划名称。
     * @exclude javadoc中不显示
     */
    setAdName(v55: string | undefined): void;
    /**
     * 返回POI的城市名称。
     * @return POI的城市名称。
     * @since V1.0.0
     */
    getCityName(): string | undefined;
    /**
     * 设置POI 的城市名称。
     * @param cityname POI 的城市名称。
     * @since V1.0.0
     * @exclude javadoc中不显示
     */
    setCityName(u55: string | undefined): void;
    /**
     * 返回POI的省/自治区/直辖市/特别行政区名称 。
     * @return POI的省/自治区/直辖市/特别行政区名称
     * @since V1.0.0
     */
    getProvinceName(): string | undefined;
    /**
     * 设置POI 的省/自治区/直辖市/特别行政区名称。
     * @param provincename POI 的省/自治区/直辖市/特别行政区名称。
     * @since V1.0.0
     * @exclude javadoc中不显示
     */
    setProvinceName(t55: string | undefined): void;
    /**
     * 返回POI 的类型描述。
     * @return POI 的类型描述。
     * @since V1.0.0
     */
    getTypeDes(): string | undefined;
    /**
     * 设置POI 的类型描述。
     * @param typedes POI 的类型描述。
     * @since V1.0.0
     * @exclude javadoc中不显示
     */
    setTypeDes(s55: string | undefined): void;
    /**
     * 返回POI 的行政区划代码。
     * @return POI 的行政区划代码。
     * @since V1.0.0
     */
    getAdCode(): string | undefined;
    /**
     * 设置POI 的行政区划代码。
     * @param adcode POI 的行政区划代码。
     * @since V1.0.0
     * @exclude javadoc中不显示
     */
    setAdCode(r55: string | undefined): void;
    /**
     * 返回POI 的id，即其唯一标识。
     * @return POI的id。
     * @since V1.0.0
     */
    getPoiId(): string | undefined;
    /**
     * 返回POI的名称。
     * @return POI的名称。
     * @since V1.0.0
     */
    getTitle(): string | undefined;
    /**
     * 返回POI的地址。
     * @return POI的地址。
     * @since V1.0.0
     */
    getSnippet(): string | undefined;
    /**
     * 返回POI的经纬度坐标<br>
     *
     * 如果使用该POI进行导航时，可以检查POI是否有PoiNavi.getExit() 和 PoiNavi.getExit()，如果有建议使用它们作为导航的起终点。
     *
     * @return POI的经纬度坐标
     * @since V1.0.0
     */
    getLatLonPoint(): LatLonPoint | undefined;
    /**
     * 返回POI的城市编码
     * @return POI的城市编码
     * @since V1.0.0
     */
    getCityCode(): string | undefined;
    /**
     * 设置POI的城市编码。
     * @param mCityCode POI的城市编码。
     * @since V1.0.0
     * @exclude javadoc中不显示
     */
    setCityCode(q55: string | undefined): void;
    /**
     * 设置 POI 的省/自治区/直辖市/特别行政区编码。
     * @param provinceCode POI 的省/自治区/直辖市/特别行政区编码。
     * @since V1.0.0
     * @exclude javadoc中不显示
     */
    setProvinceCode(p55: string | undefined): void;
    /**
     * 返回 POI 的省/自治区/直辖市/特别行政区编码。
     * @return POI 的省/自治区/直辖市/特别行政区编码。
     * @since V1.0.0
     */
    getProvinceCode(): string | undefined;
    /**
     * 返回兴趣点类型编码。
     * @return POI的类型编码。
     * @since V1.0.0
     */
    getTypeCode(): string | undefined;
    /**
     * 设置兴趣点的类型编码。
     * @param typecode POI的类型编码。
     * @since V1.0.0
     * @exclude javadoc中不显示
     */
    setTypeCode(o55: string | undefined): void;
    /**
     * 设置子POI信息
     * @param subPois 子POI信息。
     * @since V1.0.0
     * @exclude javadoc中不显示
     */
    setSubPois(n55: ArrayList<SubPoiItemV2>): void;
    /**
     * 子POI信息获取。仅当该POI有子POI数据时存在。例：搜索北京大学，POI为北京大学，子POI为“北京大学(西2门)”、北京大学(西3门)等。
     * @return 子POI信息列表
     * @since V1.0.0
     */
    getSubPois(): ArrayList<SubPoiItemV2>;
    /**
     * 设置POI商业信息
     * @param business POI商业信息。
     * @since V1.0.0
     * @exclude javadoc中不显示
     */
    setBusiness(m55: Business | undefined): void;
    /**
     * POI商业信息
     * @return POI商业信息
     * @since V1.0.0
     */
    getBusiness(): Business | undefined;
    /**
     * 设置室内相关信息
     * @param indoorData 室内相关信息。
     * @since V1.0.0
     * @exclude javadoc中不显示
     */
    setIndoorData(l55: IndoorDataV2 | undefined): void;
    /**
     * 室内相关信息
     * @return 室内相关信息
     * @since V1.0.0
     */
    getIndoorData(): IndoorDataV2 | undefined;
    /**
     * 设置导航位置相关信息
     * @param poiNavi 导航位置相关信息。
     * @since V1.0.0
     * @exclude javadoc中不显示
     */
    setPoiNavi(k55: PoiNavi | undefined): void;
    /**
     * 导航位置相关信息
     * @return 导航位置相关信息
     * @since V1.0.0
     */
    getPoiNavi(): PoiNavi | undefined;
    /**
     * 返回POI的图片信息。
     * @return 图片类列表。
     * @since V1.0.0
     */
    getPhotos(): ArrayList<Photo>;
    /**
     * 设置POI的图片信息。
     * @param mPhotos 图片信息列表。
     * @since V1.0.0
     * @exclude javadoc中不显示
     */
    setPhotos(j55: ArrayList<Photo>): void;
    /**
     * @exclude javadoc中不显示
     */
    q2(): number;
    /**
     * 比较两个POI 的id 是否相等。
     * @param obj 要与之比较的引用对象。
     * @return 一个布尔值，如果两个POI 的id 相等，则返回true,否则返回false。
     */
    equals(obj: object): boolean;
    /**
     * 返回POI 的名称（name）。
     * @since V1.0.0
     */
    toString(): string | undefined;
}
