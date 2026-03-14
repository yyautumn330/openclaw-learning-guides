// @keepTs
// @ts-nocheck
import { SDKInfo } from '../SDKInfo';
export declare enum AMapPrivacyShowStatus {
    Unknown = -1,
    NotShow = 0,
    DidShow = 1
}
/**
 * 集成SDK隐私信息状态  -1: unknown , 0 : 未集成 ， 1 ： 已集成
 */
export declare enum AMapPrivacyInfoStatus {
    Unknown = -1,
    NotContain = 0,
    DidContain = 1
}
/**
 * 用户同意隐私状态 -1: unknown , 0 : 未同意 ， 1 ： 已同意
 */
export declare enum AMapPrivacyAgreeStatus {
    Unknown = -1,
    NotAgree = 0,
    DidAgree = 1
}
export declare class r39 {
    static readonly s39: number;
    static readonly t39: number;
    static readonly u39: number;
    static readonly v39: number;
    static readonly w39: number;
    static readonly x39: number;
    static readonly y39: number;
    static readonly z39: number;
    static readonly a40: string;
    static readonly b40: string;
    static readonly c40: string;
    static readonly d40: string;
    static readonly e40: string;
    static readonly f40: string;
    static readonly g40: string;
    static readonly h40: string;
}
/**
 * 隐私授权
 */
export interface IPrivacy {
    /**
     * 更新显示隐私弹窗状态和包含高德SDK隐私协议内容状态。
     *
     * @param showStatus 隐私弹窗状态展示状态
     * @param containStatus 包含高德SDK隐私协议内容状态
     * @param sdkInfo sdk信息
     * @since 1.0.0
     */
    updatePrivacyShow(showStatus: AMapPrivacyShowStatus, containStatus: AMapPrivacyInfoStatus, sdkInfo: SDKInfo, context: Context): void;
    /**
     * 更新用户同意高德SDK隐私协议状态
     *
     * @param agreeStatus 是否同意隐私政策协议
     * @param sdkInfo sdk信息
     * @since 1.0.0
     */
    updatePrivacyAgree(agreeStatus: AMapPrivacyAgreeStatus, sdkInfo: SDKInfo, context: Context): void;
    /**
     * 检查当前隐私相关状态是否满足隐私协议合规要求
     *
     * @param sdkInfo sdk信息
     * @returns true: 已授权，false: 未授权
     * @since 1.0.0
     */
    checkPrivacyStatus(sdkInfo: SDKInfo, context: Context): boolean;
}
