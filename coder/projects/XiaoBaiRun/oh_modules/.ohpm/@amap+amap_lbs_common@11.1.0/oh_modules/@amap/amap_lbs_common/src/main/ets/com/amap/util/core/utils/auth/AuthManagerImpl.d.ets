// @keepTs
// @ts-nocheck
import { IAuthManager, IAuthResponse } from '../../interface/IAuth';
import { SDKInfo } from '../../SDKInfo';
import HashMap from '@ohos.util.HashMap';
import { IResponse } from '../../net/IResponse';
import { IRequest } from '../../net/IRequest';
declare class AuthManagerImpl implements IAuthManager {
    private p75;
    o32: string;
    q39: boolean;
    identifier: string;
    constructor();
    setApiKey(o75: string): void;
    getApiKey(): string;
    t75(n75: boolean): void;
    /**
     * 注册SDK，业务SDK如果冷启动后不调用registerAuthWithComponent方法，则需要调用此方法进行注册
     *
     * @param sdkInfo SDK 信息
     * @param context Context
     */
    registerWithComponent(m75: SDKInfo, context: Context): void;
    /**
     * 外部调用请求云控，forceUpdate用于控制是否强制更新云控
     *
     * @param sdkInfo SDK信息
     * @param authKeys 云控值
     * @returns IAuthResponse
     */
    registerAuthWithComponent(g75: SDKInfo, h75: Array<string>, context: Context): Promise<IAuthResponse>;
    /**
     * 鉴权&获取云控异常后，默认的 IAuthResponse
     *
     * @returns 默认的 IAuthResponse
     */
    x75(): Promise<IAuthResponse>;
    /**
     * 请求云控
     *
     * @param sdkInfo SDK信息
     * @param authKeys 云控值
     * @param params 其他参数
     */
    requestAuthWithComponent(t74: SDKInfo, u74: Array<string>, params: HashMap<string, string> | undefined, context: Context, v74?: boolean): Promise<IAuthResponse>;
    b76(response: IResponse, l74: IAuthResponse, request: IRequest, context: Context): HashMap<string, string> | undefined;
    b48(response: IResponse, f74: Array<string>): Promise<IAuthResponse>;
    /**
     * 处理鉴权状态
    */
    f76(d74: IAuthResponse, jsonObject: IAuthResponse): void;
    /**
     * 鉴权相关的处理
     *
     * @param info 错误信息
     * @param responseHeader 请求头
     * @param sdkInfo 上层SDK信息
     */
    w75(info: string, t73: HashMap<string, string> | undefined, result: string | Object | ArrayBuffer | undefined, u73: SDKInfo, context: Context): Promise<void>;
    /**
     * 判断是否可以进行APIKey lenght的判断
    */
    v75(): Promise<void>;
    a76(p73: SDKInfo, q73: string): Object;
    z75(j73: SDKInfo, k73: Array<string>): Uint8Array | undefined;
}
export declare const authManager: AuthManagerImpl;
export {};
