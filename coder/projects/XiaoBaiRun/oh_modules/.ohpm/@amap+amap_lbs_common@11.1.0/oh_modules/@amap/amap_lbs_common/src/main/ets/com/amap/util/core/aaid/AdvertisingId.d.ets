// @keepTs
// @ts-nocheck
/**
 * AdvertisingId 工具类（HarmonyOS 兼容版）
 *
 * 注意：HarmonyOS 不支持 Google Advertising ID (GAID)。
 * 本实现始终返回空广告 ID，并按合规要求视为不可用。
 */
export declare class r9 {
    /**
     * 内部获取广告信息（无参数，因鸿蒙无需上下文）
     * @returns 符合 AdInfo 接口的对象
     */
    private static t9;
    /**
     * 获取广告 ID（扩展版）：若限制跟踪或 ID 为空，返回 null
     * @returns 广告 ID 字符串，不可用时返回 null
     */
    static u9(): string | null;
    /**
     * 获取广告 ID（基础版）：仅当 ID 非空时返回
     * @returns 广告 ID 字符串，不可用时返回 null
     */
    static getId(): string | null;
}
