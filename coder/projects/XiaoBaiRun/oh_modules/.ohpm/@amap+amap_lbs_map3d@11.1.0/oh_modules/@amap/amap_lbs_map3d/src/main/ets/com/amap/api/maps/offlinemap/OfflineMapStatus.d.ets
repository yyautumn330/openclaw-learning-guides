// @keepTs
// @ts-nocheck
/**
 * 地图下载的相关状态码。<br>
 * <p/>
 * 状态说明<br>
 *
 * @since V2.0.1
 */
export declare class OfflineMapStatus {
    /**
     * 默认状态
     */
    static readonly CHECKUPDATES = 6;
    /**
     * 解压失败错误，数据有可能有问题，所以重新下载
     *
     * @since V2.1.0
     */
    static readonly ERROR = -1;
    /**
     * 停止下载。<br>
     * 该状态不会出现
     *
     * @since V2.1.0
     */
    static readonly STOP = 5;
    /**
     * 正在下载。
     *
     * @since V2.1.0
     */
    static readonly LOADING = 0;
    /**
     * 正在解压。
     *
     * @since V2.1.0
     */
    static readonly UNZIP = 1;
    /**
     * 等待下载。
     *
     * @since V2.1.0
     */
    static readonly WAITING = 2;
    /**
     * 暂停下载。
     *
     * @since V2.1.0
     */
    static readonly PAUSE = 3;
    /**
     * 下载成功。
     *
     * @since V2.1.0
     */
    static readonly SUCCESS = 4;
    /**
     * 有更新，对于已下载的城市出现，线上出现新版本的时候会出现此状态。
     *
     * @since V3.2.0
     */
    static readonly NEW_VERSION = 7;
    /**
     * 下载过程中网络问题，不属于错误，下次还可以继续下载
     *
     * @since 2.5.1
     */
    static readonly EXCEPTION_NETWORK_LOADING = 101;
    /**
     * AMap认证等异常，请检查key，下次还可以继续下载
     *
     * @since 2.5.1
     */
    static readonly EXCEPTION_AMAP = 102;
    /**
     * SD卡读写异常,下载过程有写入文件，解压过程也有写入文件<br>
     * 即出现IOexception
     *
     * @since 2.5.1
     */
    static readonly EXCEPTION_SDCARD = 103;
    /**
     * 开始下载失败，已下载该城市地图
     *
     * @since 2.5.1
     */
    static readonly START_DOWNLOAD_FAILD = 1002;
}
