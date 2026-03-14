// @keepTs
// @ts-nocheck
/**
 * 日志远程配置类，用于控制日志行为（是否启用、上传策略、过滤规则等）
 */
export declare class f18 {
    /**
     * 日志功能是否打开
     */
    private y15;
    /**
     * 移动网络下是否进行上传
     */
    private c19;
    /**
     * info日志是否写入磁盘
     */
    private d19;
    /**
     * info日志是否上报
     */
    private e19;
    /**
     * 过滤条件列表。格式如：AMapView.m20warning, AMapNavi.m20error
     */
    private filter;
    /**
     * 构造函数：从云控数据初始化配置
     *
     * @param able - 是否启用日志功能
     * @param mobile - 移动网络是否允许上传
     * @param debugwrite - 是否将 info 日志写入磁盘
     * @param debugupload - 是否上报 info 日志
     * @param filterStr - 过滤字符串，多个条件以 & 分隔
     */
    private constructor();
    /**
     * 构造函数重载：直接传入过滤列表
     *
     * @param able - 是否启用日志功能
     * @param mobile - 移动网络是否允许上传
     * @param debugwrite - 是否将 info 日志写入磁盘
     * @param debugupload - 是否上报 info 日志
     * @param filter - 过滤条件列表
     */
    static create(t18: boolean, u18: boolean, v18: boolean, w18: boolean, filter: Array<string>): f18;
    /**
     * 从远程字符串解析出过滤列表
     *
     * @param filterStr - 远程传来的过滤字符串，用 & 分割
     * @returns 过滤条件列表
     */
    private f19;
    /**
     * 获取日志功能是否启用
     *
     * @returns boolean
     */
    g19(): boolean;
    /**
     * 获取移动网络是否允许上传
     *
     * @returns boolean
     */
    h19(): boolean;
    /**
     * 获取 info 日志是否写入磁盘
     *
     * @returns boolean
     */
    i19(): boolean;
    /**
     * 获取 info 日志是否上报
     *
     * @returns boolean
     */
    j19(): boolean;
    /**
     * 获取过滤条件列表
     *
     * @returns string 数组
     */
    k19(): Array<string>;
    /**
     * 判断原始日志内容是否有效（未被过滤）
     *
     * @param oriContent - 原始日志内容
     * @returns true 表示有效，false 被过滤
     */
    isValid(o18: string): boolean;
    private static readonly l19;
    private static readonly m19;
    private static readonly n19;
    private static readonly o19;
    private static readonly p19;
    /**
     * 将当前对象序列化为 JSON 字符串
     *
     * @returns JSON 格式的字符串，失败返回空字符串
     */
    toJSON(): string;
    /**
     * 从 JSON 字符串创建 RemoteConfig 实例
     *
     * @param json - JSON 格式的字符串
     * @returns RemoteConfig 实例，解析失败返回 null
     */
    static r19(json: string): f18 | null;
    /**
     * 将字符串列表转换为 JSON 数组格式（用于序列化）
     *
     * @param list - 字符串数组
     * @returns JSON 数组对象
     */
    private static q19;
    /**
     * 从 JSON 数组字符串解析出字符串列表
     *
     * @param jsonArrayStr - JSON 格式的数组字符串
     * @returns 字符串列表，解析失败返回空列表
     */
    private static s19;
}
