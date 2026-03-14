// @keepTs
// @ts-nocheck
import HashMap from '@ohos.util.HashMap';
import { IRequest } from '../../net/IRequest';
import { SDKInfo } from '../../SDKInfo';
import { IAuthResponse } from '../../interface/IAuth';
import { IAMapCloudListener } from '../../interface/IAuth';
/**
 * 云控内容存储、读取
 */
declare class q76 {
    private static readonly h78;
    static readonly y29: number[];
    private static readonly i78;
    private j78;
    /**
     * 基础库云控返回值
     */
    private k78?;
    /**
     * 各个SDK请求过的云控，拼接了基础库的云控值，key位SDK名字，如navi
     */
    private l78;
    /**
     * 各个SDK的LctArgs
     */
    private m78;
    /**
     * 1、请求云控后，将业务SDK的lct、lct-info、aks等存储起来，第一次业务请求使用
     * 2、冷启动后不请求云控，读取之前请求过的云控内容，如lct、lct-info、aks，第一次业务请求使用
     */
    private n78;
    constructor();
    setCloudListener(g78: string, listener: IAMapCloudListener): void;
    o78(f78: string): void;
    i55(e78: string | undefined): IAMapCloudListener | undefined;
    /**
     * 云控返回处理，分用户云控和基础库云控处理
     *
     * @param authResponse 返回给业务的鉴权对象
     * @param authResult 解析后的云控值
     * @since 1.0.0
     */
    g76(z77: IAuthResponse, authResult: HashMap<string, Object> | undefined, a78: string[]): void;
    /**
     * 解密后端返回的云控数据。注意：数据中也包含鉴权相关的信息
     *
     * @param encryptData 服务返回的云控加密数据
     * @return AES解密后的云控数据
     * @since 1.0.0
     */
    e76(v77: Uint8Array): Promise<Uint8Array | string>;
    /**
     * 拼接基础库云控，和业务云控一起请求
     *
     * @param authKeys 请求的云控值
     * @since 1.0.0
     */
    y75(s77: Array<string>, t77: string): void;
    /**
     * 生成lctArgs并缓存
     *
     * @param sdkInfo SDK信息
     * @since 1.0.0
     */
    p78(m77: SDKInfo): void;
    /**
     * 获取某个SDK对应的LctArgs
     *
     * @param request 网络请求
     * @return LctArgs
     * @since 1.0.0
     */
    g33(request: IRequest): string | undefined;
    /**
     * 存储云控相关的信息，lct、lct-info、aks
     *
     * @param responseHeader 将服务返回responseHeader后传入进来
     * @since 1.0.0
     */
    d76(e77: HashMap<string, string>, context: Context): void;
    /**
     * 根据请求request获取对应SDK的云控信息
     *
     * @param request 网络请求
     * @return 云控相关信息，如：lct、lct-info、aks等
     * @since 1.0.0
     */
    e33(v76: string | undefined): HashMap<string, string> | undefined;
    g55(r76: string): Array<string> | undefined;
}
export declare const cloudManager: q76;
export {};
