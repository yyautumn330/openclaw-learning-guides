// @keepTs
// @ts-nocheck
import { WriteOptions } from '@ohos.file.fs';
import { w167 } from './interface/IUnzipItem';
import { z167 } from './interface/IUnZipListener';
export declare class n207 {
    static readonly TAG: string;
    static readonly r125: string;
    static readonly z264: string;
    static readonly s125: string;
    static readonly t125: string;
    private a265;
    constructor(x264: w167, y264: z167);
    close(): void;
    w207(): void;
    run(): void;
    private static t207;
    /**
     * 解压缩
     *
     * @param inFile    指定的待解压缩文件的文件路径，文件后缀需要以.zip结尾。文件路径必须为沙箱路径，沙箱路径可以通过context获取
     * @param destFile  指定的解压后的文件夹路径，文件夹目录路径需要在系统中存在，不存在则会解压失败。路径必须为沙箱路径，沙箱路径可以通过context获取，
     */
    static t232(inFile: string, outFile: string): void;
    static u232(content: string | ArrayBuffer, outFile: string, options?: WriteOptions): void;
    /**
     * 解压缩，提供了解压缩进度监听功能
     *
     * @param inFile    指定的待解压缩文件的文件路径，文件后缀需要以.zip结尾。文件路径必须为沙箱路径，沙箱路径可以通过context获取
     * @param destFile  指定的解压后的文件夹路径，文件夹目录路径需要在系统中存在，不存在则会解压失败。路径必须为沙箱路径，沙箱路径可以通过context获取，
     * @param onFinishProgress 暂不支持
     * @param onError 解压失败回调
     * @throws Exception
     */
    private static e265;
    private static f265;
    /**
     * 对zip解压缩的漏洞，只需要在调用zipEntry.getName()的时候，过滤返回值中的"../"跳转符
     *
     * @param path
     * @return
     */
    private static u125;
    private static readonly h265;
    /**
     * 文件探针
     * 当父目录不存在时，创建目录！
     *
     * @param dirFile
     */
    private static i265;
}
/**
 * 解压进度
 * @param progress 进度
 */
export type d264 = (progress: bigint) => void;
/**
 * 解压错误
 */
export type onError = () => void;
