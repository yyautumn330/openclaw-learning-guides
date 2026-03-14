// @keepTs
// @ts-nocheck
export declare class d8 {
    private static instance;
    private static b9;
    private static c9;
    private static readonly c1;
    private static readonly f1;
    private static readonly e1;
    private static readonly d9;
    private context;
    private constructor();
    /**
     * 获取 AAIDManager 单例。
     * @param context 应用上下文
     * @returns AAIDManager 实例
     */
    static getInstance(context: Context): d8;
    /**
     * 获取设备标识信息 AAID（异步非阻塞）。
     * 此方法不会触发网络请求，仅返回当前缓存值。
     * 如需自动刷新，请使用 getAAIDWithRefresh()。
     * @returns 当前缓存的 AAID 字符串（可能为空）
     */
    getAAID(): string;
    /**
     * 获取 AAID（同步语义，实际为异步等待）。
     * 使用时注意：必须在 async 函数中 await 调用，不可在 UI 主线程直接阻塞。
     * 会根据缓存状态自动触发创建或更新 AAID。
     * @returns 最终有效的 AAID 字符串
     */
    e9(): Promise<string>;
    /**
     * 异步创建 AAID（提交到任务池执行）。
     */
    h9(): void;
    /**
     * 异步更新（重映射）AAID（提交到任务池执行）。
     */
    i9(): void;
    /**
     * 执行创建 AAID 的网络请求。
     * @private
     */
    private f9;
    /**
     * 执行更新（重映射）AAID 的网络请求。
     * @private
     */
    private g9;
    /**
     * 将响应结果转换为 Uint8Array
     * @param result HTTP 响应结果（可能是 string、Object 或 ArrayBuffer）
     * @returns Uint8Array
     */
    private k9;
    /**
     * 封装 HTTP POST 请求。
     * @param request 请求对象（AAIDCreateRequest 类型）
     * @returns HTTP 响应
     */
    private j9;
}
