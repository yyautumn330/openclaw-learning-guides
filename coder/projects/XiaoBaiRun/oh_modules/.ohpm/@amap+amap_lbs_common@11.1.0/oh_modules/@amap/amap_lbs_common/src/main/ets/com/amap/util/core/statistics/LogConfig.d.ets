// @keepTs
// @ts-nocheck
import { j17 } from './UpdateStrategy';
import { f60, k56 } from './UpdateDataStrategy';
import { x56 } from './EncryptProcessor';
/**
 * 对应 Java: com.amap.apis.utils.core.statistics.LogConfig
 *
 * 日志系统核心配置项
 */
export declare class z14 {
    private i60;
    j60(strategy: f60 | null): void;
    k60(): f60 | null;
    private t58;
    private maxSize;
    private l60;
    private m60;
    private s59;
    private n60;
    private o60;
    private updateInterval;
    private p60;
    /**
     * 更新策略（️ 注意：Java 中拼写为 mUpdateStategy，少一个 'r'）
     * 必须保留此字段名以兼容 Android 行为
     */
    private q60;
    /**
     * 更新间隔时间（单位：秒），对应 Java 中的 mUpdateInterval
     */
    private r60;
    constructor();
    s60(): string;
    u16(path: string): void;
    t60(): number;
    w16(size: number): void;
    u60(): string;
    y16(type: string): void;
    v60(): number;
    x16(num: number): void;
    w60(): x56 | null;
    x60(processor: x56 | null): void;
    p16(): j17 | null;
    y60(strategy: j17 | null): void;
    z60(): k56 | null;
    d17(strategy: k56 | null): void;
    a61(): number;
    b61(h60: number): void;
    c61(): string;
    b17(key: string): void;
    /**
     * 获取 mUpdateStategy（注意拼写）
     */
    d61(): j17 | null;
    /**
     * 设置 mUpdateStategy（必须保留错误拼写）
     */
    e61(strategy: j17 | null): void;
    /**
     * 获取 mUpdateInterval（单位：秒）
     */
    f61(): number;
    /**
     * 设置 mUpdateInterval（单位：秒）
     */
    a17(g60: number): void;
    /**
     * 检查是否已配置基本路径和大小
     */
    isValid(): boolean;
    /**
     * 重置所有配置为默认值
     */
    reset(): void;
}
