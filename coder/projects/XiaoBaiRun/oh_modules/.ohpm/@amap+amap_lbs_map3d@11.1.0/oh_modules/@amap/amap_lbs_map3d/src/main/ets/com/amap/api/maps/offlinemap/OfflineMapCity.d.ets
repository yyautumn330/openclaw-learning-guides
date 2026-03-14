// @keepTs
// @ts-nocheck
import { City } from "./City";
/**
 * 下载城市属性的相关类。
 * @since V2.1.0
 */
@Observed
export declare class OfflineMapCity extends City {
    private d9;
    private size;
    /** 默认为检查更新*/
    private mState;
    private version;
    private mCompleteCode;
    /**
     * 构造一个OfflineMapCity对象。
     * @since V2.1.0
     */
    OfflineMapCity(): void;
    /**
     * 返回所下载城市的数据地址。
     * @return 下载城市的数据地址。
     * @since V2.1.0
     */
    getUrl(): string;
    /**
     * 设置下载城市的数据地址。
     * @param durl 下载城市的数据地址。
     * @since V2.1.0
     */
    setUrl(c9: string): void;
    /**
     * 返回下载城市数据的大小，单位字节。
     * @return 下载城市数据的大小，单位字节。
     * @since V2.1.0
     */
    getSize(): number;
    /**
     * 设置下载城市数据的大小，单位字节。
     * @param size 下载城市数据的大小，单位字节。
     * @since V2.1.0
     */
    setSize(size: number): void;
    /**
     * 返回城市下载状态。
     * @return 城市下载状态 (参见类OfflinMapStatus)。
     * @since V2.1.0
     */
    getState(): number;
    /**
     * 设置城市下载状态。
     * @param mState 城市下载状态 (参见类OfflinMapStatus)。
     * @since V2.1.0
     */
    setState(b9: number): void;
    /**
     * 返回下载城市的数据版本。
     * @return 下载城市的数据版本。
     * @since V2.1.0
     */
    getVersion(): string;
    /**
     * 设置下载城市的数据版本。
     * @param version 下载城市的数据版本。
     * @since V2.1.0
     */
    setVersion(version: string): void;
    /**
     * 返回城市下载完成的百分比，100表示下载完成。
     * @return 城市下载完成的百分比，100表示下载完成。
     * @since V2.2.0
     */
    getcompleteCode(): number;
    /**
     * 设置下载完成的百分比，100表示下载完成。
     * @param code 城市下载完成的百分比，100表示下载完成。
     * @since V2.2.0
     */
    setCompleteCode(code: number): void;
}
