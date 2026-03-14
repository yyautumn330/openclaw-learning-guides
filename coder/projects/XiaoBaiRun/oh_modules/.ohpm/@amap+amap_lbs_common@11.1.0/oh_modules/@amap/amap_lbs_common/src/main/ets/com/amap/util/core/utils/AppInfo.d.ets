// @keepTs
// @ts-nocheck
export declare class AppInfo {
    private static z70;
    private static a71;
    private static u27;
    private static mKey;
    protected static b71: string;
    protected static c71: boolean;
    private static d71;
    static getPackageName(context: Context): string;
    static e71(): number;
    static f71(context: Context): string;
    static getApplicationVersion(): string;
    static setApiKey(key: string): void;
    static getApiKey(): string;
    /**
     * 获取app的Sha1和包名
     *
     * @param context
     */
    static g71(context: Context): string;
}
