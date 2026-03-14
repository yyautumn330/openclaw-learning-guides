// @keepTs
// @ts-nocheck
export declare class ClientInfo {
    /**
     * 获取进行网络请求需要的安全码
     *
     * @param context
     * @param ts        进行计算时的ts时间戳
     * @param paramsStr 进行计算的串，需要先进行排序
     */
    static getScode(context: Context, x4: string, y4: string): string;
    static b5(): string;
}
