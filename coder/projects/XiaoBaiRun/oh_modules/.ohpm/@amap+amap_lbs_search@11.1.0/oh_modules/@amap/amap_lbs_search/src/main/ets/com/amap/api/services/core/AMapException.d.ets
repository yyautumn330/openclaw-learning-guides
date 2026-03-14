// @keepTs
// @ts-nocheck
/**
 * 服务异常信息类。
 * 具体信息请前往官网错误码对照表进行查看
 * <strong><a href="http://lbs.amap.com/api/android-sdk/guide/map-tools/error-code/">官网错误码地址</a></strong>
 * @since 1.0.0
 */
export declare class AMapException extends Error {
    /**
     * 搜索成功 用 1000 表示。
     * @since 1.0.0
     */
    static readonly CODE_AMAP_SUCCESS: number;
    /**
     * 用户签名未通过 ErrorCode：1001
     * @see AMapException#CODE_AMAP_SIGNATURE_ERROR
     * @since 1.0.0
     */
    static readonly AMAP_SIGNATURE_ERROR: string;
    /**
     * 用户key不正确或过期 ErrorCode：1002
     * @see AMapException#CODE_AMAP_INVALID_USER_KEY
     * @since 1.0.0
     */
    static readonly AMAP_INVALID_USER_KEY: string;
    /**
     * 请求服务不存在 ErrorCode：1003
     * @see AMapException#CODE_AMAP_SERVICE_NOT_AVAILBALE
     * @since 1.0.0
     */
    static readonly AMAP_SERVICE_NOT_AVAILBALE: string;
    /**
     * 访问已超出日访问量 ErrorCode：1004
     * @see AMapException#CODE_AMAP_DAILY_QUERY_OVER_LIMIT
     * @since 1.0.0
     */
    static readonly AMAP_DAILY_QUERY_OVER_LIMIT: string;
    /**
     * 用户访问过于频繁 ErrorCode：1005
     * @see AMapException#CODE_AMAP_ACCESS_TOO_FREQUENT
     * @since 1.0.0
     */
    static readonly AMAP_ACCESS_TOO_FREQUENT: string;
    /**
     * 用户IP无效 ErrorCode：1006
     * @see AMapException#CODE_AMAP_INVALID_USER_IP
     * @since 1.0.0
     */
    static readonly AMAP_INVALID_USER_IP: string;
    /**
     * 用户域名无效 ErrorCode：1007
     * @see AMapException#CODE_AMAP_INVALID_USER_DOMAIN
     * @since 1.0.0
     */
    static readonly AMAP_INVALID_USER_DOMAIN: string;
    /**
     * 用户MD5安全码未通过 ErrorCode：1008
     * @see AMapException#CODE_AMAP_INVALID_USER_SCODE
     * @since 1.0.0
     */
    static readonly AMAP_INVALID_USER_SCODE: string;
    /**
     * 请求key与绑定平台不符 ErrorCode：1009
     * @see AMapException#CODE_AMAP_USERKEY_PLAT_NOMATCH
     * @since 1.0.0
     */
    static readonly AMAP_USERKEY_PLAT_NOMATCH: string;
    /**
     * IP访问超限 ErrorCode：1010
     * @see AMapException#CODE_AMAP_IP_QUERY_OVER_LIMIT
     * @since 1.0.0
     */
    static readonly AMAP_IP_QUERY_OVER_LIMIT: string;
    /**
     * 服务不支持https请求 ErrorCode：1011
     * @see AMapException#CODE_AMAP_NOT_SUPPORT_HTTPS
     * @since 1.0.0
     */
    static readonly AMAP_NOT_SUPPORT_HTTPS: string;
    /**
     * 权限不足，服务请求被拒绝 ErrorCode：1012
     * @see AMapException#CODE_AMAP_INSUFFICIENT_PRIVILEGES
     * @since 1.0.0
     */
    static readonly AMAP_INSUFFICIENT_PRIVILEGES: string;
    /**
     * 开发者删除了key，key被删除后无法正常使用 ErrorCode：1013
     * @see AMapException#CODE_AMAP_USER_KEY_RECYCLED
     * @since 1.0.0
     */
    static readonly AMAP_USER_KEY_RECYCLED: string;
    /**
     * 请求服务响应错误 ErrorCode：1100
     * @see AMapException#CODE_AMAP_ENGINE_RESPONSE_ERROR
     * @since 1.0.0
     */
    static readonly AMAP_ENGINE_RESPONSE_ERROR: string;
    /**
     * 引擎返回数据异常 ErrorCode：1101
     * @see AMapException#CODE_AMAP_ENGINE_RESPONSE_DATA_ERROR
     * @since 1.0.0
     */
    static readonly AMAP_ENGINE_RESPONSE_DATA_ERROR: string;
    /**
     * 服务端请求链接超时 ErrorCode：1102
     * @see AMapException#CODE_AMAP_ENGINE_CONNECT_TIMEOUT
     * @since 1.0.0
     */
    static readonly AMAP_ENGINE_CONNECT_TIMEOUT: string;
    /**
     * 读取服务结果超时 ErrorCode：1103
     * @see AMapException#CODE_AMAP_ENGINE_RETURN_TIMEOUT
     * @since 1.0.0
     */
    static readonly AMAP_ENGINE_RETURN_TIMEOUT: string;
    /**
     * 请求参数非法 ErrorCode：1200
     * @see AMapException#CODE_AMAP_SERVICE_INVALID_PARAMS
     * @since 1.0.0
     */
    static readonly AMAP_SERVICE_INVALID_PARAMS: string;
    /**
     * 缺少必填参数 ErrorCode：1201
     * @see AMapException#CODE_AMAP_SERVICE_MISSING_REQUIRED_PARAMS
     * @since 1.0.0
     */
    static readonly AMAP_SERVICE_MISSING_REQUIRED_PARAMS: string;
    /**
     * 请求协议非法 ErrorCode：1202
     * @see AMapException#CODE_AMAP_SERVICE_ILLEGAL_REQUEST
     * @since 1.0.0
     */
    static readonly AMAP_SERVICE_ILLEGAL_REQUEST: string;
    /**
     * 其他未知错误 ErrorCode：1203
     * @see AMapException#CODE_AMAP_SERVICE_UNKNOWN_ERROR
     * @since 1.0.0
     */
    static readonly AMAP_SERVICE_UNKNOWN_ERROR: string;
    /**
     * 协议解析错误 - ProtocolException ErrorCode：1801
     * @see AMapException#CODE_AMAP_CLIENT_ERROR_PROTOCOL
     * @since 1.0.0
     */
    static readonly AMAP_CLIENT_ERROR_PROTOCOL: string;
    /**
     * socket 连接超时 - SocketTimeoutException ErrorCode：1802
     * @see AMapException#CODE_AMAP_CLIENT_SOCKET_TIMEOUT_EXCEPTION
     * @since 1.0.0
     */
    static readonly AMAP_CLIENT_SOCKET_TIMEOUT_EXCEPTION: string;
    /**
     * url异常 - MalformedURLException ErrorCode：1803
     * @see AMapException#CODE_AMAP_CLIENT_URL_EXCEPTION
     * @since 1.0.0
     */
    static readonly AMAP_CLIENT_URL_EXCEPTION: string;
    /**
     * 未知主机 - UnKnowHostException ErrorCode：1804
     * @see AMapException#CODE_AMAP_CLIENT_UNKNOWHOST_EXCEPTION
     * @since 1.0.0
     */
    static readonly AMAP_CLIENT_UNKNOWHOST_EXCEPTION: string;
    /**
     * http或socket连接失败 - ConnectionException ErrorCode：1806
     * @see AMapException#CODE_AMAP_CLIENT_NETWORK_EXCEPTION
     * @since 1.0.0
     */
    static readonly AMAP_CLIENT_NETWORK_EXCEPTION: string;
    /**
     * 未知错误 ErrorCode：1900
     * @see AMapException#CODE_AMAP_CLIENT_UNKNOWN_ERROR
     * @since 1.0.0
     */
    static readonly AMAP_CLIENT_UNKNOWN_ERROR: string;
    static readonly AMAP_CLIENT_UNKNOWN_ERROR_TYPE: string;
    /**
     * 无效的参数 - IllegalArgumentException ErrorCode：1901
     * @see AMapException#CODE_AMAP_CLIENT_INVALID_PARAMETER
     * @since 1.0.0
     */
    static readonly AMAP_CLIENT_INVALID_PARAMETER: string;
    /**
     * IO 操作异常 - IOException ErrorCode：1902
     * @see AMapException#CODE_AMAP_CLIENT_IO_EXCEPTION
     * @since 1.0.0
     */
    static readonly AMAP_CLIENT_IO_EXCEPTION: string;
    /**
     * 空指针异常 - NullPointException ErrorCode：1903
     * @see AMapException#CODE_AMAP_CLIENT_NULLPOINT_EXCEPTION
     * @since 1.0.0
     */
    static readonly AMAP_CLIENT_NULLPOINT_EXCEPTION: string;
    /**
     * 没有对应的错误 ErrorCode：1800
     * @see AMapException#CODE_AMAP_CLIENT_ERRORCODE_MISSSING
     * @since 1.0.0
     */
    static readonly AMAP_CLIENT_ERRORCODE_MISSSING: string;
    static readonly AMAP_CLIENT_ERRORCODE_MISSSING_TPPE: string;
    /**
     * tableID格式不正确不存在 ErrorCode：2000
     * @see AMapException#CODE_AMAP_SERVICE_TABLEID_NOT_EXIST
     * @since 1.0.0
     */
    static readonly AMAP_SERVICE_TABLEID_NOT_EXIST: string;
    /**
     * ID不存在 ErrorCode：2001
     * @see AMapException#CODE_AMAP_ID_NOT_EXIST
     * @since 1.0.0
     */
    static readonly AMAP_ID_NOT_EXIST: string;
    /**
     * 服务器维护中 ErrorCode：2002
     * @see AMapException#CODE_AMAP_SERVICE_MAINTENANCE
     * @since 1.0.0
     */
    static readonly AMAP_SERVICE_MAINTENANCE: string;
    /**
     * key对应的tableID不存在 ErrorCode：2003
     * @see AMapException#CODE_AMAP_ENGINE_TABLEID_NOT_EXIST
     * @since 1.0.0
     */
    static readonly AMAP_ENGINE_TABLEID_NOT_EXIST: string;
    /**
     * 找不到对应的userid信息,请检查您提供的userid是否存在 ErrorCode：2100
     * @see AMapException#CODE_AMAP_NEARBY_INVALID_USERID
     * @since 1.0.0
     */
    static readonly AMAP_NEARBY_INVALID_USERID: string;
    /**
     * App key未开通“附近”功能,请注册附近KEY ErrorCode：2101
     * @see AMapException#CODE_AMAP_NEARBY_KEY_NOT_BIND
     * @since 1.0.0
     */
    static readonly AMAP_NEARBY_KEY_NOT_BIND: string;
    /**
     * 已开启自动上传 ErrorCode：2200
     * @see AMapException#CODE_AMAP_CLIENT_UPLOADAUTO_STARTED_ERROR
     * @since 1.0.0
     */
    static readonly AMAP_CLIENT_UPLOADAUTO_STARTED_ERROR: string;
    /**
     * USERID非法 ErrorCode：2201
     * @see AMapException#CODE_AMAP_CLIENT_USERID_ILLEGAL
     * @since 1.0.0
     */
    static readonly AMAP_CLIENT_USERID_ILLEGAL: string;
    /**
     * NearbyInfo对象为空 ErrorCode：2202
     * @see AMapException#CODE_AMAP_CLIENT_NEARBY_NULL_RESULT
     * @since 1.0.0
     */
    static readonly AMAP_CLIENT_NEARBY_NULL_RESULT: string;
    /**
     * 两次单次上传的间隔低于7秒 ErrorCode：2203
     * @see AMapException#CODE_AMAP_CLIENT_UPLOAD_TOO_FREQUENT
     * @since 1.0.0
     */
    static readonly AMAP_CLIENT_UPLOAD_TOO_FREQUENT: string;
    /**
     * Point为空，或与前次上传的相同 ErrorCode：2204
     * @see AMapException#CODE_AMAP_CLIENT_UPLOAD_LOCATION_ERROR
     * @since 1.0.0
     */
    static readonly AMAP_CLIENT_UPLOAD_LOCATION_ERROR: string;
    /**
     * 规划点（包括起点、终点、途经点）不在中国陆地范围内 ErrorCode：3000
     * @see AMapException#CODE_AMAP_ROUTE_OUT_OF_SERVICE
     * @since 1.0.0
     */
    static readonly AMAP_ROUTE_OUT_OF_SERVICE: string;
    /**
     * 规划点（起点、终点、途经点）附近搜不到路 ErrorCode：3001
     * @see AMapException#CODE_AMAP_ROUTE_NO_ROADS_NEARBY
     * @since 1.0.0
     */
    static readonly AMAP_ROUTE_NO_ROADS_NEARBY: string;
    /**
     * 路线计算失败，通常是由于道路连通关系导致 ErrorCode：3002
     * @see AMapException#CODE_AMAP_ROUTE_FAIL
     * @since 1.0.0
     */
    static readonly AMAP_ROUTE_FAIL: string;
    /**
     * 起点终点距离过长 ErrorCode：3003
     * @see AMapException#CODE_AMAP_OVER_DIRECTION_RANGE
     * @since 1.0.0
     */
    static readonly AMAP_OVER_DIRECTION_RANGE: string;
    /**
     * 短串分享认证失败 ErrorCode：4000
     * @see AMapException#CODE_AMAP_SHARE_LICENSE_IS_EXPIRED
     * @since 1.0.0
     */
    static readonly AMAP_SHARE_LICENSE_IS_EXPIRED: string;
    /**
     * 途经点个数超限
     * @since 1.0.0
     */
    static readonly AMAP_CLIENT_OVER_PASSBY_MAX_COUNT_EXCEPTION: string;
    /**
     * 避让区域个数超限
     * @since 1.0.0
     */
    static readonly AMAP_CLIENT_OVER_PASSAREA_MAX_COUNT_EXCEPTION: string;
    /**
     * 避让区域大小超限
     * @since 1.0.0
     */
    static readonly AMAP_CLIENT_OVER_PASSAREA_MAX_AREA_EXCEPTION: string;
    /**
     * 避让区域点个数超限
     * @since 1.0.0
     */
    static readonly AMAP_CLIENT_OVER_PASSAREA_ITEM_POINT_COUNT_EXCEPTION: string;
    /**
     * 搜索关键字过长
     * @since 1.0.0
     */
    static readonly AMAP_CLIENT_OVER_KEYWORD_LEN_MAX_COUNT_EXCEPTION: string;
    /**
     * 短串请求失败 ErrorCode：4001
     * @see AMapException#CODE_AMAP_SHARE_FAILURE
     * @since 1.0.0
     */
    static readonly AMAP_SHARE_FAILURE: string;
    /**
     * 短串分享用户签名未通过 ErrorCode：4002
     * @see AMapException#CODE_AMAP_SHARE_SIGNATURE_FAILURE
     * @since 1.0.0
     */
    static readonly AMAP_SHARE_SIGNATURE_FAILURE: string;
    /**
     * 用户签名未通过 ErrorCode：1001
     * @see AMapException#AMAP_SIGNATURE_ERROR
     * @since 1.0.0
     */
    static readonly CODE_AMAP_SIGNATURE_ERROR: number;
    /**
     * 用户key不正确或过期 ErrorCode：1002
     * @see AMapException#AMAP_INVALID_USER_KEY
     * @since 1.0.0
     */
    static readonly CODE_AMAP_INVALID_USER_KEY: number;
    /**
     * 请求服务不存在 ErrorCode：1003
     * @see AMapException#AMAP_SERVICE_NOT_AVAILBALE
     * @since 1.0.0
     */
    static readonly CODE_AMAP_SERVICE_NOT_AVAILBALE: number;
    /**
     * 访问已超出日访问量 ErrorCode：1004
     * @see AMapException#AMAP_DAILY_QUERY_OVER_LIMIT
     * @since 1.0.0
     */
    static readonly CODE_AMAP_DAILY_QUERY_OVER_LIMIT: number;
    /**
     * 用户访问过于频繁 ErrorCode：1005
     * @see AMapException#AMAP_ACCESS_TOO_FREQUENT
     * @since 1.0.0
     */
    static readonly CODE_AMAP_ACCESS_TOO_FREQUENT: number;
    /**
     * 用户IP无效 ErrorCode：1006
     * @see AMapException#AMAP_INVALID_USER_IP
     * @since 1.0.0
     */
    static readonly CODE_AMAP_INVALID_USER_IP: number;
    /**
     * 用户域名无效 ErrorCode：1007
     * @see AMapException#AMAP_INVALID_USER_DOMAIN
     * @since 1.0.0
     */
    static readonly CODE_AMAP_INVALID_USER_DOMAIN: number;
    /**
     * 用户MD5安全码未通过 ErrorCode：1008
     * @see AMapException#AMAP_INVALID_USER_SCODE
     * @since 1.0.0
     */
    static readonly CODE_AMAP_INVALID_USER_SCODE: number;
    /**
     * 请求key与绑定平台不符 ErrorCode：1009
     * @see AMapException#AMAP_USERKEY_PLAT_NOMATCH
     * @since 1.0.0
     */
    static readonly CODE_AMAP_USERKEY_PLAT_NOMATCH: number;
    /**
     * IP访问超限 ErrorCode：1010
     * @see AMapException#AMAP_IP_QUERY_OVER_LIMIT
     * @since 1.0.0
     */
    static readonly CODE_AMAP_IP_QUERY_OVER_LIMIT: number;
    /**
     * 服务不支持https请求 ErrorCode：1011
     * @see AMapException#AMAP_NOT_SUPPORT_HTTPS
     * @since 1.0.0
     */
    static readonly CODE_AMAP_NOT_SUPPORT_HTTPS: number;
    /**
     * 权限不足，服务请求被拒绝 ErrorCode：1012
     * @see AMapException#AMAP_INSUFFICIENT_PRIVILEGES
     * @since 1.0.0
     */
    static readonly CODE_AMAP_INSUFFICIENT_PRIVILEGES: number;
    /**
     * 开发者删除了key，key被删除后无法正常使用 ErrorCode：1013
     * @see AMapException#AMAP_USER_KEY_RECYCLED
     * @since 1.0.0
     */
    static readonly CODE_AMAP_USER_KEY_RECYCLED: number;
    /**
     * 请求服务响应错误 ErrorCode：1100
     * @see AMapException#AMAP_ENGINE_RESPONSE_ERROR
     * @since 1.0.0
     */
    static readonly CODE_AMAP_ENGINE_RESPONSE_ERROR: number;
    /**
     * 引擎返回数据异常 ErrorCode：1101
     * @see AMapException#AMAP_ENGINE_RESPONSE_DATA_ERROR
     * @since 1.0.0
     */
    static readonly CODE_AMAP_ENGINE_RESPONSE_DATA_ERROR: number;
    /**
     * 服务端请求链接超时 ErrorCode：1102
     * @see AMapException#AMAP_ENGINE_CONNECT_TIMEOUT
     * @since 1.0.0
     */
    static readonly CODE_AMAP_ENGINE_CONNECT_TIMEOUT: number;
    /**
     * 读取服务结果超时 ErrorCode：1103
     * @see AMapException#AMAP_ENGINE_RETURN_TIMEOUT
     * @since 1.0.0
     */
    static readonly CODE_AMAP_ENGINE_RETURN_TIMEOUT: number;
    /**
     * 请求参数非法 ErrorCode：1200
     * @see AMapException#AMAP_SERVICE_INVALID_PARAMS
     * @since 1.0.0
     */
    static readonly CODE_AMAP_SERVICE_INVALID_PARAMS: number;
    /**
     * 缺少必填参数 ErrorCode：1201
     * @see AMapException#AMAP_SERVICE_MISSING_REQUIRED_PARAMS
     * @since 1.0.0
     */
    static readonly CODE_AMAP_SERVICE_MISSING_REQUIRED_PARAMS: number;
    /**
     * 请求协议非法 ErrorCode：1202
     * @see AMapException#AMAP_SERVICE_ILLEGAL_REQUEST
     * @since 1.0.0
     */
    static readonly CODE_AMAP_SERVICE_ILLEGAL_REQUEST: number;
    /**
     * 其他未知错误 ErrorCode：1203
     * @see AMapException#AMAP_SERVICE_UNKNOWN_ERROR
     * @since 1.0.0
     */
    static readonly CODE_AMAP_SERVICE_UNKNOWN_ERROR: number;
    /**
     * 没有对应的错误 ErrorCode：1800
     * @see AMapException#AMAP_CLIENT_ERRORCODE_MISSSING
     * @since 1.0.0
     */
    static readonly CODE_AMAP_CLIENT_ERRORCODE_MISSSING: number;
    /**
     * 协议解析错误 - ProtocolException ErrorCode：1801
     * @see AMapException#AMAP_CLIENT_ERROR_PROTOCOL
     * @since 1.0.0
     */
    static readonly CODE_AMAP_CLIENT_ERROR_PROTOCOL: number;
    /**
     * socket 连接超时 - SocketTimeoutException ErrorCode：1802
     * @see AMapException#AMAP_CLIENT_SOCKET_TIMEOUT_EXCEPTION
     * @since 1.0.0
     */
    static readonly CODE_AMAP_CLIENT_SOCKET_TIMEOUT_EXCEPTION: number;
    /**
     * url异常 - MalformedURLException ErrorCode：1803
     * @see AMapException#AMAP_CLIENT_URL_EXCEPTION
     * @since 1.0.0
     */
    static readonly CODE_AMAP_CLIENT_URL_EXCEPTION: number;
    /**
     * 未知主机 - UnKnowHostException ErrorCode：1804
     * @see AMapException#AMAP_CLIENT_UNKNOWHOST_EXCEPTION
     * @since 1.0.0
     */
    static readonly CODE_AMAP_CLIENT_UNKNOWHOST_EXCEPTION: number;
    /**
     * http或socket连接失败 - ConnectionException ErrorCode：1806
     * @see AMapException#AMAP_CLIENT_NETWORK_EXCEPTION
     * @since 1.0.0
     */
    static readonly CODE_AMAP_CLIENT_NETWORK_EXCEPTION: number;
    /**
     * 途经点个数超限
     * @since 1.0.0
     */
    static readonly CODE_AMAP_CLIENT_OVER_PASSBY_MAX_COUNT_EXCEPTION: number;
    /**
     * 避让区域个数超限
     * @since 1.0.0
     */
    static readonly CODE_AMAP_CLIENT_OVER_PASSAREA_MAX_COUNT_EXCEPTION: number;
    /**
     * 避让区域大小超限
     * @since 1.0.0
     */
    static readonly CODE_AMAP_CLIENT_OVER_PASSAREA_MAX_AREA_EXCEPTION: number;
    /**
     * 避让区域点个数超限
     * @since 1.0.0
     */
    static readonly CODE_AMAP_CLIENT_OVER_PASSAREA_ITEM_POINT_COUNT_EXCEPTION: number;
    /**
     * 搜索关键字过长
     * @since 1.0.0
     */
    static readonly CODE_AMAP_CLIENT_OVER_KEYWORD_LEN_MAX_COUNT_EXCEPTION: number;
    /**
     * 未知错误 ErrorCode：1900
     * @see AMapException#AMAP_CLIENT_UNKNOWN_ERROR
     * @since 1.0.0
     */
    static readonly CODE_AMAP_CLIENT_UNKNOWN_ERROR: number;
    /**
     * 无效的参数 - IllegalArgumentException ErrorCode：1901
     * @see AMapException#AMAP_CLIENT_INVALID_PARAMETER
     * @since 1.0.0
     */
    static readonly CODE_AMAP_CLIENT_INVALID_PARAMETER: number;
    /**
     * IO 操作异常 - IOException ErrorCode：1902
     * @see AMapException#AMAP_CLIENT_IO_EXCEPTION
     * @since 1.0.0
     */
    static readonly CODE_AMAP_CLIENT_IO_EXCEPTION: number;
    /**
     * 空指针异常 - NullPointException ErrorCode：1903
     * @see AMapException#AMAP_CLIENT_NULLPOINT_EXCEPTION
     * @since 1.0.0
     */
    static readonly CODE_AMAP_CLIENT_NULLPOINT_EXCEPTION: number;
    /**
     * tableID格式不正确不存在 ErrorCode：2000
     * @see AMapException#AMAP_SERVICE_TABLEID_NOT_EXIST
     * @since 1.0.0
     */
    static readonly CODE_AMAP_SERVICE_TABLEID_NOT_EXIST: number;
    /**
     * ID不存在 ErrorCode：2001
     * @see AMapException#AMAP_ID_NOT_EXIST
     * @since 1.0.0
     */
    static readonly CODE_AMAP_ID_NOT_EXIST: number;
    /**
     * 服务器维护中 ErrorCode：2002
     * @see AMapException#AMAP_SERVICE_MAINTENANCE
     * @since 1.0.0
     */
    static readonly CODE_AMAP_SERVICE_MAINTENANCE: number;
    /**
     * key对应的tableID不存在 ErrorCode：2003
     * @see AMapException#AMAP_ENGINE_TABLEID_NOT_EXIST
     * @since 1.0.0
     */
    static readonly CODE_AMAP_ENGINE_TABLEID_NOT_EXIST: number;
    /**
     * 找不到对应的userid信息,请检查您提供的userid是否存在 ErrorCode：2100
     * @see AMapException#AMAP_NEARBY_INVALID_USERID
     * @since 1.0.0
     */
    static readonly CODE_AMAP_NEARBY_INVALID_USERID: number;
    /**
     * App key未开通“附近”功能,请注册附近KEY ErrorCode：2101
     * @see AMapException#AMAP_NEARBY_KEY_NOT_BIND
     * @since 1.0.0
     */
    static readonly CODE_AMAP_NEARBY_KEY_NOT_BIND: number;
    /**
     * 已开启自动上传 ErrorCode：2200
     * @see AMapException#AMAP_CLIENT_UPLOADAUTO_STARTED_ERROR
     * @since 1.0.0
     */
    static readonly CODE_AMAP_CLIENT_UPLOADAUTO_STARTED_ERROR: number;
    /**
     * USERID非法 ErrorCode：2201
     * @see AMapException#AMAP_CLIENT_USERID_ILLEGAL
     * @since 1.0.0
     */
    static readonly CODE_AMAP_CLIENT_USERID_ILLEGAL: number;
    /**
     * NearbyInfo对象为空 ErrorCode：2202
     * @see AMapException#AMAP_CLIENT_NEARBY_NULL_RESULT
     * @since 1.0.0
     */
    static readonly CODE_AMAP_CLIENT_NEARBY_NULL_RESULT: number;
    /**
     * 两次单次上传的间隔低于7秒 ErrorCode：2203
     * @see AMapException#AMAP_CLIENT_UPLOAD_TOO_FREQUENT
     * @since 1.0.0
     */
    static readonly CODE_AMAP_CLIENT_UPLOAD_TOO_FREQUENT: number;
    /**
     * Point为空，或与前次上传的相同 ErrorCode：2204
     * @see AMapException#AMAP_CLIENT_UPLOAD_LOCATION_ERROR
     * @since 1.0.0
     */
    static readonly CODE_AMAP_CLIENT_UPLOAD_LOCATION_ERROR: number;
    /**
     * 规划点（包括起点、终点、途经点）不在中国陆地范围内 ErrorCode：3000
     * @see AMapException#AMAP_ROUTE_OUT_OF_SERVICE
     * @since 1.0.0
     */
    static readonly CODE_AMAP_ROUTE_OUT_OF_SERVICE: number;
    /**
     * 规划点（起点、终点、途经点）附近搜不到路 ErrorCode：3001
     * @see AMapException#AMAP_ROUTE_NO_ROADS_NEARBY
     * @since 1.0.0
     */
    static readonly CODE_AMAP_ROUTE_NO_ROADS_NEARBY: number;
    /**
     * 路线计算失败，通常是由于道路连通关系导致 ErrorCode：3002
     * @see AMapException#AMAP_ROUTE_FAIL
     * @since 1.0.0
     */
    static readonly CODE_AMAP_ROUTE_FAIL: number;
    /**
     * 起点终点距离过长 ErrorCode：3003
     * @see AMapException#AMAP_OVER_DIRECTION_RANGE
     * @since 1.0.0
     */
    static readonly CODE_AMAP_OVER_DIRECTION_RANGE: number;
    /**
     * 短串分享认证失败 ErrorCode：4000
     * @see AMapException#AMAP_SHARE_LICENSE_IS_EXPIRED
     * @since 1.0.0
     */
    static readonly CODE_AMAP_SHARE_LICENSE_IS_EXPIRED: number;
    /**
     * 短串请求失败 ErrorCode：4001
     * @see AMapException#AMAP_SHARE_FAILURE
     * @since 1.0.0
     */
    static readonly CODE_AMAP_SHARE_FAILURE: number;
    /**
     * 短串分享用户签名未通过 ErrorCode：4002
     * @see AMapException#AMAP_SHARE_SIGNATURE_FAILURE
     * @since 1.0.0
     */
    static readonly CODE_AMAP_SHARE_SIGNATURE_FAILURE: number;
    /**
     * 记录是否为rest服务的error
     */
    private errorLevel;
    /**
     * 当前 QPS 超出限制（服务端 info 字段）
     * @since 1.0.0
     */
    static readonly s4: string;
    /**
     * 记录是否为rest服务的error类型，比如INVALID_USER_KEY
     */
    private errorType?;
    /**
     * 服务端错误类型
     * @internal
     * @since 1.0.0
     */
    static readonly AMAP_ERROR_REST: number;
    /**
     * 通用错误类型，各SDK之前公用，放在UtilCore中
     * @internal
     * @since 1.0.0
     */
    static readonly AMAP_ERROR_CORE: number;
    /**
     * 搜索自定义的错误类型，比如短串分享等
     * @internal
     * @since 1.0.0
     */
    static readonly AMAP_ERROR_LOCAL: number;
    /**
     * 本地自定义的错误类型，会规范化为首位为4
     * @internal
     * @since 1.0.0
     */
    static readonly AMAP_ERROR_LOCAL_STANDARDIZED: number;
    /**
     * 获取当前错误级别，是否本地错误、UtilCore错误还是rest错误
     *
     * @since 1.0.0
     * @internal
     */
    getErrorLevel(): number;
    /**
     * 获取当前错误类型，如INVALID_USER_KEY
     *
     * @since 1.0.0
     * @internal
     */
    getErrorType(): string | undefined;
    private errorMessage;
    private errorCode;
    /**
     * 构造服务异常对象。
     *
     * @param errorMessage 输入的异常信息。
     * @param errorLevel 是否是服务端透传的日志
     * @param errorType 错误类型，英文表示，比如    INVALID_USER_KEY
     *
     * @since 1.0.0
     * @internal
     */
    constructor(errorMessage?: string, r4?: number, errorType?: string, errorCode?: number);
    /**
     * 返回异常信息。
     * @return 异常信息。
     * @since 1.0.0
     */
    getErrorMessage(): string;
    /**
     * 返回错误码。
     * @return 错误码。
     * @since V2.0.0
     */
    getErrorCode(): number;
    private t4;
}
