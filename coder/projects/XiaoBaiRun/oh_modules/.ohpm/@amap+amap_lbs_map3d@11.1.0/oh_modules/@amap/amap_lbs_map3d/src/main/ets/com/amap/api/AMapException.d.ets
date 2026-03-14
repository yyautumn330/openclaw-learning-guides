// @keepTs
// @ts-nocheck
export declare class AMapException extends Error {
    private static readonly z3;
    /**
     * 输入输出异常。
     */
    static readonly a4 = "IO \u64CD\u4F5C\u5F02\u5E38 - IOException";
    /**
     * socket 连接异常。
     */
    static readonly ERROR_SOCKET = "socket \u8FDE\u63A5\u5F02\u5E38 - SocketException";
    /**
     * socket 连接超时。
     */
    static readonly b4 = "socket \u8FDE\u63A5\u8D85\u65F6 - SocketTimeoutException";
    /**
     * 无效的参数。
     */
    static readonly c4 = "\u65E0\u6548\u7684\u53C2\u6570 - IllegalArgumentException";
    /**
     * 空指针异常。
     */
    static readonly d4 = "\u7A7A\u6307\u9488\u5F02\u5E38 - NullPointException";
    /**
     * url异常。
     */
    static readonly e4 = "url\u5F02\u5E38 - MalformedURLException";
    /**
     * 未知主机。
     */
    static readonly f4 = "\u672A\u77E5\u4E3B\u673A - UnKnowHostException";
    /**
     * 服务器连接失败。
     */
    static readonly ERROR_UNKNOW_SERVICE = "\u670D\u52A1\u5668\u8FDE\u63A5\u5931\u8D25 - UnknownServiceException";
    /**
     * 协议解析错误。
     */
    static readonly g4 = "\u534F\u8BAE\u89E3\u6790\u9519\u8BEF - ProtocolException";
    /**
     * http连接失败。
     */
    static readonly ERROR_CONNECTION = "http\u8FDE\u63A5\u5931\u8D25 - ConnectionException";
    /**
     * 未知的错误。
     */
    static readonly ERROR_UNKNOWN = "\u672A\u77E5\u7684\u9519\u8BEF";
    /**
     * key鉴权失败。
     */
    static readonly h4 = "key\u9274\u6743\u5931\u8D25";
    /**
     * 空间不足
     */
    static readonly i4 = "\u7A7A\u95F4\u4E0D\u8DB3";
    /**
     * 不可写入异常
     */
    static readonly j4 = "\u4E0D\u53EF\u5199\u5165\u5F02\u5E38";
    /**
     * 非法坐标值
     */
    static readonly l4 = "\u975E\u6CD5\u5750\u6807\u503C";
    /**
     * 移动设备上未安装高德地图或高德地图版本较旧
     */
    static readonly m4 = "\u79FB\u52A8\u8BBE\u5907\u4E0A\u672A\u5B89\u88C5\u9AD8\u5FB7\u5730\u56FE\u6216\u9AD8\u5FB7\u5730\u56FE\u7248\u672C\u8F83\u65E7";
    /**
     * 非法导航参数
     */
    static readonly n4 = "\u975E\u6CD5\u53C2\u6570";
    /**
     * 海外鉴权失败
     */
    static readonly o4 = "\u6D77\u5916\u9274\u6743\u5931\u8D25";
    /**
     * MVT功能不支持
     */
    static readonly q4 = "MVT\u529F\u80FD\u4E0D\u652F\u6301";
    /**
     * GLTF功能不支持
     */
    static readonly r4 = "GLTF\u529F\u80FD\u4E0D\u652F\u6301";
    /**
     * 地形图功能不支持
     */
    static readonly s4 = "\u5730\u5F62\u56FE\u529F\u80FD\u4E3A\u8BA1\u8D39\u80FD\u529B\uFF0C\u8BF7\u8054\u7CFB\u5546\u52A1\u8FDB\u884C\u529F\u80FD\u5F00\u901A\u3002";
    /**
     * so不匹配
     */
    static readonly t4 = "lib\u4E0D\u5339\u914D";
    /**
     * so加载失败
     */
    static readonly u4 = "lib\u52A0\u8F7D\u5931\u8D25";
    private errorMessage;
    /**
     * 构造定位异常对象。
     *
     * @param errorMessage 异常信息
     */
    constructor(errorMessage: string);
    /**
     * 获取异常信息。
     *
     * @return 异常信息。
     */
    getErrorMessage(): string;
}
