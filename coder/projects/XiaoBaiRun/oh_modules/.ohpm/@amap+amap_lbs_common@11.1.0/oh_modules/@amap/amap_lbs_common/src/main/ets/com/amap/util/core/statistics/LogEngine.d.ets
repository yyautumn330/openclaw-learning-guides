// @keepTs
// @ts-nocheck
import { z14 } from './LogConfig';
/**
 * 日志引擎对外暴露的方法接口
 */
interface n61 {
    /**
     * 将日志内容写入磁盘（带加密）
     * @param fileKey - 文件唯一键
     * @param contents - 原始日志数据（Uint8Array）
     * @param logConfig - 日志配置
     */
    i61: (fileKey: string, contents: Uint8Array, logConfig: z14) => Promise<void>;
    /**
     * 上传待同步日志到服务器，并根据策略删除本地文件
     * @param logConfig - 日志配置
     * @returns 成功上传的字节数；失败返回 -1
     */
    m61: (logConfig: z14) => Promise<number>;
}
export declare const p61: n61;
export {};
