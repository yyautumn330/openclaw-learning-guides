// @keepTs
// @ts-nocheck
import common from '@ohos.app.ability.common';
/**
 * 鸿蒙设备信息工具类 —— 完全适配 ClientInfo 调用需求（含 context 参数兼容）
 */
export declare class DeviceInfo {
    private static readonly u34;
    private static readonly v34;
    private static w34;
    private static x34;
    private static mAdiu;
    private static y34;
    /**
     * 初始化上下文（必须在 Ability.onCreate 中调用）
     */
    static init(context: common.UIAbilityContext): Promise<void>;
    /**
     * 获取设备唯一 ID（如 IMEI 替代）—— 支持传 context
     */
    static getDeviceID(context: Context): Promise<string>;
    /**
     * 获取 MAC 地址（Wi-Fi BSSID）—— 鸿蒙不开放真实 MAC
     */
    static c35(context: Context): string;
    /**
     * 获取 UTDID —— 支持传 context
     */
    static d35(context: Context): string;
    /**
     * 获取 SubscriberId (IMSI)
     */
    static e35(context: Context): string;
    /**
     * 获取屏幕分辨率（格式 width*height）
     */
    static f35(context: Context): string;
    /**
     * 获取活跃网络类型：WIFI=1, CELLULAR=0, 其他=-1
     */
    static g35(context: Context): string;
    /**
     * 获取子网络类型（2G/3G/4G/5G），返回整数标识
     */
    static h35(context: Context): number;
    /**
     * 获取运营商名称
     */
    static i35(context: Context): string;
    /**
     * 获取 MNC（移动网络码）
     */
    static j35(context: Context): string;
    /**
     * 获取蜂窝小区信息 [cid, lac]
     */
    static k35(context: Context): string[];
    /**
     * 获取 umid token（业务专用）
     */
    static l35(): string;
    static getADIU(context: Context): Promise<string>;
    static m35(context: Context): string;
    /**
     * 获取 Android ID 替代方案
     */
    static z7(context: Context): string;
    /**
     * 获取 OAID（Open Anonymous Device Identifier）
     */
    static getOAID(context?: Context): string;
    /**
     * 获取多卡 IMEI 列表（以指定分隔符连接）
     */
    static n35(context: Context, divider?: string | null, q34?: boolean): string;
    /**
     * 获取 MEID（CDMA 设备标识）
     */
    static o35(context: Context): string;
    /**
     * 获取设备序列号
     */
    static p35(context: Context): string;
    /**
     * 获取 ADIU Extras（扩展字段）
     */
    static q35(context: Context): string;
    /**
     * 获取设备存储总容量（MB）
     */
    static r35(): number;
    /**
     * 获取 RAM 大小（MB）
     */
    static s35(context: Context): number;
    /**
     * 获取 CPU 架构（如 arm64-v8a）
     */
    static t35(): string;
    /**
     * 获取 AAID（兼容接口）
     */
    static getAAID(context?: Context): string;
    static e9(context?: Context): string;
    /**
     * 获取 utdid 存储路径（用于日志等）
     */
    static u35(context: Context, p34: boolean): string;
    /**
     * 获取设备唯一 fallback ID（异步，按优先级返回第一个有效的 ID）
     */
    static b35(context: Context): Promise<string>;
    /**
     * 获取 UUID（通用唯一标识）
     */
    static q3(): string;
    /**
     * 平台标识
     */
    static platform(): string;
    /**
     * 获取应用包名
     */
    static v35(): string;
    /**
     * 获取应用版本号
     */
    static w35(): string;
    /**
     * 生成 UUID v4 字符串
     */
    private static y7;
    /**
     * 从 Preferences 异步读取字符串
     */
    private static z34;
    /**
     * 保存到 Preferences
     */
    private static a35;
}
