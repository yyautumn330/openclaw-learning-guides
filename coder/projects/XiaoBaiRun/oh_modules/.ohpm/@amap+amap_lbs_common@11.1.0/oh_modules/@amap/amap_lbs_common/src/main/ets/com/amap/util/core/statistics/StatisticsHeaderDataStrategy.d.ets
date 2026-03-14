// @keepTs
// @ts-nocheck
import type { k56 } from './UpdateDataStrategy';
/**
 * 对应 Java: com.amap.apis.utils.core.statistics.datastrategy.StatisticsHeaderDataStrategy
 *
 * 功能：生成统计日志头部信息，并与原始数据拼接
 * 格式：[header][body]
 * header 中每个字段都以“2字节长度 + UTF-8内容”方式写入
 */
export declare class j65 implements k56 {
    private readonly context;
    private readonly o56;
    private static readonly s65;
    static t65: number;
    static u65: number;
    constructor(context: Context, r65?: k56);
    /**
     * 添加日志数据 —— 不在此缓存，直接交给下层处理
     */
    t56(q65: Uint8Array): void;
    /**
     * 处理数据：生成 header 并拼接到原始数据前
     */
    process(): Promise<Uint8Array>;
    /**
     * 构建 Header 字节数组
     */
    private getHeader;
    private getDeviceID;
    private c35;
    private d35;
    private v65;
    private p5;
    private getDevice;
    private e35;
    private getPackageName;
    private w35;
    private w65;
    private i65;
    private u56;
}
