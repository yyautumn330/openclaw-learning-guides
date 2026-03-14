// @keepTs
// @ts-nocheck
import type { k56 } from './UpdateDataStrategy';
/**
 * 对应 Java: com.amap.apis.utils.core.statistics.datastrategy.LogJsonDataStrategy
 *
 * 功能：将多个日志条目拼接为标准 JSON 数组格式：
 *      [{"log":"data1"}, {"log":"data2"}]
 */
export declare class y62 implements k56 {
    private readonly o56;
    private readonly chunks;
    private h63;
    constructor(g63?: k56);
    /**
     * 添加一条日志数据（对应 addLogData）
     */
    t56(c63: Uint8Array): void;
    /**
     * 处理所有累积的数据 → 返回拼接后的字节数组（对应 processData）
     * 同时清空内部缓冲区
     */
    process(): Promise<Uint8Array>;
    /**
     * 简单转义 JSON 字符串中的特殊字符（防止破坏结构）
     */
    private i63;
    /**
     * 获取当前已添加的日志数量（可用于判断是否为空）
     */
    w56(): number;
    /**
     * 清空所有缓存（可选主动调用）
     */
    clear(): void;
}
