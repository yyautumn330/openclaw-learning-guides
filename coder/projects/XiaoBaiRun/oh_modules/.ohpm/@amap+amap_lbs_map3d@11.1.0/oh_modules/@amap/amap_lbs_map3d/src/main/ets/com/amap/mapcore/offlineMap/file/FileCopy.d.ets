// @keepTs
// @ts-nocheck
import File from "@system.file";
/**
 * 文件相关操作 读写文件 删除文件（夹） 复制文件（夹）
 *
 * @author zxy
 */
export declare class i193 {
    static readonly p193: number;
    q193(l193: File, m193: File, n193: number, o193: number, listener: j193): number;
    private r193;
}
/**
 * 文件复制状态监听
 */
interface j193 {
    /**
     * 开始
     * @param inName  原始文件名称
     * @param outName 目标文件名称
     */
    s193(inName: string, outName: string): void;
    /**
     * 复制中间过程
     * @param inName 原始文件名称
     * @param outName 目标文件名称
     * @param completeCode 完成进度
     */
    t193(inName: string, outName: string, completeCode: number): void;
    /**
     * 复制完成
     * @param inName 原始文件名称
     * @param outName 目标文件名称
     */
    u193(inName: string, outName: string): void;
    /**
     * 复制出错
     * @param inName 原始文件名称
     * @param outName 目标文件名称
     * @param error 错误码
     */
    v193(inName: string, outName: string, error: number): void;
}
export {};
