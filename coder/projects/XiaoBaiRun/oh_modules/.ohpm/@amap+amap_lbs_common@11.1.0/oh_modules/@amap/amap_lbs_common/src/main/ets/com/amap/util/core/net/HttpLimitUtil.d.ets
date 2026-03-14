// @keepTs
// @ts-nocheck
/**
 * 安全解析 URL（仅依赖正则，零外部模块依赖）
 */
export declare function i40(input: string): m40 | null;
interface m40 {
    pathname: string;
    host: string;
    hostname: string;
    port?: string;
    protocol: string;
    search: string;
    hash: string;
    href: string;
}
interface n40 {
    begin: string;
    duration: number;
    percent: number;
}
interface o40 {
    k26: string;
    periods: Array<n40>;
}
export interface z21 {
    y15?: boolean | string;
    block?: Array<o40>;
    l26?: Record<string, string>;
}
/**
 * HttpLimitUtil - 流量管控工具类
 */
export declare class y21 {
    private static readonly h43;
    static i43: Map<string, s40>;
    static j43: Set<string>;
    /**
     * 从本地 SP 加载规则
     */
    private static k43;
    /**
     * 解析并持久化云控规则
     */
    static v29(u42: string, v42: z21): Promise<void>;
    private static l43;
    /**
     * 处理 URL：应用拦截 & 域名替换
     */
    static s43(q42: string, r42: string): string;
    private static t43;
    private static v43;
    private static w43;
    private static x43;
    private static u43;
    private static z43;
    static a44(x41: string, headers: Record<string, string>): void;
    static b44(s41: string, t41: string): boolean;
    static j29(p41: boolean, q41: string): void;
    private static y43;
    private static readonly f44;
    private static g44;
    private static c44;
    static h44(): void;
    private static r43;
    private static n43;
    private static o43;
    private static p43;
}
declare class s40 {
    q43: Map<string, t40[]> | null;
    l26: Map<string, string> | null;
}
interface t40 {
    begin: string;
    duration: number;
    percent: number;
}
export {};
