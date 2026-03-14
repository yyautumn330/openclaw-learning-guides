// @keepTs
// @ts-nocheck
import { LatLonPoint } from "../core/LatLonPoint";
/**
 * 定义Tip的类。
 * @since V1.0.0
 */
export declare class Tip {
    private h60;
    private i60;
    private name;
    private u56;
    private j60;
    private k60;
    private l60;
    private city;
    /**
     * 获取Poi的ID，如果不存在id则为空。
     * @return Poi的ID。
     * @since V1.0.0
     */
    getPoiID(): string | undefined;
    /**
     * 设置Poi的ID。
     * @param id Poi的ID。
     * @since V1.0.0
     */
    setID(id: string | undefined): void;
    /**
     * 获取Poi的经纬度，如果不存在经纬度则为空。
     * @return LatLngPoint 经纬度。
     * @since V1.0.0
     */
    getPoint(): LatLonPoint | undefined;
    /**
     * 设置Poi的经纬度。
     * @param position 经纬度。
     * @since V1.0.0
     */
    setPostion(position: LatLonPoint | undefined): void;
    /**
     * 返回提示名称。
     * @return 提示名称。
     * @since V1.0.0
     */
    getName(): string | undefined;
    /**
     * 设置提示名称
     * @param name 提示名称
     * @since V1.0.0
     */
    setName(name: string | undefined): void;
    /**
     * 返回提示区域。
     * @return 提示区域。
     * @since V1.0.0
     */
    getDistrict(): string | undefined;
    /**
     * 设置提示区域
     * @param district 提示区域
     * @since V1.0.0
     */
    d13(g60: string | undefined): void;
    /**
     * 返回提示区域编码。
     * @return 提示区域编码。
     * @since V1.0.0
     */
    getAdcode(): string | undefined;
    /**
     * 设置提示区域编码
     * @param adcode 区域编码
     * @since V1.0.0
     */
    j34(f60: string | undefined): void;
    /**
     * 返回详细地址。
     * @return 详细地址。
     * @since V1.0.0
     */
    m60(): string | undefined;
    /**
     * 设置详细地址。
     * @param address 详细地址。
     */
    k37(address: string | undefined): void;
    /**
     * @exclude javadoc中不显示。
     */
    setTypeCode(e60: string | undefined): void;
    /**
     * 获取输入提示结果的类型编码
     * @return 返回类型编码
     * @since V1.0.0
     */
    getTypeCode(): string | undefined;
    /**
     * 获取输入提示结果的城市
     * @return 返回城市
     * @since V1.0.0
     */
    getCity(): string | undefined;
    /**
     * @exclude javadoc中不显示。
     */
    setCity(city: string): void;
    /**
     * 将提示转换为字符串输出
     * @return 提示名称、提示区域、提示区域编码的字符串
     * @since V1.0.0
     *
     */
    toString(): string;
}
