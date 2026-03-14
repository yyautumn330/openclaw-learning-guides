// @keepTs
// @ts-nocheck
/**
 * 对应 Java: com.amap.apis.utils.core.encrypt.EncryptProcessor
 *
 * 功能：加密处理器基类（支持链式委托）
 */
export declare abstract class x56 {
    protected readonly c57?: x56;
    constructor(b57?: x56);
    /**
     * 主入口：执行加密
     */
    d57(z56: Uint8Array): Promise<Uint8Array>;
    /**
     * 子类必须实现的加密逻辑（如 RSA + AES 混合加密）
     */
    protected abstract e57(y56: Uint8Array): Promise<Uint8Array>;
}
