// @keepTs
// @ts-nocheck
export declare class Navi {
    private action?;
    private e80?;
    /**
     * 返回驾车路段的导航主要操作
     *
     * @return 驾车路段的导航主要操作
     */
    getAction(): string;
    /**
     * 设置驾车路段的导航主要操作
     *
     * @param action 驾车路段的导航主要操作
     */
    setAction(action: string): void;
    /**
     * 获取驾车路段的导航辅助操作
     *
     * @return 驾车路段的导航辅助操作
     */
    getAssistantAction(): string;
    /**
     * 设置驾车路段的导航辅助操作
     *
     * @param assistantAction 驾车路段的导航辅助操作
     */
    setAssistantAction(d80: string): void;
}
