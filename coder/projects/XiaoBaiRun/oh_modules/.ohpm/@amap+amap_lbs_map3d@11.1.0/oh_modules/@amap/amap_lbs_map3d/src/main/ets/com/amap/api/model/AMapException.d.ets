// @keepTs
// @ts-nocheck
/**
 * 服务异常信息类。
 *
 * @since V1.1.0
 */
export declare class AMapException extends Error {
    /**
     * 搜索成功 用 1000 表示。
     * @since V3.6.0
     */
    static readonly CODE_AMAP_SUCCESS = 1000;
    /**
     * 1001针对开启了数字签名的key，没有按照指定算法生成。目前web
     */
    static readonly AMAP_SIGNATURE_ERROR: string;
    /**
     * 1002 API、智能硬件的key，支持数字签名。
     */
    static readonly AMAP_INVALID_USER_KEY: string;
    /**
     * 1003没有权限使用相应的接口。
     */
    static readonly AMAP_SERVICE_NOT_AVAILBALE: string;
    /**
     *  1004
     */
    static readonly AMAP_DAILY_QUERY_OVER_LIMIT: string;
    /**
     * 1005
     */
    static readonly AMAP_ACCESS_TOO_FREQUENT: string;
    /**
     * 1006白名单中未出现对应服务器的出口IP。Rest
     */
    static readonly AMAP_INVALID_USER_IP: string;
    /**
     *  1007绑定域名无效
     */
    static readonly AMAP_INVALID_USER_DOMAIN: string;
    /**
     * 1008
     */
    static readonly AMAP_INVALID_USER_SCODE: string;
    /**
     * 1009
     */
    static readonly AMAP_USERKEY_PLAT_NOMATCH: string;
    /**
     * 1010
     */
    static readonly AMAP_IP_QUERY_OVER_LIMIT: string;
    /**
     * 1011
     */
    static readonly AMAP_NOT_SUPPORT_HTTPS: string;
    /**
     * 1012
     */
    static readonly AMAP_INSUFFICIENT_PRIVILEGES: string;
    /**
     * 1013
     */
    static readonly AMAP_USER_KEY_RECYCLED: string;
    /**
     * 1100
     */
    static readonly AMAP_ENGINE_RESPONSE_ERROR: string;
    /**
     * 1101
     */
    static readonly AMAP_ENGINE_RESPONSE_DATA_ERROR: string;
    /**
     * 1102
     */
    static readonly AMAP_ENGINE_CONNECT_TIMEOUT: string;
    /**
     * 1103  引擎返回结果超时
     */
    static readonly AMAP_ENGINE_RETURN_TIMEOUT: string;
    /**
     * 1200
     */
    static readonly AMAP_SERVICE_INVALID_PARAMS: string;
    /**
     * 1201
     */
    static readonly AMAP_SERVICE_MISSING_REQUIRED_PARAMS: string;
    /**
     * 1202
     */
    static readonly AMAP_SERVICE_ILLEGAL_REQUEST: string;
    /**
     * 1203
     */
    static readonly AMAP_SERVICE_UNKNOWN_ERROR: string;
    /**
     * 1801
     */
    static readonly AMAP_CLIENT_ERROR_PROTOCOL: string;
    /**
     * 1802
     */
    static readonly AMAP_CLIENT_SOCKET_TIMEOUT_EXCEPTION: string;
    /**
     * 1803
     */
    static readonly AMAP_CLIENT_URL_EXCEPTION: string;
    /**
     * 1804
     */
    static readonly AMAP_CLIENT_UNKNOWHOST_EXCEPTION: string;
    /**
     * 1806
     */
    static readonly AMAP_CLIENT_NETWORK_EXCEPTION: string;
    /**
     * 1900
     */
    static readonly AMAP_CLIENT_UNKNOWN_ERROR: string;
    /**
     * 1901
     */
    static readonly AMAP_CLIENT_INVALID_PARAMETER: string;
    /**
     * 1902
     */
    static readonly AMAP_CLIENT_IO_EXCEPTION: string;
    /**
     * 1903
     */
    static readonly AMAP_CLIENT_NULLPOINT_EXCEPTION: string;
    /**
     * 非法参数,1904
     */
    static readonly AMAP_CLIENT_ERROR_ILLEGAL_VALUE: string;
    /**
     * 1800
     */
    static readonly AMAP_CLIENT_ERRORCODE_MISSSING: string;
    /** 错误码 */
    static readonly CODE_AMAP_SIGNATURE_ERROR: number;
    static readonly CODE_AMAP_INVALID_USER_KEY: number;
    static readonly CODE_AMAP_SERVICE_NOT_AVAILBALE: number;
    static readonly CODE_AMAP_DAILY_QUERY_OVER_LIMIT: number;
    static readonly CODE_AMAP_ACCESS_TOO_FREQUENT: number;
    static readonly CODE_AMAP_INVALID_USER_IP: number;
    static readonly CODE_AMAP_INVALID_USER_DOMAIN: number;
    static readonly CODE_AMAP_INVALID_USER_SCODE: number;
    static readonly CODE_AMAP_USERKEY_PLAT_NOMATCH: number;
    static readonly CODE_AMAP_IP_QUERY_OVER_LIMIT: number;
    static readonly CODE_AMAP_NOT_SUPPORT_HTTPS: number;
    static readonly CODE_AMAP_INSUFFICIENT_PRIVILEGES: number;
    static readonly CODE_AMAP_USER_KEY_RECYCLED: number;
    static readonly CODE_AMAP_ENGINE_RESPONSE_ERROR: number;
    static readonly CODE_AMAP_ENGINE_RESPONSE_DATA_ERROR: number;
    static readonly CODE_AMAP_ENGINE_CONNECT_TIMEOUT: number;
    static readonly CODE_AMAP_ENGINE_RETURN_TIMEOUT: number;
    static readonly CODE_AMAP_SERVICE_INVALID_PARAMS: number;
    static readonly CODE_AMAP_SERVICE_MISSING_REQUIRED_PARAMS: number;
    static readonly CODE_AMAP_SERVICE_ILLEGAL_REQUEST: number;
    static readonly CODE_AMAP_SERVICE_UNKNOWN_ERROR: number;
    static readonly CODE_AMAP_CLIENT_ERRORCODE_MISSSING: number;
    static readonly CODE_AMAP_CLIENT_ERROR_PROTOCOL: number;
    static readonly CODE_AMAP_CLIENT_SOCKET_TIMEOUT_EXCEPTION: number;
    static readonly CODE_AMAP_CLIENT_URL_EXCEPTION: number;
    static readonly CODE_AMAP_CLIENT_UNKNOWHOST_EXCEPTION: number;
    static readonly CODE_AMAP_CLIENT_NETWORK_EXCEPTION: number;
    static readonly CODE_AMAP_CLIENT_UNKNOWN_ERROR: number;
    static readonly CODE_AMAP_CLIENT_INVALID_PARAMETER: number;
    static readonly CODE_AMAP_CLIENT_IO_EXCEPTION: number;
    static readonly CODE_AMAP_CLIENT_NULLPOINT_EXCEPTION: number;
    static readonly CODE_AMAP_CLIENT_ILLEGAL_VALUE_EXCEPTION: number;
    private errorMessage;
    private errorCode;
    /**
     * 构造服务异常对象。
     */
    constructor();
    /**
     * 构造服务异常对象。
     *
     * @param errorMessage
     *            输入的异常信息。
     */
    constructor(errorMessage: string);
    /**
     * 返回异常信息。
     *
     * @return 异常信息。
     */
    getErrorMessage(): string;
    /**
     * 返回错误码。
     *
     * @return 错误码。
     */
    getErrorCode(): number;
    private generateErrorCode;
}
