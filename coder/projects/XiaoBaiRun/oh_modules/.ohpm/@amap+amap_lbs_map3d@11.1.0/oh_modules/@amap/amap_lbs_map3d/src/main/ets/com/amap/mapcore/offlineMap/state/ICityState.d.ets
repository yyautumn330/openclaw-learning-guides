// @keepTs
// @ts-nocheck
export interface v208 {
    /**
     * 进入状态立马需要做的事
     */
    k184(): void;
    /**
     * 开始下载
     */
    start(): void;
    /**
     * 继续下载
     */
    i184(): void;
    /**
     * 暂停下载
     */
    pause(): void;
    /**
     * 删除或取消下载
     */
    delete(): void;
    /**
     * 下载或解压失败
     * @param tpye 错误类型
     */
    fail(tpye: number): void;
    /**
     * 有更新状态
     */
    p184(): void;
    /**
     * 完成
     */
    complete(): void;
}
