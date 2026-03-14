// @keepTs
// @ts-nocheck
import { LatLonPoint } from "../core/LatLonPoint";
/**
 * 地理编码返回的结果
 * @since V1.0.0
 */
export declare class GeocodeAddress {
    private formatAddress;
    private f58;
    private city;
    private u56;
    private g58;
    private neighborhood;
    private building;
    private x3;
    private w3;
    private level;
    private country;
    private postcode;
    /**
     * GeocodeAddress的构造方法。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    constructor();
    /**
     * 地理编码返回的格式化地址。如返回北京市朝阳区方恒国际中心。
     * @return 结果的格式化地址。
     * @since V1.0.0
     */
    getFormatAddress(): string | undefined;
    /**
     * 设置地理编码返回的格式化地址。
     * @param formatAddress 格式化地址。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    l37(formatAddress: string): void;
    /**
     * 地理编码返回的所在省名称、直辖市的名称 。
     * @return 结果的所在省名称、直辖市的名称。
     * @since V1.0.0
     */
    getProvince(): string | undefined;
    /**
     * 设置地理编码返回的所在省名称、直辖市的名称 。
     * @param province 省名称、直辖市的名称。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    setProvince(e58: string): void;
    /**
     * 地理编码返回的所在城市名称。直辖市的名称和省份名称保持一致。
     * @return 结果的所在城市名称。
     * @since V1.0.0
     */
    getCity(): string | undefined;
    /**
     * 设置地理编码的城市名称。
     * @param city 城市名称
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    setCity(city: string): void;
    /**
     * 地理编码返回的所在区（县）名称。
     * @return 结果的所在区（县）名称。
     * @since V1.0.0
     */
    getDistrict(): string | undefined;
    /**
     * 设置地理编码返回的所在区（县）名称。
     * @param district 所在区（县）名称。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    d13(d58: string): void;
    /**
     * 地理编码返回的乡镇名称。
     * @return 结果的乡镇名称。
     * @since V1.0.0
     */
    getTownship(): string | undefined;
    /**
     * 设置地理编码返回的乡镇名称。
     * @param township 乡镇名称。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    m37(c58: string): void;
    /**
     * 地理编码返回的社区名称。
     * @return 结果的社区名称。
     * @since V1.0.0
     */
    getNeighborhood(): string | undefined;
    /**
     * 设置地理编码返回的社区名称。
     * @param neighborhood 社区名称。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    n37(neighborhood: string): void;
    /**
     * 地理编码返回的建筑物名称。
     * @return 结果的建筑物名称。
     * @since V1.0.0
     */
    getBuilding(): string | undefined;
    /**
     * 设置地理编码返回的建筑物名称。
     * @param building 建筑物名称。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    setBuilding(b58: string): void;
    /**
     * 地理编码返回的区域编码。
     * @return 结果的区域编码。
     * @since V1.0.0
     */
    getAdCode(): string | undefined;
    /**
     * 设置地理编码返回的区域编码。
     * @param adCode 结果的区域编码。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    setAdCode(a58: string): void;
    /**
     * 地理编码返回的经纬度坐标。
     * @return 结果的经纬度坐标。
     * @since V1.0.0
     */
    getLatLonPoint(): LatLonPoint | undefined;
    /**
     * 设置地理编码返回的经纬度坐标
     * @param latLonPoint 地理编码返回的经纬度坐标
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    setLatLonPoint(z57: LatLonPoint | undefined): void;
    /**
     * 地理编码返回的匹配级别。匹配级别有“兴趣点”、“交叉路口”、“道路”。
     * @return 结果的匹配级别。
     * @since V1.0.0
     */
    getLevel(): string | undefined;
    /**
     * 设置地理编码返回的匹配级别。
     * @param level 结果的匹配级别
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    j36(level: string): void;
    /**
     * 海外生效
     * 国家名称
     * @since 1.0.0
     */
    getCountry(): string | undefined;
    /**
     * 海外生效
     * 国家名称
     * @since 1.0.0
     */
    setCountry(country: string): void;
    /**
     * 海外生效
     * 邮政编码
     * @since 1.0.0
     */
    getPostcode(): string | undefined;
    /**
     * 海外生效
     * 邮政编码
     * @since 1.0.0
     */
    setPostcode(postcode: string): void;
}
