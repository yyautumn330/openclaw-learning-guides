// @keepTs
// @ts-nocheck
/**
 * HttpUrlUtil - 鸿蒙端网络工具类（对标 Android HttpUrlUtil）
 */
export declare class l44 {
    private static readonly h43;
    private w45;
    private f43;
    private x45;
    private y45;
    private z45;
    private a46;
    private b46;
    private c46;
    private d46;
    constructor();
    /**
     * 初始化 CSID
     */
    private e46;
    /**
     * 生成 UUID（简略版）
     */
    private y7;
    /**
     * 初始化请求上下文
     */
    f46(r45: string, s45: boolean, t45: string, u45?: string, v45?: boolean): void;
    /**
     * 获取最终 URL（已处理代理）
     */
    getUrl(): string;
    /**
     * 获取 CSID
     */
    j46(): string;
    /**
     * 设置是否需要发送 LCT
     */
    k46(send: boolean): void;
    /**
     * 获取 platinfo 字符串（用于 header 上报）
     */
    i34(p45: string): string;
    /**
     * 根据路径构建基础 URL
     */
    private g46;
    /**
     * 提取 URL 中的 host
     */
    private i46;
    /**
     * 【关键】通过 NetProxy 拦截并替换 URL（不使用 URL 类）
     */
    private h46;
    /**
     * 手动解析 URL 成组件（不依赖 URL 类）
     */
    private l46;
    /**
     * 将参数附加到 URL 上（绕过 Object.keys 和 forEach 检查）
     */
    /**
     * 将参数附加到 URL 上（只支持 Map，不使用 Object.keys / for...in / any）
     */
    static n32(baseUrl: string, params?: Map<string, string>): string;
    /**
     * 合并全局参数（模拟 BaseNetManager.extparams）
     */
    private static j32;
    static o46(params: Map<string, string>): void;
    private static n46;
    /**
     * 根据参数生成 query 字符串（类似 Java 的 getParamString）
     *
     * @param amapParams 参数映射
     * @returns 编码后的查询字符串
     */
    static q32(m44: Map<string, string>): string;
}
