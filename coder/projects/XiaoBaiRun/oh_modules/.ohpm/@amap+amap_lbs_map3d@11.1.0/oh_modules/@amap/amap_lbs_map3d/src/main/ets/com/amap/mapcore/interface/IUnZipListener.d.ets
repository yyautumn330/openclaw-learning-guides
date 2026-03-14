// @keepTs
// @ts-nocheck
export interface z167 {
    /**
     * 解压开始
     */
    a168(): void;
    /**
     * 解压失败
     */
    b168(): void;
    /**
     * 解压进度
     *
     * @param progress 进度
     */
    c168(progress: bigint): void;
    /**
     * 解压成功
     * @param fileNames 文件名称
     */
    d168(fileNames: string): void;
    /**
     * 取消解压
     */
    e168(): void;
}
