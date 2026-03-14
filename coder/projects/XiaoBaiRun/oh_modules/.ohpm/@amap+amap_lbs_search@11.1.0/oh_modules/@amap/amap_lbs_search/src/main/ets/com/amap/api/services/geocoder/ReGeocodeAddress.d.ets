// @keepTs
// @ts-nocheck
import { AoiItem } from "./AoiItem";
import { BusinessArea } from "./BusinessArea";
import ArrayList from "@ohos.util.ArrayList";
import { StreetNumber } from "./StreetNumber";
import { Crossroad } from "../road/Crossroad";
import { ReGeocodeRoad } from "./ReGeocodeRoad";
import { PoiItem } from "../core/PoiItem";
/**
 * 逆地理编码返回的结果。
 * @since V1.0.0
 *
 */
export declare class ReGeocodeAddress {
    /**
     *  格式化地址
     */
    private formatAddress;
    /**
     *  省
     */
    private f58;
    /**
     *   市
     */
    private city;
    /**
     *   区
     */
    private u56;
    /**
     *  乡镇
     */
    private g58;
    /**
     *  社区名称
     */
    private neighborhood;
    /**
     *  建筑物名称
     */
    private building;
    /**
     *  门牌信息
     */
    private streetNumber;
    private cityCode;
    private x3;
    private f59;
    /**
     *  道路列表
     */
    private roads;
    /**
     *  交叉路口列表
     */
    private g59;
    /**
     *  POI列表
     */
    private pois;
    /**
     * 商圈对象列表
     */
    private businessAreas;
    /**
     * （面状数据）的数据
     */
    private aois;
    /**
     * 国家名称
     */
    private country;
    /**
     * 海外生效
     * 国家简码
     */
    private countryCode;
    /**
     * 构造ReGeocodeAddress对象
     * @since V1.0.0
     *
     * @exclude javadoc中不显示。
     */
    constructor();
    /**
     * 逆地理编码返回的格式化地址。如返回北京市朝阳区方恒国际中心。
     * @return 结果的格式化地址。
     * @since V1.0.0
     */
    getFormatAddress(): string | undefined;
    /**
     * 设置逆地理编码返回的格式化地址。
     * @param formatAddress 结果的格式化地址。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    l37(formatAddress: string): void;
    /**
     * 逆地理编码返回的所在省名称、直辖市的名称 。
     * @return 结果的所在省名称、直辖市的名称。
     * @since V1.0.0
     */
    getProvince(): string | undefined;
    /**
     * 设置逆地理编码返回的所在省名称、直辖市的名称 。
     * @param province 省名称、直辖市的名称。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    setProvince(e59: string): void;
    /**
     * 逆地理编码返回的所在城市名称。直辖市的名称和省份名称保持一致。当所在城市属于县级市的时候，此字段为空
     * @return 结果的所在城市名称。
     * @since V1.0.0
     */
    getCity(): string | undefined;
    /**
     * 设置逆地理编码返回的所在城市名称。
     * @param city 城市名称
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    setCity(city: string): void;
    /**
     * 返回逆地理编码结果所在城市编码。直辖市的编码也会返回。
     * @return 结果的所在城市编码。
     * @since V1.0.0
     */
    getCityCode(): string | undefined;
    /**
     * 设置逆地理编码结果所在城市编码。
     * @param cityCode 城市编码。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    setCityCode(cityCode: string): void;
    /**
     * 返回逆地理编码结果所在区（县）的编码。
     * @return 结果的所在区（县）的编码。
     * @since V1.0.0
     */
    getAdCode(): string | undefined;
    /**
     * 设置逆地理编码结果所在区（县）的编码。
     * @param adCode 结果的所在区（县）的编码。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    setAdCode(d59: string): void;
    /**
     * 逆地理编码返回的所在区（县）名称。
     * @return 结果的所在区（县）名称。
     * @since V1.0.0
     */
    getDistrict(): string | undefined;
    /**
     * 设置逆地理编码返回的所在区（县）名称。
     * @param district 所在区（县）名称。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    d13(c59: string): void;
    /**
     * 逆地理编码返回的乡镇名称。
     * @return 结果的乡镇名称。
     * @since V1.0.0
     */
    getTownship(): string | undefined;
    /**
     * 设置逆地理编码返回的乡镇名称。
     * @param township 乡镇名称。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    m37(b59: string): void;
    /**
     * 逆地理编码返回的社区名称。
     * @return 结果的社区名称。
     * @since V1.0.0
     */
    getNeighborhood(): string | undefined;
    /**
     * 设置逆地理编码返回的社区名称。
     * @param neighborhood 社区名称。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    n37(neighborhood: string): void;
    /**
     * 逆地理编码返回的建筑物名称。
     * @return 结果的建筑物名称。
     * @since V1.0.0
     */
    getBuilding(): string | undefined;
    /**
     * 设置逆地理编码返回的建筑物名称。
     * @param building 结果的建筑物名称。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    setBuilding(a59: string): void;
    /**
     * 逆地理编码返回的门牌信息。
     * @return 结果的门牌信息。
     * @since V1.0.0
     */
    getStreetNumber(): StreetNumber | undefined;
    /**
     * 设置逆地理编码返回的门牌信息。
     * @param streetNumber 结果的门牌信息。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    p37(streetNumber: StreetNumber | undefined): void;
    /**
     * 逆地理编码返回的道路列表。
     * @return 结果的道路列表。
     * @since V1.0.0
     */
    getRoads(): ArrayList<ReGeocodeRoad>;
    /**
     * 设置逆地理编码返回的道路列表。
     * @param roads 结果的道路列表。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    y37(roads: ArrayList<ReGeocodeRoad>): void;
    /**
     * 逆地理编码返回的POI(兴趣点)列表。
     * @return 结果的POI(兴趣点)列表。
     * @since V1.0.0
     */
    getPois(): ArrayList<PoiItem>;
    /**
     * 设置逆地理编码返回的POI(兴趣点)列表。
     * @param pois 结果的POI(兴趣点)列表。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    f52(pois: ArrayList<PoiItem>): void;
    /**
     * 逆地理编码返回的交叉路口列表。
     * @return 结果的交叉路口列表。
     * @since V1.0.0
     */
    getCrossroads(): ArrayList<Crossroad>;
    /**
     * 设置逆地理编码返回的交叉路口列表。
     * @param crossRoads 结果的交叉路口列表。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    a38(z58: ArrayList<Crossroad>): void;
    /**
     * 返回商圈对象列表，若服务没有相应数据，则返回列表长度为0。
     * @return 商圈对象列表。
     * @since V1.0.0
     */
    getBusinessAreas(): ArrayList<BusinessArea>;
    /**
     * 设置商圈对象列表。
     * @param areas 商圈对象列表。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    q37(y58: ArrayList<BusinessArea>): void;
    /**
     * 返回AOI（面状数据）的数据，如POI名称、区域编码、中心点坐标、POI类型等。AOI，是指含有区域范围的POI，如XX小区、XX大厦等。
     * @return AOI（面状数据）的数据列表.
     * @since V1.0.0
     */
    getAois(): ArrayList<AoiItem>;
    /**
     * 设置AOI（面状数据）的数据。
     * @param aois AOI（面状数据）的数据列表。
     * @exclude javadoc中不显示。
     * @since V1.0.0
     */
    d38(aois: ArrayList<AoiItem>): void;
    /**
     * 返回乡镇街道编码。
     * @return 乡镇街道编码。
     * @since V1.0.0
     */
    getTownCode(): string | undefined;
    /**
     * 设置乡镇街道编码。
     * @param townCode 乡镇街道编码。
     * @exclude javadoc中不显示。
     * @since V1.0.0
     */
    s37(x58: string): void;
    /**
     * 设置国家名称。
     * @param country 国家名称。
     * @exclude javadoc中不显示。
     * @since 1.0.0
     */
    setCountry(country: string): void;
    /**
     * 获取国家名称。
     * @return 返回国家名称
     * @since 1.0.0
     */
    getCountry(): string | undefined;
    /**
     * 海外生效
     * 国家简码
     * @since 1.0.0
     */
    getCountryCode(): string | undefined;
    /**
     * 海外生效
     * 国家简码
     * @since 1.0.0
     */
    setCountryCode(countryCode: string): void;
}
