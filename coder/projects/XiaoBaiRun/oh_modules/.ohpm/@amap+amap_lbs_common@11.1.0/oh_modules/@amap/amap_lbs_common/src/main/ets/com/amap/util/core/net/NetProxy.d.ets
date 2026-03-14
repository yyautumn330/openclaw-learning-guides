// @keepTs
// @ts-nocheck
/**
 * NetProxy - 网络代理类（单例模式）
 *
 * 用于动态替换请求 host，支持灰度发布、测试 mock、IP直连等场景
 */
export declare class k44 {
    private static instance;
    private constructor();
    /**
     * 获取单例实例
     */
    static getInstance(): k44;
    /**
     * Host 代理回调
     *
     * @param host 原始 host（如：restapi.amap.com）
     * @param path 请求路径（如：/v3/geocode/geo）
     * @returns 返回替换后的 host，如果返回 null 表示不替换
     *
     * @example
     *   onHostProxy("restapi.amap.com", "/v3/geocode/geo") -> "mock-restapi.amap.com"
     */
    m46(host: string, path: string): string | null;
}
