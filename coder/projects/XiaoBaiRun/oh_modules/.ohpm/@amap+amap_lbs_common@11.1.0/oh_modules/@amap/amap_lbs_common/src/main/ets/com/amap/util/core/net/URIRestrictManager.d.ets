// @keepTs
// @ts-nocheck
/**
 * URIRestrictManager - URI 访问限制管理器（对标 Android URIRestrictManager.java）
 *
 * 支持以下规则格式：
 * 1. 路径前缀：`/v3/direction/driving` → 匹配任意 host 的该路径
 * 2. host + 路径：`restapi.amap.com/v3/direction/driving`
 * 3. 完整 URL：`https://restapi.amap.com/v3/direction/driving`
 *
 *
 * 注意：规则是大小写敏感的
 */
export declare class j53 {
    private static instance;
    private readonly d54;
    private readonly e54;
    private readonly f54;
    private constructor();
    /**
     * 获取单例实例
     */
    static getInstance(): j53;
    /**
     * 判断某个 URI 是否被限制访问
     *
     * @param uri 完整 URL 或路径表达式
     * @returns true 表示被限制
     */
    g54(uri: string): boolean;
    /**
     * 添加 URI 访问限制规则
     *
     * @param uri 规则字符串（支持三种格式）
     *
     * @example
     * addURIRestriction("/v3/geocode/geo");
     * addURIRestriction("restapi.amap.com/v3/direction/driving");
     * addURIRestriction("https://restapi.amap.com/v3/weather");
     */
    j54(uri: string): void;
    /**
     * 移除一条 URI 限制规则（必须完全一致）
     */
    l54(uri: string): void;
    /**
     * 移除所有限制规则
     */
    m54(): void;
    /**
     * 将规则解析为内部结构并注册
     */
    private k54;
    /**
     * 解析 URI 字符串为 ParsedURL 对象
     */
    private h54;
    /**
     * 手动解析 URI 字符串（替代 new URL()）
     *
     * 支持格式：
     * - /v3/geocode/geo
     * - restapi.amap.com/v3/geocode/geo
     * - https://restapi.amap.com/v3/geocode/geo
     */
    private o54;
    /**
     * 标准化 URI 结构
     */
    private n54;
    /**
     * 匹配规则
     */
    private i54;
    /**
     * 路径匹配测试（支持 * 通配符）
     *
     *
     * @param urlPath 实际路径（如 /v3/direction/driving/route）
     * @returns 是否匹配
     */
    private p54;
}
