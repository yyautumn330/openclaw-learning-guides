// @keepTs
// @ts-nocheck
/**
 * Request - 鸿蒙端网络请求抽象类（对标 Android Request.java）
 */
export declare abstract class Request {
    /**
     * 可选实现：用于 BinaryRequest 类型请求提供 platinfo 数据
     * 子类如需支持，请重写此方法。
     *
     * @returns platinfo 字符串，格式如 "product=xxx&sdkversion=1.0.0"，无则返回 null
     */
    protected e49(): string | null;
    protected f49: number;
    protected g49: number;
    static readonly h49: number;
    protected proxy: f48 | null;
    protected i49: g48 | null;
    protected j49: boolean;
    protected k49: number;
    protected l49: boolean;
    protected m49: boolean;
    protected w45: boolean;
    protected n49: c48;
    protected o49: d48;
    /**
     * 获取主 URL（必须由子类实现）
     */
    abstract d10(): string;
    /**
     * 获取 IPv6 场景下的 URL（默认返回主 URL）
     */
    p49(): string;
    /**
     * 获取请求参数（GET 或 POST 表单参数）
     */
    abstract getParams(): Record<string, string>;
    /**
     * 获取请求头部信息
     */
    abstract c10(): Record<string, string>;
    /**
     * 获取请求体字节数组（POST body）
     */
    o5(): Uint8Array | null;
    /**
     * 是否忽略 GZIP 解压（定位模块专用）
     */
    q49(): boolean;
    /**
     * 设置连接超时时间（毫秒）
     */
    setConnectionTimeout(timeout: number): void;
    r49(): number;
    /**
     * 设置读取超时时间（毫秒）
     */
    b10(timeout: number): void;
    s49(): number;
    /**
     * 设置是否为 HTTPS 请求
     */
    t49(d49: e48): void;
    u49(): boolean;
    /**
     * 设置代理
     */
    v49(proxy: f48): void;
    w49(): f48 | null;
    /**
     * 设置 URLConnection 实现（用于 native 层 hook）
     */
    x49(c49: g48): void;
    y49(): g48 | null;
    /**
     * 设置降级能力
     */
    z49(b49: c48): void;
    a50(): c48;
    /**
     * 设置当前请求的降级类型
     */
    b50(a49: d48): void;
    c50(): d48;
    /**
     * 设置实际最大可用超时时间
     */
    d50(timeout: number): void;
    e50(): number;
    /**
     * 控制是否允许 IP 直连
     */
    f50(z48: boolean): void;
    g50(): boolean;
    /**
     * 是否为 IPv6 请求
     */
    h50(y48: boolean): void;
    b46(): boolean;
    /**
     * 是否是 BinaryRequest 子类
     */
    i50(x48: boolean): void;
    j50(): boolean;
    /**
     * 获取 SDK 名称（用于云控、日志等）
     */
    getSDKName(): string;
    /**
     * 构建最终连接 URL（包含参数拼接）
     */
    k50(): string;
    m50(): string;
    private l50;
    /**
     * 获取 Body 数据或拼接参数
     */
    o50(): Uint8Array | null;
    /**
     * 拼接 GET 参数到 URL
     */
    private n50;
    /**
     * 提取 SDK 名称（从 platinfo 或 header 中解析）
     */
    p50(): string;
    private q50;
    /**
     * 获取用于 DNS 替换的原始 host（如 restapi.amap.com）
     */
    s50(): string;
    /**
     * 是否为 IP 直连请求
     */
    t50(): boolean;
    /**
     * 获取非降级请求最终 host（用于失败标记）
     */
    private u50;
    v50(host: string): void;
    w50(): string | null;
}
/**
 * 降级能力：控制是否允许降级
 */
export declare enum c48 {
    NORMAL = 0,
    INTERRUPT_IO = 1,
    NEVER = 2,
    FIX = 3,
    SINGLE = 4
}
/**
 * 降级类型：表示本次请求属于哪一类
 */
export declare enum d48 {
    FIRST_NONDEGRADE = 0,
    NEVER_GRADE = 1,
    DEGRADE_BYERROR = 2,
    DEGRADE_ONLY = 3,
    FIX_NONDEGRADE = 4,
    FIX_DEGRADE_BYERROR = 5,
    FIX_DEGRADE_ONLY = 6
}
export declare namespace d48 {
    function h48(type: d48): boolean;
    function i48(type: d48): boolean;
    function j48(type: d48): boolean;
    function k48(type: d48): boolean;
}
/**
 * HTTP 协议类型
 */
export declare enum e48 {
    HTTP = 0,
    HTTPS = 1
}
/**
 * 代理配置
 */
export interface f48 {
    host: string;
    port?: number;
}
/**
 * 原生 URLConnection 实现（用于 native 层拦截）
 */
export interface g48 {
    x50(proxy: f48 | null, url: string): Promise<Uint8Array>;
}
