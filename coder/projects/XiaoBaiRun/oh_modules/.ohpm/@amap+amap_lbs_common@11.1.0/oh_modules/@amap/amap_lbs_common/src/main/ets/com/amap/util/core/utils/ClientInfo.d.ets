// @keepTs
// @ts-nocheck
export declare class ClientInfo {
    private static readonly w9;
    /**
     * 获取进行网络请求需要的安全码
     *
     * @param context
     * @param ts        进行计算时的ts时间戳
     * @param paramsStr 进行计算的串，需要先进行排序
     */
    static getScode(context: Context, f83: string, g83: string): string;
    static getClientXInfo(context: Context, e83: boolean): Promise<string | undefined>;
    private static j83;
    private static k83;
    private static m84;
    /**
     * 归一化输入为 Uint8Array
     */
    private static p84;
    private static q84;
    /**
     * 与 Android rsaPartData 保持一致：
     * - 前 117 字节用 RSA 加密 → 输出 128 字节
     * - 超出部分直接拼接（明文！）
     */
    private static o84;
    /**
     * 写字段
     */
    static l83(arr: Uint8Array, str: string): Uint8Array;
    private static getEntity;
}
