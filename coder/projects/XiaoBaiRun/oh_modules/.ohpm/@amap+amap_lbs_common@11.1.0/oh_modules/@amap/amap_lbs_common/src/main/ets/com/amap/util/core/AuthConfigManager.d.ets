// @keepTs
// @ts-nocheck
import { SDKInfo } from './SDKInfo';
export interface c22 {
    data: Uint8Array;
    headers: Record<string, string[]>;
}
interface t22 {
    m27: string;
    n27: string;
    o27: string;
    AAID: string;
    p27: string;
    q27: string;
    r27: string;
    s27: string;
}
interface v22 {
    t27(config: ConfigEntity): void;
}
export declare class ConfigEntity {
    u27: number;
    v27: number;
    w27: string;
    x27: w22;
    y27: x22;
    z27: Record<string, string>;
    a28: boolean;
}
declare class w22 {
    b28: boolean;
    c28: boolean;
    d28?: Record<string, string>;
}
declare class x22 {
    e28: boolean;
}
declare class y22 {
    f28: number;
    g28: string;
    constructor(i26?: number, j26?: string);
}
export declare class AuthConfigManager {
    static k28: number;
    private static l28;
    static readonly m28 = false;
    static n28: number;
    static readonly o28 = 1;
    static readonly AUTH_FAILURE = 0;
    static readonly p28 = -1;
    static AuthInfo: string;
    private static readonly q28;
    private static r28;
    static readonly s28: t22;
    private static readonly t28;
    private static readonly t19;
    static context: Context | null;
    private static readonly u28;
    private static readonly v28;
    private static readonly w28;
    private static x28;
    static y28(ctx: Context): void;
    static a29(key: string): void;
    static b29(ctx: Context, c26: SDKInfo, operType: string, listener: v22): void;
    static f29(a26: SDKInfo): void;
    /**
     * 尝试进行首次加载（全局仅一次）
     */
    private static e29;
    static h29(v25: string, w25: number): boolean;
    static g29(r25: string, s25?: boolean): Promise<void>;
    static k29(ctx: Context, j25: SDKInfo, operType: string): Promise<ConfigEntity>;
    private static r29;
    private static u29;
    static s29(str: string | undefined, j24: boolean): boolean;
    /**
     * 检查并执行必要的启动后任务
     */
    static w29(context: Context): void;
    private static x29;
    static m29(list: string[] | undefined): number;
    static o29(list: string[] | undefined): string;
    static l29(operType: string): string;
    private static z29;
    private static a30;
    private static b30;
    private static t29;
    private static q29;
    private static c29;
    private static d29;
    private static getBoolean;
    private static getString;
    private static getLong;
    static z28(): void;
    static i29(s23: string): y22;
}
export {};
