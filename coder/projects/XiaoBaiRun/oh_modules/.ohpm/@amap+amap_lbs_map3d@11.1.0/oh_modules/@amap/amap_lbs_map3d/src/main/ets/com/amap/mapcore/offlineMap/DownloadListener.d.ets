// @keepTs
// @ts-nocheck
/**
 * 下载回调接口
 */
export interface a193 {
    /**
     * 下载过程回调
     *@param datas         下载结果数据
     *@param fromPosition  回调数据开始的长度
     */
    onDownload(datas: Uint8Array, fromPosition: number): void;
    /**
     *下载停止回调
     */
    onStop(): void;
    /**
     *下载成功完成回调
     */
    onFinish(): void;
    /**
     * 下载异常回调
     *@param e  异常
     */
    onException(e: Error): void;
}
