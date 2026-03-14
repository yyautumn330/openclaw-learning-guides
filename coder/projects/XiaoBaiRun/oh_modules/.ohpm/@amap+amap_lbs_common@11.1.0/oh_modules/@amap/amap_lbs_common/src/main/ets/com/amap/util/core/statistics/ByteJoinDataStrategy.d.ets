// @keepTs
// @ts-nocheck
import type { k56 } from './UpdateDataStrategy';
/**
 * 对应 Java: com.amap.apis.utils.core.statistics.datastrategy.ByteJoinDataStrategy
 *
 * 功能：将多个数据块累积到内存中，调用 process 时返回合并结果并清空
 */
export declare class l56 implements k56 {
    private readonly o56;
    private chunks;
    constructor(n56?: k56);
    p56(): Uint8Array | null;
    protected processData(input: Uint8Array | null): Uint8Array | null;
    q56(data: Uint8Array | null): void;
    r56(): Uint8Array | null;
    s56(): k56 | null;
    /**
     * 添加日志数据（对应 addLogData）
     * @param datas Uint8Array 数据块
     */
    t56(m56: Uint8Array): void;
    /**
     * 处理数据：返回所有累积的数据，并清空缓存（对应 processData）
     * @returns 合并后的 Uint8Array
     */
    process(): Promise<Uint8Array>;
    /**
     * 工具方法：合并多个 Uint8Array
     */
    private u56;
    /**
     * 获取当前缓存的数据条数（可选：用于调试或策略判断）
     */
    w56(): number;
    /**
     * 清空所有缓存（可选：主动释放）
     */
    clear(): void;
}
