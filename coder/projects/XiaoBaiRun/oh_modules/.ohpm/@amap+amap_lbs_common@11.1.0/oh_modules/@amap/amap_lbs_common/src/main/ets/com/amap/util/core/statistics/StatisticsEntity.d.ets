// @keepTs
// @ts-nocheck
/**
 * 埋点实体类 - 对应 Android StatisticsEntity.java
 */
export declare class l40 {
    private context;
    private id;
    private f43;
    private sdkVersion;
    private c65;
    private readonly d65;
    constructor(context: Context, a65: string, b65: string, id: string);
    d44(z64: string): void;
    getID(): string;
    getSDKName(): string;
    getSDKVersion(): string;
    /**
     * 获取字符串 UTF-8 字节长度
     */
    private e65;
    private f65;
    private g65;
    h65(): Uint8Array;
    private i65;
    private u56;
}
