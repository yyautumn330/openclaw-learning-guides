// @keepTs
// @ts-nocheck
import ArrayList from '@ohos.util.ArrayList';
/**
 * 二进制请求postBody数据体
 */
export declare class k33 {
    private static readonly n72;
    /**
     * 默认版本为1。
     */
    version: number;
    o72: number;
    p72: number;
    q72: number;
    /**
     * 头部数据块。
     */
    r72: Uint8Array;
    /**
     * 当前已经添加了的公共数据块。
     */
    s72: Uint8Array;
    /**
     * 当前已经添加了的非加密数据块。
     */
    t72: Uint8Array;
    /**
     * 当前已经添加了的加密据块。
     */
    encryptedData: Uint8Array;
    /**
     * 预留字段数据
     */
    u72: Uint8Array;
    /**
     * rsa加密对象
     */
    constructor();
    v72(): void;
    /**
     * 添加数据到公共块
     */
    e34(j72: ArrayList<Uint8Array>): void;
    w72(e72: Uint8Array, f72: Uint8Array, length: number, g72: boolean): Uint8Array;
    /**
     * 添加数据到加密块（只需要传入原始数据，外部不需要进行加密操作）
     */
    f34(data: Uint8Array): Promise<void>;
    z72(data: Uint8Array): Promise<void>;
    c73(data: Uint8Array, length: number, r71: boolean): Uint8Array;
    y72(num: number, length: number): Uint8Array;
    r38(n71: Uint8Array, data: Uint8Array): Uint8Array;
    d73(num: number, length: number, data: Uint8Array): Uint8Array;
    g34(): Uint8Array;
    x72(value: number): number;
}
