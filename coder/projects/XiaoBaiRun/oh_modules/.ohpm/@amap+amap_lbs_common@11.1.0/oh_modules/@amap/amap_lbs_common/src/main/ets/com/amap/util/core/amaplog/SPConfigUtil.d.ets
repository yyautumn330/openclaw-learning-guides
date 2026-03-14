// @keepTs
// @ts-nocheck
/**
 * md5("ERROR_LOG_CONFIG")
 */
import common from '@ohos.app.ability.common';
import { SDKInfo } from "../SDKInfo";
export declare const v19: string;
/**
 * 工具类：用于读写加密的 SharedPreferences 配置
 * 支持按 SDK 名称、版本、CPU 类型保存和读取配置项
 */
export declare class w19 {
    private x15;
    private static o21;
    /**
     * 获取 SPConfigUtil 实例
     *
     * @param sdkInfo SDK 信息对象，必须包含非空的 SDKName
     * @returns SPConfigUtil 实例，若参数无效则返回 null
     */
    static getInstance(m21: SDKInfo): w19 | null;
    /**
     * 构造函数
     *
     * @param sdkInfo SDK 信息
     */
    private constructor();
    /**
     * 读取指定配置
     *
     * @param context 应用上下文
     * @param sdkVersion SDK 版本，可为空表示忽略匹配
     * @param cpuType CPU 类型，可为空表示忽略匹配
     * @param key 配置键名
     * @returns 匹配的配置内容，未找到返回 null，无配置返回空字符串
     */
    p21(context: common.Context, e21: string, f21: string, key: string): Promise<string | null>;
    /**
     * 保存配置。如果已存在相应配置，则更新；否则新增
     *
     * @param context 应用上下文
     * @param sdkVersion SDK 版本，可为空
     * @param cpuType CPU 类型，可为空
     * @param key 配置键名
     * @param content 配置内容
     */
    s21(context: common.Context, x20: string, y20: string, key: string, content: string): Promise<void>;
    /**
     * 内部方法：保存配置到 SharedPreferences（加密）
     *
     * @param context 应用上下文
     * @param sdkName SDK 名称
     * @param key 配置键
     * @param content JSON 字符串内容
     */
    private t21;
    /**
     * 内部方法：从 SharedPreferences 读取配置（解密）
     *
     * @param context 应用上下文
     * @param sdkName SDK 名称
     * @param key 配置键
     * @returns 解密后的配置字符串
     */
    private q21;
    /**
     * 保存加密后的字符串到 Preferences
     *
     * @param context 应用上下文
     * @param spKey 存储文件名（Key）
     * @param key 键名
     * @param jsonStr 原始 JSON 字符串
     */
    private static u21;
    /**
     * 清空指定配置（通过写入空字符串）
     *
     * @param context 应用上下文
     * @param spKey 存储文件名
     * @param key 键名
     */
    private static w21;
    /**
     * 从 Preferences 读取并解密配置
     *
     * @param context 应用上下文
     * @param spKey 存储文件名
     * @param key 键名
     * @returns 解密后的字符串，失败返回空字符串
     */
    private static v21;
}
