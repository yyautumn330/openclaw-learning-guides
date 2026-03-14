// @keepTs
// @ts-nocheck
import http from '@ohos.net.http';
import HashMap from '@ohos.util.HashMap';
export interface IRequest extends http.HttpRequestOptions {
    url: string;
    params?: HashMap<string, string>;
    isREST?: boolean;
    /**
     * body是否使用Pandora,如果为true，encryptedData必须有值
     */
    isPandoraBody?: boolean;
    /**
     * 通常网络模块内部处理
     */
    infoStr?: string;
    /**
     * 日志版本
     */
    logVersion?: string;
    /**
     * 平台信息
     */
    platInfo?: string;
    /**
     * 待加密数据
     */
    encryptedData?: Uint8Array;
    /**
     * 是否需要解析数据，当前只能将response.result中的status、info、infocode解析出来，其他数据需要上层业务解析。
     */
    needParseData?: boolean;
}
