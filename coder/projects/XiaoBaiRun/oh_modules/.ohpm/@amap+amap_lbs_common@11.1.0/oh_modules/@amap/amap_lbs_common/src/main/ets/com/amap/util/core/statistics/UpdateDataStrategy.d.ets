// @keepTs
// @ts-nocheck
/**
 * 对应 Java: com.amap.apis.utils.core.statistics.datastrategy.UpdateDataStrategy（抽象基类）
 *
 * 功能：定义日志处理策略接口，支持链式调用
 * 流程：上层策略处理 → 交给下一层 → 最终输出
 */
export interface k56 {
    /**
     * 异步处理并返回最终日志数据（核心方法）
     * 子类必须实现具体逻辑
     *
     * @returns 处理后的字节数组
     */
    process(): Promise<Uint8Array>;
    /**
     * 添加一条原始日志数据（用于累积型策略）
     */
    t56(data: Uint8Array): void;
    /**
     * （可选）设置输入数据（如压缩前的数据）
     */
    v56?(data: Uint8Array): void;
}
/**
 * 扩展接口：支持同步获取当前已累积的日志数据
 *
 * 注意：
 * - 必须是同步方法
 * - 不应阻塞或抛未处理异常
 * - 用于上传前快速提取数据（如在 collectUpdateLogs 中使用）
 */
export interface f60 extends k56 {
    p56(): Uint8Array;
}
