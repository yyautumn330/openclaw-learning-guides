// @keepTs
// @ts-nocheck
/**
 * 根据运控，本地，及用户策略设置是否强制使用https
 */
export declare class HttpsDecisionUtil {
    /**
     * Android P (也叫Android 9) 对应的targetVersion
     */
    private static readonly u89;
    private static instance;
    private strategy;
    private v89;
    private constructor();
    static getInstance(): HttpsDecisionUtil;
    /**
     * 解析 URL 字符串为对象
     * @param urlStr URL 字符串
     * @return 解析后的 URL 对象
     */
    private static l46;
    /**
     * 初始化Context；
     * 初始化adiu联网获取能力，小包和大包在定位上测试，体积大小无差别了。后续只用打包即可。不然编译小包AdiuManager在大包中依赖不到。
     * @param context
     */
    w89(context: Context): void;
    clear(context: Context): void;
    /**
     * 用户设置了使用https
     * @param isHttps
     */
    a90(r89: boolean): void;
    /**
     * 云控设置了使用https
     * @param context
     * @param isTargetRequired
     */
    c90(context: Context, q89: boolean): void;
    e10(): boolean;
    private static readonly e90;
    private static readonly i51;
    private static readonly f90;
    private d90;
    private y89;
    private z89;
    /**
     * 将http URL转换为https URL
     * @param urlStr
     * @return
     */
    static g90(l89: string): string;
    /**
     * 如果是19，则强制使用http。防止native崩溃
     * @return
     */
    static h90(): boolean;
    /**
     * HttpUrlUtil是否可以使用https
     * @param param 为发起请求时，sdk的设置
     * @return
     */
    isShouldHttps(param: boolean): boolean;
}
