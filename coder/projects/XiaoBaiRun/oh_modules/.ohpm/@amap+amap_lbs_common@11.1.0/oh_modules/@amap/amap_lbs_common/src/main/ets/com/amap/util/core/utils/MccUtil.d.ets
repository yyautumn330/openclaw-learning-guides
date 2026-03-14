// @keepTs
// @ts-nocheck
export declare class f94 {
    private static h94;
    /**
     * 判断MCC是否在中国大陆外（采用白名单；香港，澳门，台湾均在大陆外，并会返回TRUE）
     */
    static i94(context: Context, g94: boolean): boolean;
    /**
     * 大陆以外MCC集
     * del 111 123 134 199 850 665 560 598 by liqi
     */
    static readonly j94: string;
}
