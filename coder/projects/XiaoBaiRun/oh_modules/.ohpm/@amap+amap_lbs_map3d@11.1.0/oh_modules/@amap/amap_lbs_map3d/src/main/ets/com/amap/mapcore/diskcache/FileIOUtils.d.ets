// @keepTs
// @ts-nocheck
import fs from '@ohos.file.fs';
import HashMap from '@ohos.util.HashMap';
export declare class r121 {
    private static readonly TAG;
    /**
     * Write file from bytes by channel.
     *
     * @param file    The file.
     * @param bytes   The bytes.
     * @param append  True to append, false otherwise.
     * @param isForce True to force write file, false otherwise.
     * @return {@code true}: success<br>{@code false}: fail
     */
    static b123(file: fs.File, bytes: ArrayBuffer, isForce?: boolean, append?: boolean): boolean;
    /**
     * Return the bytes in file by channel.
     *
     * @param file The file.
     * @return the bytes in file
     */
    static h123(file: fs.File): Int8Array;
    /**
     * Create a file if it doesn't exist, otherwise do nothing.
     *
     * @param file The file.
     * @return {@code true}: exists or creates successfully<br>{@code false}: otherwise
     */
    static k125(/* final */ file: fs.File): boolean;
    /**
     * Create a directory if it doesn't exist, otherwise do nothing.
     *
     * @param file The file.
     * @return {@code true}: exists or creates successfully<br>{@code false}: otherwise
     */
    static l125(/* final */ file: fs.File): boolean;
    /**
     * Return whether the file exists.
     *
     * @param filePath The path of file.
     * @return {@code true}: yes<br>{@code false}: no
     */
    static m125(file: string | fs.File): boolean;
    /**
     * Return the file by path.
     *
     * @param filePath The path of file.
     * @return the file
     */
    static n125(filePath: string): string;
    /**
     * Return whether the string is null or white space.
     *
     * @param s The string.
     * @return {@code true}: yes<br> {@code false}: no
     */
    static o125(/* final */ s: string): boolean;
    /**
     * 根据名称从压缩文件中提取内容
     * @param bytes 压缩数据
     * @param fileNames 需要提取的文件名称
     * @return
     */
    static r57(bytes: Int8Array, d125: string[]): HashMap<string, Int8Array>;
    private static p125;
    private static q125;
    /**
     * 判断byte[]是否是Gzip格式
     * @param data
     * @return
     */
    static r58(data: Int8Array): boolean;
    private static readonly r125;
    private static readonly s125;
    private static readonly t125;
    /**
     * 对zip解压缩的漏洞，只需要在调用zipEntry.getName()的时候，过滤返回值中的"../"跳转符
     *
     * @param path
     * @return
     */
    static u125(path: string): boolean;
    private static v125;
}
