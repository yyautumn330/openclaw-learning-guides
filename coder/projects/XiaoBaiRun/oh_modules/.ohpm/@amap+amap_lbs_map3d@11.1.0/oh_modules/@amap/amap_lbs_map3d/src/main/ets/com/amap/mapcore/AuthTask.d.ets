// @keepTs
// @ts-nocheck
import { r60 } from './interface/IAMapLiteDelegate';
import { p66 } from './interface/IAMapNativeDelegate';
export declare class j60 {
    private static readonly TAG;
    private mContext;
    protected n104?: r60;
    protected j101?: p66;
    /**
     * 用来判断海外瓦片是否需要清除缓存
     */
    private static readonly o104;
    /** 异常日志是否上传 */
    private static readonly p104;
    /**
     * 审图号更新
     */
    private static readonly q104;
    /**
     * Marker数据收集
     */
    private static readonly r104;
    /**
     * 全链路日志
     */
    private static readonly s104;
    /**
     * JS文件更新
     */
    private static readonly t104;
    /**
     * 标准地图审图号
     */
    private static readonly u104;
    /**
     * 卫星地图审图号
     */
    private static readonly v104;
    /**
     * 地形图审图号
     */
    private static readonly w104;
    private static readonly x104;
    private static readonly y104;
    /**
     * 云控解析字段 able
     */
    private static readonly z104;
    /**
     * 云控拉取时间间隔，单位ms
     */
    private static readonly a105;
    /**
     * CustomConfig缓存文件名
     */
    private static readonly b105;
    /**
     * LogConfig缓存文件名
     */
    private static readonly c105;
    private static readonly d105;
    private static readonly e105;
    /**
     * 保存审图号 sp文件名称
     */
    static readonly f105: string;
    /**
     * 标准地图审图号 key
     */
    static readonly o65: string;
    /**
     * 卫星地图审图号 key
     */
    static readonly r65: string;
    /**
     * 地形图审图号 key
     */
    static readonly u65: string;
    /**
     * 云控清理缓存 时间保存sp名称
     */
    static readonly g105: string;
    /**
     * 云控清理缓存时间保存
     */
    static readonly h105: string;
    /**
     * 云控拉取时间戳保存sp名称
     */
    static readonly i105: string;
    static readonly j105: string;
    static readonly k105: string;
    private l105;
    constructor(context: Context);
    t63(reference: r60): void;
    e89(reference: p66): void;
    run(): void;
    /**
     * 解析上传异常日志的云控参数
     * @param logEntity
     * @since 5.0.0
     *
     */
    interrupt(): void;
    private n105;
    private p105;
    private q105;
    private t105;
    private v105;
    private w105;
    /**
     * 根据服务端返回的开关串，映射为true和false的flag，串有问题则映射为传入的默认值
     *
     * @param str         服务端返回的开关串
     * @param defaultFlag 默认的开关
     */
    private x105;
}
