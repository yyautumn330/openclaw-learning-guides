// @keepTs
// @ts-nocheck
import { SDKInfo } from '../SDKInfo';
export declare class v97 {
    /**
     * 各个SDK的 SDKInfo
     */
    private z97;
    constructor();
    /**
     * 存储SDKInfo，App 冷启动后都需要通过鉴权接口注册来存储
     *
     * @param sdkInfo sdk信息
     * @since 1.0.0
     */
    u75(x97: SDKInfo): void;
    /**
     * 获取存储的SDK信息
     *
     * @param sdkName sdk名字
     * @return SDKInfo 信息
     * @since 1.0.0
     */
    h55(w97: string): SDKInfo | undefined;
}
export declare const r54: v97;
