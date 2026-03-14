// @keepTs
// @ts-nocheck
export declare class v181 {
    /**
     * 网络访问异常
     */
    static readonly t184: v181;
    /**
     * 网络访问异常
     */
    static readonly v184: v181;
    /**
     * 文件读写异常
     */
    static readonly u184: v181;
    /**
     * 正常，无异常
     */
    static readonly b200: v181;
    /**
     * 取消，无异常
     */
    static readonly c200: v181;
    private d200;
    private e200?;
    constructor(tag: number);
    f200(): number;
    g200(message: string): void;
    getMessage(): string | undefined;
}
/**
 * @author zxy
 */
export interface w193 {
    /**
     * 开始
     *
     */
    onStart(): void;
    /**
     * 回调下载进度
     *
     * @param totalReceived
     *            接收的总数居大小
     * @param fileTotalSize 文件总大小
     */
    onProgress(totalReceived: number, fileTotalSize: number): void;
    /**
     * 下载完成
     *
     */
    onFinish(): void;
    /**
     * 访问网络出错
     * @param errorExceptionType  错误类型
     */
    onError(errorExceptionType: v181): void;
    /**
     * 取消下载
     *
     */
    onCancel(): void;
}
