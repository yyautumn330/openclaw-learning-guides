// @keepTs
// @ts-nocheck
import { d194 } from "./file/NetFileFetch";
import { u181 } from "./net/IDownloadItem";
/**
 * 所有任务都在这一个线程里面完成 下载，解压，复制，删除临时文件
 *
 * @author zxy94400
 */
export declare class o207 implements d194 {
    private s207?;
    private t207?;
    private u207?;
    private mContext?;
    private isStopped;
    constructor(item: u181, context: Context);
    /** 任务需要执行的操作 */
    d203(): void;
    i203(): void;
    /**
     * 获取本地离线数据目录
     *
     * @return
     */
    private x207;
    /**
     * 真正的启动线程开始下载
     *
     * @throws IOException
     */
    private v207;
    destroy(): void;
    w195(): void;
}
