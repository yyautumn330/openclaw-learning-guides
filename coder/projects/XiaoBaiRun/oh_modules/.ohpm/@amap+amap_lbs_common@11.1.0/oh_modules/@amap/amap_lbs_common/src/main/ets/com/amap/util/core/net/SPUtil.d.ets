// @keepTs
// @ts-nocheck
export declare const i51 = "open_common";
export declare const j51 = "a1";
export declare const k51 = "a2";
export declare const l51 = "a3";
export declare const m51 = "a4";
export declare const n51 = "a5";
export declare const o51 = "a6";
export declare const p51 = "a7";
export declare const q51 = "a8";
export declare const r51 = "a9";
export declare const s51 = "a10";
export declare const t51 = "a11";
export declare const u51 = "a12";
export declare const v51 = "a13";
export declare const w51 = "a14";
export declare const x51 = "a15";
export declare const y51 = "a16";
export declare const z51 = "a17";
export declare class j40 {
    private context;
    constructor(context: Context);
    /**
     * 存储字符串 —— 自动判断是否加密
     */
    a30(key: string, value: string, m52?: boolean): Promise<void>;
    /**
     * 获取字符串 —— 自动判断是否需解密
     */
    getString(key: string, defaultValue?: string): string;
    /**
     * 存储布尔值
     */
    b30(key: string, value: boolean, h52?: boolean): void;
    /**
     * 获取布尔值
     */
    getBoolean(key: string, defaultValue?: boolean): boolean;
    /**
     * 存储数字
     */
    i53(key: string, value: number, g52?: boolean): void;
    /**
     * 获取数字
     */
    getNumber(key: string, defaultValue?: number): number;
    /**
     * 删除 key
     */
    delete(key: string): void;
    /**
     * 强制持久化到磁盘
     */
    flush(): Promise<void>;
    /**
     * 清空所有数据
     */
    clear(): void;
    /**
     * 销毁单例
     */
    static destroy(): void;
}
