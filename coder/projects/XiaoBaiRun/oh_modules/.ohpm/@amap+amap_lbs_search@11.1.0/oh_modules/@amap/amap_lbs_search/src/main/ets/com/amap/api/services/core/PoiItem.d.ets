// @keepTs
// @ts-nocheck
import { IndoorData } from "../poisearch/IndoorData";
import { Photo } from "../poisearch/Photo";
import { PoiItemExtension } from "../poisearch/PoiItemExtension";
import { SubPoiItem } from "../poisearch/SubPoiItem";
import { LatLonPoint } from "./LatLonPoint";
import ArrayList from "@ohos.util.ArrayList";
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
 * <p>POI距离周边搜索中心点的距离。</p>
 * <p>POI网址。</p>
 * <p>POI邮编。</p>
 * <p>POI电子邮箱。</p>
 * <p>POI在逆地理编码时，POI点相对地理坐标点的方向 。</p>
 * @since V1.0.0
 */
export declare class PoiItem {
    private h54;
    private i54;
    private j54;
    private k54;
    private l54;
    private m54;
    private n54;
    private o54;
    private p54;
    private q54;
    private r54;
    private s54;
    private t54;
    private u54;
    private v54;
    private w54;
    private x54;
    private y54;
    private z54;
    private a55;
    private b55;
    private c55;
    private d55;
    private e55;
    private f55;
    private g55;
    private h55;
    private i55;
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
     * 返回POI的所在商圈。
     * @return POI的所在商圈。
     */
    getBusinessArea(): string | undefined;
    /**
     * 设置POI所在商圈.
     * @param area POI的所在商圈。
     * @exclude javadoc中不显示
     */
    setBusinessArea(area: string | undefined): void;
    /**
     * 返回POI 的行政区划名称。
     * @return POI 的行政区划名称。
  
     */
    getAdName(): string | undefined;
    /**
     * 设置POI 的行政区划名称。
     * @param adname POI 的行政区划名称。
     * @exclude javadoc中不显示
     */
    setAdName(g54: string | undefined): void;
    /**
     * 返回POI的城市名称。
     * @return POI的城市名称。
     */
    getCityName(): string | undefined;
    /**
     * 设置POI 的城市名称。
     * @param cityname POI 的城市名称。
     * @since V1.0.0
     * @exclude javadoc中不显示
     */
    setCityName(f54: string | undefined): void;
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
    setProvinceName(e54: string | undefined): void;
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
    setTypeDes(d54: string): void;
    /**
     * 返回POI的电话号码。
     * @return POI的电话号码。
     * @since V1.0.0
     */
    getTel(): string | undefined;
    /**
     * 设置POI 的电话号码。
     * @param tel POI 的电话号码。
     * @since V1.0.0
     * @exclude javadoc中不显示
     */
    setTel(c54: string | undefined): void;
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
    setAdCode(b54: string | undefined): void;
    /**
     * 返回POI 的id，即其唯一标识。
     * @return POI的id。
     * @since V1.0.0
     */
    getPoiId(): string | undefined;
    /**
     * 获取 POI 距离中心点的距离。
     * @return POI 到中心点的距离，单位：米。返回-1时，代表此字段无数据。
     * @since V1.0.0
     */
    getDistance(): number;
    /**
     * 设置 POI 到中心点的距离。
     * @param distance POI 到中心点的距离，单位：米。
     * @since V1.0.0
     * @exclude javadoc中不显示
     */
    setDistance(distance: number): void;
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
     * 如果使用该POI进行导航时，可以检查POI是否有{@link #getExit()} 和 {@link #getEnter()}，如果有建议使用它们作为导航的起终点。
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
    setCityCode(a54: string | undefined): void;
    /**
     * 返回POI入口经纬度。<br>
     * POI入口一般指商场、停车场等的POI兴趣点入口。<br>
     *
     * 导航时，如果目的地为该POI且POI存在入口，建议使用入口经纬度作为导航终点。
     * @return POI入口经纬度。
     * @since V1.0.0
     */
    getEnter(): LatLonPoint | undefined;
    /**
     * 设置POI入口经纬度。
     * POI入口一般指商场、停车场等的POI兴趣点入口。
     * @param enterPoint POI入口经纬度。
     * @since V1.0.0
     * @exclude javadoc中不显示
     */
    setEnter(z53: LatLonPoint | undefined): void;
    /**
     * 返回POI出口经纬度。<br>
     * POI出口一般指商场、停车场等POI兴趣点的出口。<br>
     *
     * 导航时，如果出发点为该POI且POI存在出口，建议使用出口经纬度作为导航起点。
     * @return POI出口经纬度。 <br></>
     * @since V1.0.0
     */
    getExit(): LatLonPoint | undefined;
    /**
     * 设置POI出口经纬度。
     * POI出口一般指商场、停车场等POI兴趣点的出口。
     * @param exitPoint POI出口经纬度。
     * @since V1.0.0
     * @exclude javadoc中不显示
     */
    setExit(y53: LatLonPoint | undefined): void;
    /**
     * 返回POI的网址。
     * @return POI的网址。
     * @since V1.0.0
     */
    getWebsite(): string | undefined;
    /**
     * 设置POI的网址。
     * @param website POI的网址。
     * @since V1.0.0
     * @exclude javadoc中不显示
     */
    setWebsite(website: string | undefined): void;
    /**
     * 返回POI的邮编。
     * @return POI的邮编。
     * @since V1.0.0
     */
    getPostcode(): string | undefined;
    /**
     * 设置POI的邮编。
     * @param postcode POI的邮编。
     * @since V1.0.0
     * @exclude javadoc中不显示
     */
    setPostcode(postcode: string | undefined): void;
    /**
     * 返回POI的电子邮件地址。
     * @return POI的电子邮件地址。
     * @since V1.0.0
     */
    getEmail(): string | undefined;
    /**
     * 设置POI的电子邮件地址。
     * @param email POI的电子邮件地址。
     * @since V1.0.0
     * @exclude javadoc中不显示
     */
    setEmail(email: string | undefined): void;
    /**
     * 返回逆地理编码查询时POI坐标点相对于地理坐标点的方向。POI搜索时，此处为空。
     * 方向为中文名称，如东、西南等。
     * @return POI坐标点相对于地理坐标点的方向。
     * @since V1.0.0
     */
    getDirection(): string | undefined;
    /**
     * 设置逆地理编码查询时POI坐标点相对于地理坐标点的方向。
     * 方向为中文名称，如东、西南等。
     * @param direction POI坐标点相对于地理坐标点的方向。
     * @since V1.0.0
     * @exclude javadoc中不显示
     */
    setDirection(direction: string | undefined): void;
    /**
     * 设置是否支持室内地图
     * @param isIndoorMap 支持室内地图为true，否则为false。
     * @since V1.0.0
     * @exclude javadoc中不显示
     */
    setIndoorMap(x53: boolean): void;
    /**
     * 返回是否支持室内地图 。
     * @return 支持室内地图返回 true，否则返回 false。
     * @since V1.0.0
     */
    isIndoorMap(): boolean;
    /**
     * 设置 POI 的省/自治区/直辖市/特别行政区编码。
     * @param provinceCode POI 的省/自治区/直辖市/特别行政区编码。
     * @since V1.0.0
     * @exclude javadoc中不显示
     */
    setProvinceCode(w53: string | undefined): void;
    /**
     * 返回 POI 的省/自治区/直辖市/特别行政区编码。
     * @return POI 的省/自治区/直辖市/特别行政区编码。
     * @since V1.0.0
     */
    getProvinceCode(): string | undefined;
    /**
     * 设置POI的停车场类型
     * @param parkType 停车场类型
     * @since V1.0.0
     * @exclude javadoc中不显示
     */
    setParkingType(v53: string | undefined): void;
    /**
     * 返回POI的停车场类型
     * @return 停车场类型。
     * @since V1.0.0
     */
    getParkingType(): string | undefined;
    /**
     * 设置POI的停车场类型
     * @param subPois 停车场类型。
     * @since V1.0.0
     * @exclude javadoc中不显示
     */
    setSubPois(u53: ArrayList<SubPoiItem>): void;
    /**
     * 子POI信息获取。仅当该POI有子POI数据时存在。例：搜索北京大学，POI为北京大学，子POI为“北京大学(西2门)”、北京大学(西3门)等。
     * @return 子POI信息列表
     * @since V1.0.0
     */
    getSubPois(): ArrayList<SubPoiItem>;
    /**
     * 返回POI的室内信息，如楼层、建筑物。
     * @return 室内POI的相关信息
     * @since V3.2.1
     */
    getIndoorData(): IndoorData | undefined;
    /**
     * 设置POI的室内信息。
     * @param indoorDate POI的室内信息。
     * @since V3.2.1
     * @exclude javadoc中不显示
     */
    setIndoorData(t53: IndoorData | undefined): void;
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
    setPhotos(s53: ArrayList<Photo>): void;
    /**
     * 返回POI的扩展信息。
     * @return poi深度信息。
     * @since V1.0.0
     */
    getPoiExtension(): PoiItemExtension | undefined;
    /**
     * 设置POI的深度信息。
     * @param poiExtension poi深度信息。
     * @since V1.0.0
     * @exclude javadoc中不显示
     */
    setPoiExtension(r53: PoiItemExtension | undefined): void;
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
    setTypeCode(q53: string): void;
    /**
     * 返回POI的商铺ID。
     * @return 商铺ID。
     * @since V1.0.0
     * @exclude javadoc中不显示
     */
    getShopID(): string | undefined;
    /**
     * 设置POI的商铺ID。
     * @param shopid 商铺id标识。
     * @since V1.0.0
     * @exclude javadoc中不显示
     */
    setShopID(p53: string): void;
}
