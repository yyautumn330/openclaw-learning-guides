// @keepTs
// @ts-nocheck
import type { k56 } from './UpdateDataStrategy';
/**
 * 对应 Java: com.amap.apis.utils.core.statistics.datastrategy.StatisticsPubDataStrategy
 *
 * 功能：在数据前添加时间 + UUID 的公共头信息
 * 格式：yyyyMMdd HHmmss UUID[空格] → 共 53 字符
 * 要求：长度必须等于 53，否则返回空
 */
export declare class x65 implements k56 {
    private readonly o56;
    constructor(o67?: k56);
    /**
     * 添加日志数据（透传给下一层）
     */
    t56(n67: Uint8Array): void;
    /**
     * 处理数据：生成 53 字节头部 + 原始数据
     */
    process(): Promise<Uint8Array>;
    /**
     * 生成公共头信息："yyyyMMdd HHmmss UUID "
     * 要求：总长度必须为 53
     */
    private p67;
    /**
     * 生成 UUID v4（标准格式：xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx）
     */
    private y7;
    /**
     * 合并两个 Uint8Array
     */
    private i65;
}
