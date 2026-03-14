// @keepTs
// @ts-nocheck
import { u181 } from './net/IDownloadItem';
import { v181 } from './net/IDownloadListener';
import { OfflineMapCity } from '../../api/maps/offlinemap/OfflineMapCity';
import { w181 } from './state/AbstractCityStateImp';
import { f182 } from './TaskItem';
import { a25 } from './UpdateItem';
export declare class e9 extends OfflineMapCity implements u181, f182 {
    static readonly j183: number;
    static readonly k183: number;
    static readonly l183: number;
    static readonly m183: number;
    static readonly n183: number;
    readonly b10: w181;
    readonly o183: w181;
    readonly p183: w181;
    readonly q183: w181;
    readonly r183: w181;
    readonly s183: w181;
    readonly a10: w181;
    readonly t183: w181;
    readonly u183: w181;
    readonly v183: w181;
    readonly w183: w181;
    private state;
    private context;
    /** 临时文件的位置 */
    private fileName;
    /** 压缩文件里面的文件名，即离线数据的相对路径 */
    private x183;
    y183(i183: string): void;
    z183(): string;
    /**
     * 接口需要
     *
     * @return
     */
    a184(): string;
    /**
     * 暂时这样写着 用来测试
     *
     * @param context
     * @param city
     */
    constructor(context: Context, city: OfflineMapCity);
    /**
     * 初始化状态
     *
     * @param stateId
     */
    b184(h183: number): void;
    d184(state: w181): void;
    z9(): w181;
    /**回调更新状态 */
    e184(): void;
    f184(): void;
    private g184;
    /**
     * ui操作
     */
    h184(): void;
    /**
     * 暂停下载操作
     */
    l184(): void;
    /**
     * 操作出现异常，比如删除出现错误，修改状态
     */
    m184(): void;
    /**
     * 删除操作
     */
    n184(): void;
    /**
     * 检查更新的时候，如果有更新会调用
     */
    o184(): void;
    /**
     * 删除任务，执行删除操作，目前没有用
     */
    j184(): void;
    /**
     * 请求开始下载，等待中的任务请求开始下载
     */
    q184(): void;
    r184(): void;
    j10(): void;
    onStart(): void;
    onProgress(z182: number, a183: number): void;
    onFinish(): void;
    onError(y182: v181): void;
    onCancel(): void;
    a168(): void;
    b168(): void;
    c168(progress: bigint): void;
    d168(s182: string): void;
    e168(): void;
    /**
     * 太多写死的字段，这个初始化， 主要是为了fileName
     */
    init(): void;
    w184(): string;
    x184(): string;
    private s184;
    /**
     * 带有计数效果的文件夹复制和删除<br>
     * 复制进度为解压的60~99 % 删除进度为解压的99~100 %
     *
     * @param sourceLocation
     * @param targetLocation
     * @param zipFilePath
     */
    private b185;
    /**
     * 检查sd卡是否充足
     *
     * @return
     */
    f185(): boolean;
    h185(): a25;
    /**
     * 根据UpdateItem更新城市消息
     *
     * @param item
     */
    j185(item: a25): void;
    describeContents(): number;
    m185(): boolean;
    /**
     * 下载文件存放文件名
     * @return
     */
    n185(): string;
    getId(): string;
    x167(): string;
    y167(): string;
    p185(type: number): w181;
}
