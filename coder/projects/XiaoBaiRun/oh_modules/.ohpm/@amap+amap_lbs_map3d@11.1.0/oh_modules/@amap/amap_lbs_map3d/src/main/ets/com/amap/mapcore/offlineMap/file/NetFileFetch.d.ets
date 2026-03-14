// @keepTs
// @ts-nocheck
import { c191 } from "../db/OfflineDBOperation";
import { a193 } from "../DownloadListener";
import { w193 } from "../net/IDownloadListener";
import { y193 } from "./SiteInfoBean";
/**
 * 使用utilCore里面封装好的DownloadManager进行下载操作<br>
 * DownloadListner 为下载回调
 *
 * @author zxy94400
 */
export declare class b194 implements a193 {
    /**
     * 校验文件的时候用，断点续传时，如果文件大小小于该值，从头开始下载
     */
    private static readonly v194;
    w194?: y193;
    x194: number;
    y194: number;
    z194: number;
    a195: boolean;
    private mContext;
    b195?: c191;
    /**自定义的下载回调*/
    private listener?;
    private c195?;
    private v9?;
    private d195?;
    s184: number;
    /**
     * 是否是因为Exception
     * 导致停止下载
     */
    private e195;
    constructor(r194: y193, s194: string, t194: Context, listener: w193);
    /**
     * @throws IOException
     */
    private f195;
    /**
     * 检查是否是第一次下载，如果不是取出上次下载点，为续传做准备
     * 如果本地存在可续传的数据文件，从本地文件大小读取为已经下载的大小，总大小从服务获取。
     * 如果本地没有赋值为0L.
     */
    private i195;
    k195(): Promise<void>;
    /**
     * 下载的临时文件校验 主要检查 xxx.zip.tmp 和xxx.zip文件
     *
     * @return true 表示没有问题， false表示校验失败
     */
    private m195;
    private l195;
    private j195;
    /**
     * 写入下载进度 保存nStartPos，nEndPos数组中的值
     */
    private o195;
    /**
     * 保存下载进度到本地
     */
    private p195;
    /**
     * @param downloadsize
     */
    private q195;
    private s195;
    t195(): void;
    onStop(): void;
    onFinish(): void;
    /**
     * 修改临时文件的名字
     * xx.zip.tmp ==> xx.zip
     */
    onException(e: Error): void;
    onDownload(f194: Uint8Array, g194: number): void;
    v195?: d194;
    x195(e194: d194): void;
}
export interface d194 {
    /**
     * 网络下载结束回调
     */
    w195(): void;
}
