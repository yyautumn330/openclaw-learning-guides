// @keepTs
// @ts-nocheck
import util from '@ohos.util';
import HashMap from '@ohos.util.HashMap';
export declare class Utils {
    static encoder: util.TextEncoder;
    static decode: util.TextDecoder;
    /**
     * 自定义加密用的 Base64 编码（模拟 Android 的 coreEncodeBase64）
     */
    private static i99;
    /**
     * 自定义解密用的 Base64 解码（模拟 Android 的 coreDecodeBase64）
     */
    private static j99;
    /**
     * 将字符串进行伪装式 Base64 编码，在前面加一个表示长度模26的字母前缀
     * @param data 输入字符串
     * @returns {string | null} 转换后字符串，失败返回 null
     */
    /**
     * 解析由 toSelfBase64 生成的字符串，去除第一个字符后进行 Base64 解码
     * @param data 输入的伪装 Base64 字符串
     * @returns {string} 解码后的原始字符串，出错或太短则返回空串
     */
    static fromSelfBase64(data: string): string;
    static stringToUint8Array(data: string): Uint8Array;
    static uint8ArrayToString(data: Uint8Array): string;
    static p94(bytes: Uint8Array): string;
    static i33(str: string | undefined): string;
    static h33(x98: object | undefined): HashMap<string, string> | undefined;
    static k99(b: Uint8Array): string;
    static l99(bytes: Uint8Array): string;
    static toSelfBase64(src: string): string;
    private static s38;
    /**
     * gzip压缩
     *
     * @param data
     * @return
     */
    static n84(byteArray: Uint8Array): Promise<Uint8Array>;
    static getPublicKey(): string;
}
