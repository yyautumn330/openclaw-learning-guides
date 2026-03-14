// @keepTs
// @ts-nocheck
import HashMap from '@ohos.util.HashMap';
import { SDKInfo } from '../../SDKInfo';
import { AMapPrivacyInfoStatus, AMapPrivacyShowStatus, AMapPrivacyAgreeStatus, IPrivacy } from '../../interface/IPrivacy';
declare class u94 implements IPrivacy {
    privacyInfo: AMapPrivacyInfoStatus;
    t95: AMapPrivacyShowStatus;
    u95: string;
    v95: string;
    showTime: string;
    w95: AMapPrivacyAgreeStatus;
    x95: string;
    y95: string;
    z95: string;
    a96: string;
    b96: string;
    updatePrivacyShow(p95: AMapPrivacyShowStatus, q95: AMapPrivacyInfoStatus, r95: SDKInfo, context: Context): void;
    updatePrivacyAgree(m95: AMapPrivacyAgreeStatus, n95: SDKInfo, context: Context): void;
    /**
     * 检查授权状态
     *
     * @param sdkInfo sdk信息
     * @returns true：已授权，false：未授权
     * @since 1.0.0
     */
    checkPrivacyStatus(i95: SDKInfo, context: Context): boolean;
    c96(context: Context): void;
    /**
     * 加载用户授权缓存。注意：需要在 AuthManagerImpl 中注册SDK时加载
     */
    d96(context: Context): boolean;
    f96(b95: AMapPrivacyInfoStatus): number;
    g96(a95: AMapPrivacyShowStatus): number;
    h96(z94: AMapPrivacyAgreeStatus): number;
    /**
     * 隐私授权上传服务
     *
     * @param sdkInfo sdk信息
     * @since 1.0.0
     */
    e96(w94: SDKInfo, context: Context): void;
    /**
     * 获取请求头
     *
     * @param sdkInfo sdk信息
     * @returns 组装完毕的请求头
     * @since 1.0.0
     */
    getRequestHeader(v94: SDKInfo): Record<string, string>;
    /**
     * 获取请求参数
     *
     * @returns 组装完毕的请求参数
     * @since 1.0.0
     */
    i96(): HashMap<string, string>;
}
export declare const privacyImpl: u94;
export {};
