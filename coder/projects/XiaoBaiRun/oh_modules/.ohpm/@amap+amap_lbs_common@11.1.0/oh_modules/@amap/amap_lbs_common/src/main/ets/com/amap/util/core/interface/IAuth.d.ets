// @keepTs
// @ts-nocheck
import HashMap from '@ohos.util.HashMap';
import { SDKInfo } from '../SDKInfo';
export type p39 = (response: IAuthResponse) => void;
/**
 * 高德SDK服务接口
 */
export interface IAuthManager {
    /**
     * APIkey。设置key，需要在高德官网控制台绑定对应的bundleid。
     */
    o32: string;
    /**
     * 是否开启HTTPS，从1.3.3版本开始默认为YES。
     */
    q39: boolean;
    /**
     * 设备标识，内部生成。用于排查问题时提供。
     */
    identifier: string;
    /**
     * 云控请求
     *
     * @param sdkInfo SDK 信息
     * @param authKeys 云控key
     * @param context Context
     * return IAuthResponse 云控请求结果
     */
    registerAuthWithComponent(sdkInfo: SDKInfo, authKeys: Array<string>, context: Context): Promise<IAuthResponse>;
    /**
     * 注册SDK，业务SDK如果冷启动后不调用registerAuthWithComponent方法，则需要调用此方法进行注册
     *
     * @param sdkInfo SDK 信息
     * @param context Context
     */
    registerWithComponent(sdkInfo: SDKInfo, context: Context): void;
}
/**
 * 云控请求返回结果
 */
export interface IAuthResponse {
    /**
     * 是否已授权
     */
    status: boolean;
    /**
     * responseInfo
     */
    info: string;
    /**
     * infocode
     */
    infocode: string;
    /**
     * 返回值
     */
    result?: HashMap<string, Object>;
}
export interface IAMapCloudListener {
    onCloudChanged: (location: IAuthResponse) => void;
}
