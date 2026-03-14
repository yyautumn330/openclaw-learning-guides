// @keepTs
// @ts-nocheck
import fs from "@ohos.file.fs";
import { Context as Context } from "@ohos.abilityAccessCtrl";
export declare class m40 {
    private static readonly TAG;
    private static readonly p235;
    static readonly separator = "/";
    /**
     * 读取文件内容
     * @param filePath 文件路径
     * @returns Uint8Array内容
     */
    static e58(filePath: string): Uint8Array | undefined;
    /**
     * 读取 rawfile 目录下的指定文件
     * @param context 应用上下文
     * @param rawfilePath rawfile 目录下的文件路径（如 'test.txt'）
     * @returns 文件内容的string，失败返回 ''
     */
    static u41(context: Context, m235: string): Uint8Array | undefined;
    /**
     * 读取 rawfile 目录下第一个前缀匹配的文件
     * @param context 应用上下文
     * @param rawfilePath rawfile 目录下的文件目录
     * @param preName 文件名前缀
     * @returns 文件内容的string，失败返回 ''
     */
    static s41(context: Context, i235: string, j235: string): Uint8Array | undefined;
    /**
     * 保存文件内容到指定文件目录
     * @param filePath
     * @param data
     */
    static p216(filePath: string, data: Uint8Array): void;
    /**
     *
     * @param stream
     */
    private static q235;
    /**
     *
     * @param file
     */
    static v125(file: fs.File | undefined): void;
    /**
     * 判断byte[]是否是Gzip格式
     * @param data
     * @return
     */
    static r58(data: Uint8Array): boolean;
    static compress(data: Uint8Array | undefined): Promise<Uint8Array | undefined>;
    static i58(data: Uint8Array | undefined): Promise<Uint8Array | undefined>;
    /**
     * 将压缩数据压缩到沙箱目录，然后再解压，再提取需要的文件和清除多余文件。
     * @param data
     * @param context
     * @param fileNames
     * @returns
     */
    static r235(data: Uint8Array | undefined, w234: string[] | undefined, context: Context): Promise<Map<string, Uint8Array> | undefined>;
    /**
     * 根据指定字符串获取压缩文件中的内容
     * @param data 压缩数据
     * @param names 压缩文件名数组
     * @param context 上下文
     * @returns 获取的内容
     */
    static r57(data: Uint8Array, names: string[] | undefined, context: Context): Promise<Map<string, Uint8Array>>;
    /**
     * 使用沙箱目录作为存储
     * @param context
     * @returns
     */
    static s235(context: Context): string | undefined;
    /**
     * 检查目录是否可写
     * @param path
     * @returns
     */
    static t235(path: string): boolean;
    /**
     * 将Uint8Array数据保存到文件
     * @param fileName 文件路径
     * @param data 数据
     */
    static u235(fileName: string, data: Uint8Array): void;
    static l208(context: Context): string;
}
