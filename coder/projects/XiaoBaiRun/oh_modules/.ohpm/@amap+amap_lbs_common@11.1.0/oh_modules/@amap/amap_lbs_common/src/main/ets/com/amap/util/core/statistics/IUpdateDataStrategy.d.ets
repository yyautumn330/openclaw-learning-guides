// @keepTs
// @ts-nocheck
/**
 * 对应 Java 接口：com.amap.apis.utils.core.statistics.datastrategy.UpdateDataStrategy
 *
 * 定义日志数据处理策略的标准方法（必须为 interface）
 */
export interface e60 {
    /**
     * 输入原始数据块（如单条日志）
     */
    inputData(data: Uint8Array): void;
    /**
     * 获取最终打包后的数据（用于上传）
     */
    p56(): Uint8Array | null;
    /**
     * 处理当前层的数据（子类实现）
     */
    processData(input: Uint8Array | null): Uint8Array | null;
    /**
     * 设置初始输入数据集
     */
    q56(data: Uint8Array | null): void;
    /**
     * 添加一条日志数据（可选扩展）
     */
    t56(data: Uint8Array): void;
    /**
     * 获取当前输入数据（调试用）
     */
    r56(): Uint8Array | null;
    /**
     * 获取下游策略节点
     */
    s56(): e60 | null;
}
