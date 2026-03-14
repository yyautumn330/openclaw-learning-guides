// @keepTs
// @ts-nocheck
import type { k56 } from './UpdateDataStrategy';
/**
 * 对应 Java: com.amap.apis.utils.core.statistics.datastrategy.EncryptRsaDataStrategy
 *
 * 功能：使用 RSA + AES 混合加密方式加密日志数据
 * 流程：
 *   - 生成随机 AES 密钥
 *   - 用 AES 加密数据体
 *   - 用预置公钥（Base64）RSA 加密 AES 密钥
 *   - 输出格式：[rsaEncAesKey][iv][encryptedData]
 */
export declare class f57 implements k56 {
    private readonly o56;
    private readonly b58;
    constructor(a58?: k56, publicKey?: string);
    process(): Promise<Uint8Array>;
    /**
     * 不直接处理，而是由上层调用 encrypt(data) 来触发加密
     */
    encrypt(y57: Uint8Array): Promise<Uint8Array>;
    /**
     * 执行 RSA + AES 混合加密
     */
    private c58;
    /**
     * 使用 RSA 公钥加密数据（PKCS1 或 OAEP）
     */
    private e58;
    /**
     * 工具：合并两个 Uint8Array
     */
    private d58;
    /**
     * 工具：按长度分块字符串（用于格式化 PEM）
     */
    private f58;
    t56(g57: Uint8Array): void;
}
