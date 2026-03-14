// @keepTs
// @ts-nocheck
import type { k56 } from './UpdateDataStrategy';
/**
 * 对应 Java: com.amap.apis.utils.core.statistics.datastrategy.ZipUpdateDataStrategy
 *
 * 功能：使用 zlib 压缩原始数据（兼容 Android 端 zip 格式）
 * 注意：HarmonyOS 不内置 pako，需引入轻量级 zlib 实现
 */
export declare class y65 implements k56 {
    private readonly o56;
    constructor(q68?: k56);
    /**
     * 添加日志数据（透传给下一层）
     */
    t56(p68: Uint8Array): void;
    /**
     * 处理数据：对输入数据执行 zlib 压缩
     */
    process(): Promise<Uint8Array>;
    /**
     * 使用内置或第三方库进行 zlib 压缩
     * 当前为模拟实现（实际需接入真实压缩库）
     */
    private r68;
    /**
     * 解压测试方法（可选：用于调试验证）
     */
    static s68(j68: Uint8Array): Promise<Uint8Array>;
}
