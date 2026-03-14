// @keepTs
// @ts-nocheck
@Component
export declare struct Waiting {
    /**
     * 监听外部传入的isWaiting变量，isWaiting值发生变化时触发onChange回调函数
     */
    @Link
    isWaiting: boolean;
    /**
     * Waiting弹窗
     */
    controller: CustomDialogController | undefined;
    /**
     * 当isWaiting的值变化时触发回调
     */
    onWaitingStateChange(): void;
    aboutToAppear(): void;
    /**
     * 在自定义组件即将析构销毁时将controller置空
     */
    aboutToDisappear(): void;
    build(): void;
}
