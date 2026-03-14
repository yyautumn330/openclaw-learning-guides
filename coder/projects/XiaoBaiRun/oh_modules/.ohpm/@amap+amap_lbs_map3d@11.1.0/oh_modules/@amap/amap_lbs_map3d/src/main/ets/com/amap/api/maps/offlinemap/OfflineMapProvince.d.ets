// @keepTs
// @ts-nocheck
import { OfflineMapCity } from "./OfflineMapCity";
import { Province } from "./Province";
/**
 * 下载省属性的相关类。
 *
 * @since v2.2.0
 */
@Observed
export declare class OfflineMapProvince extends Province {
    private n10;
    private mState;
    private mSize;
    private o10;
    private mCompleteCode;
    private p10;
    /**
     * 构造一个OfflineMapProvince对象。
     * @since v2.2.0
     */
    OfflineMapProvince(): void;
    /**
     * 返回所下载省的数据地址。<br>
     * V3.1.0之后没有省份url地址，现在省变成了下载省下面的城市
     *
     * @return 下载省的数据地址。
     * @since v2.2.0
     */
    getUrl(): string;
    /**
     * 设置省份下载数据地图
     *
     * @param url url地址
     * @since v2.2.0
     */
    setUrl(url: string): void;
    /**
     * 返回省下载状态。
     *
     * @return 城市省状态(参见类OfflineMapStatus)。
     * @since v2.2.0
     */
    getState(): number;
    /**
     * 设置省份下载状态
     *
     * @param state 下载状态
     * @since v2.2.0
     */
    setState(state: number): void;
    /**
     * 返回下载省数据的大小，单位字节。
     *
     * @return 下载省数据的大小，单位字节。
     * @since v2.2.0
     */
    getSize(): number;
    /**
     * 设置省份大小
     *
     * @param size 省份大小
     * @since v2.2.0
     */
    setSize(size: number): void;
    /**
     * 返回下载省的数据版本。
     *
     * @return 下载省的数据版本。
     * @since v2.2.0
     */
    getVersion(): string;
    /**
     * 设置省份版本号
     *
     * @param version 版本号
     * @since v2.2.0
     */
    setVersion(version: string): void;
    /**
     * 返回省下载完成的百分比，100表示下载完成。
     *
     * @return 省下载完成的百分比，100表示下载完成。
     * @since v2.2.0
     */
    getcompleteCode(): number;
    /**
     * 设置省下载完成的百分比，100表示下载完成。
     *
     * @param code 省下载完成的百分比，100表示下载完成。
     * @since v2.2.0
     */
    setCompleteCode(code: number): void;
    /**
     * 得到当前省下所有的城市。
     *
     * @return 省的城市列表。
     * @since v2.2.0
     */
    getCityList(): OfflineMapCity[];
    /**
     * 得到当前准备下载的城市列表
     *
     * @return 城市列表
     * @exclude
     * @since 6.1.0
     */
    q10(): OfflineMapCity[];
    /**
     * 设置省下面的城市
     *
     * @param cityList 城市列表
     * @since v2.2.0
     */
    setCityList(l10: OfflineMapCity[]): void;
}
