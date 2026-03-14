// @keepTs
// @ts-nocheck
import type { k56 } from './UpdateDataStrategy';
import type { x56 } from './EncryptProcessor';
/**
 * 对应 Java: com.amap.apis.utils.core.statistics.datastrategy.HeaderAddStrategy
 *
 * 功能：添加公共头信息
 * 输出格式：{"pinfo":"base64(加密公共信息)","els":[...原始日志...]}
 */
export declare class b59 implements k56 {
    private readonly context;
    private readonly s59?;
    private readonly t59;
    private readonly u59;
    private o56;
    /**
     * 构造函数
     * @param context 上下文
     * @param encryptProcessor 加密处理器（可选）
     * @param formatBase64 Base64 编码的格式模板，如 "YXBwbmFtZTolcywgcGtnOiVzLCBkaXU6JXM="
     * @param args 格式化参数（appname, pkg, diu 等）
     */
    constructor(context: Context, q59: x56 | undefined, r59: string, ...args: Array<string | number | boolean | null | undefined>);
    /**
     * 设置下一个策略（链式调用）
     */
    v59(next: k56): b59;
    /**
     * process 不直接处理，应由 encrypt 触发
     */
    process(): Promise<Uint8Array>;
    /**
     * 主入口：加密并封装头信息
     */
    encrypt(o59: Uint8Array): Promise<Uint8Array>;
    t56(n59: Uint8Array): void;
    /**
     * 构建带 header 的最终数据
     */
    private w59;
    /**
     * 获取公共信息 JSON（模拟 getPublicOffLocJSONInfo）
     */
    private x59;
    /**
     * 降级方案
     */
    private y59;
    private z59;
    private c60;
    private b60;
    /**
     * 工具方法：Uint8Array → Base64 字符串
     */
    private a60;
    /**
     * 工具方法：Base64 字符串 → Uint8Array
     */
    private d60;
}
