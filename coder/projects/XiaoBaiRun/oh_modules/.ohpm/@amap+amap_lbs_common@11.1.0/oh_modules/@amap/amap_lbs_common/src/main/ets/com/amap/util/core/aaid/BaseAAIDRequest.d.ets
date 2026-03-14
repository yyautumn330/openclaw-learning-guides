// @keepTs
// @ts-nocheck
import { Context as Context } from "@ohos.abilityAccessCtrl";
import { v9 } from '../utils/IPV6Request';
/**
 * AAID 请求基类，用于构建通用的网络请求参数、头信息和 URL。
 */
export declare class f5 extends v9 {
    protected mContext: Context;
    /**
     * 构造函数
     *
     * @param context - 应用上下文，用于获取应用相关信息
     */
    constructor(context: Context);
    b10(a10: number): void;
    setConnectionTimeout(z9: number): void;
    /**
     * 获取网络请求的头信息
     *
     * @returns 包含请求头的 Map 对象
     */
    c10(): Map<string, string>;
    /**
     * 获取网络请求的参数
     *
     * @returns 包含请求参数的 Map 对象
     */
    getParams(): Map<string, string>;
    /**
     * 获取网络请求的完整 URL
     *
     * @returns 请求的 URL 字符串（HTTP 或 HTTPS）
     */
    d10(): string;
    /**
     * 获取 SDK 名称
     *
     * @returns SDK 名称字符串
     */
    getSDKName(): string;
}
