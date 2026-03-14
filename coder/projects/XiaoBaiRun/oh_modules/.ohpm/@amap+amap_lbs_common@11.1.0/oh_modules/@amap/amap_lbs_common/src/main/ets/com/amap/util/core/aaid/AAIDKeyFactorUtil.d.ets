// @keepTs
// @ts-nocheck
/**
 * AAID 关键字段工具类
 * 对应 Android 原版 AAIDKeyFactorUtil 的鸿蒙移植版本
 */
export declare class g5 {
    /**
     * 获取设备型号
     * @returns 设备型号字符串（如 "HUAWEI P50"）
     */
    static p5(): string;
    /**
     * 获取操作系统版本
     * @returns OS 版本号（如 "4.0.0"）
     */
    static q5(): string;
    /**
     * 获取 SDK 版本
     * @returns SDK 版本号（来自 ConstConfig）
     */
    static getSDKVersion(): string;
    /**
     * 获取操作系统类型
     * @returns 固定返回 "HarmonyOS"
     */
    static r5(): string;
    /**
     * 获取 UUID（本地缓存或新生成）
     * @param context - 应用上下文
     * @returns UUID 字符串
     */
    static q3(context: Context): Promise<string>;
    /**
     * 获取包名
     * @param context - 应用上下文
     * @returns 应用包名
     */
    static getPackageName(context: Context): string;
    /**
     * 获取 Android ID（鸿蒙中无此概念，由 DeviceInfo 提供替代 ID）
     * @param context - 应用上下文
     * @returns 设备唯一标识
     */
    static z5(context: Context): string;
    /**
     * 获取缓存的 AAID
     * @param context - 应用上下文
     * @returns 缓存的 AAID
     */
    static x3(context: Context): Promise<string>;
    /**
     * 获取缓存的 UABC
     * @param context - 应用上下文
     * @returns 缓存的 UABC
     */
    static b4(context: Context): Promise<string>;
    /**
     * 获取缓存的 ResetToken
     * @param context - 应用上下文
     * @returns 缓存的 ResetToken
     */
    static d4(context: Context): Promise<string>;
    /**
     * 获取 T1（原为 /proc/sys/kernel/random/boot_id，鸿蒙不支持）
     * @param context - 应用上下文
     * @returns 空字符串（鸿蒙无权限访问 /proc 文件系统）
     */
    static s5(context: Context): string;
    /**
     * 获取缓存的 T1
     * @param context - 应用上下文
     * @returns 缓存的 T1
     */
    static f4(context: Context): Promise<string>;
    /**
     * 获取 T2（原为 stat /data/app，鸿蒙沙箱限制）
     * @param context - 应用上下文
     * @returns 空字符串（鸿蒙禁止执行 shell 命令）
     */
    static t5(context: Context): string;
    /**
     * 获取缓存的 T2
     * @param context - 应用上下文
     * @returns 缓存的 T2
     */
    static h4(context: Context): Promise<string>;
    /**
     * 获取 T3（原为 stat /data/，鸿蒙不支持）
     * @param context - 应用上下文
     * @returns 空字符串
     */
    static u5(context: Context): string;
    /**
     * 获取缓存的 T3
     * @param context - 应用上下文
     * @returns 缓存的 T3
     */
    static j4(context: Context): Promise<string>;
    /**
     * 获取 S1（原为 stat /data/data，鸿蒙不支持）
     * @param context - 应用上下文
     * @returns 空字符串
     */
    static v5(context: Context): string;
    /**
     * 获取缓存的 S1
     * @param context - 应用上下文
     * @returns 缓存的 S1
     */
    static m4(context: Context): Promise<string>;
    /**
     * 获取 S2（原为 stat /data/app，鸿蒙不支持）
     * @param context - 应用上下文
     * @returns 空字符串
     */
    static w5(context: Context): string;
    /**
     * 获取缓存的 S2
     * @param context - 应用上下文
     * @returns 缓存的 S2
     */
    static o4(context: Context): Promise<string>;
    /**
     * 获取 S3（原为 inode of /data/data，鸿蒙不支持）
     * @param context - 应用上下文
     * @returns 空字符串
     */
    static x5(context: Context): string;
    /**
     * 获取缓存的 S3
     * @param context - 应用上下文
     * @returns 缓存的 S3
     */
    static r4(context: Context): Promise<string>;
    /**
     * 获取 S4（原为 inode of /data/app，鸿蒙不支持）
     * @param context - 应用上下文
     * @returns 空字符串
     */
    static y5(context: Context): string;
    /**
     * 获取缓存的 S4
     * @param context - 应用上下文
     * @returns 缓存的 S4
     */
    static u4(context: Context): Promise<string>;
    /**
     * 生成标准 UUID（兼容 API 9+）
     * 若运行环境支持 crypto.randomUUID()（API 10+），优先使用；
     * 否则使用 Math.random 模拟生成。
     * @returns UUID 字符串（如 "f47ac10b-58cc-4372-a567-0e02b2c3d479"）
     */
    private static y7;
    /**
     * 获取主机名并 MD5 加密（鸿蒙无 net.hostname 系统属性）
     * 函数暂时置空
     * @returns 主机名 MD5 值，若不可用则返回 null
     */
    static a6(): string | null;
    /**
     * 计算字符串的 MD5 哈希值
     * @param input - 输入字符串
     * @returns MD5 小写十六进制字符串
     */
    static a8(input: string): string;
    /**
     * 获取 GAID（谷歌广告 ID，鸿蒙中由 DeviceInfo 提供替代方案）
     * @param context - 应用上下文
     * @returns GAID 或空字符串
     */
    static w4(context: Context): string;
    /**
     * 获取缓存的 GAID
     * @param context - 应用上下文
     * @returns 缓存的 GAID
     */
    static b8(context: Context): Promise<string>;
    /**
     * 获取 OAID（匿名设备标识，鸿蒙中由 DeviceInfo 提供）
     * @param context - 应用上下文
     * @returns OAID 或空字符串
     */
    static getOAID(context: Context): string;
    /**
     * 获取缓存的 OAID
     * @param context - 应用上下文
     * @returns 缓存的 OAID
     */
    static v3(context: Context): Promise<string>;
    /**
     * 异或算法加密/解密
     * @param data - 数据（Uint8Array）
     * @param key - 密钥（Uint8Array）
     * @returns 加密/解密后的 Uint8Array
     */
    static xor(data: Uint8Array, key: Uint8Array): Uint8Array;
}
