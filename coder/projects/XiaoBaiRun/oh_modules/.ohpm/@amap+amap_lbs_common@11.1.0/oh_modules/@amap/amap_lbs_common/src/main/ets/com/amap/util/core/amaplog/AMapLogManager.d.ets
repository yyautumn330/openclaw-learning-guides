// @keepTs
// @ts-nocheck
import { SDKInfo } from "../SDKInfo";
import { z14 } from "../statistics/LogConfig";
import ArrayList from "@ohos.util.ArrayList";
/**
 * 日志内容模板
 * @author yjl215
 * @date 2024/11/19 14:22
 */
export declare class b15 {
    /**
     * 单个文件 地存储最大值为40kb
     */
    static v15: number;
    static w15: number;
    private static context;
    private static x15;
    /**
     * 云控配置：日志功能是否打开
     */
    private static y15;
    /**
     * 云控配置：移动网络下是否进行上传
     */
    private static z15;
    /**
     * 云控配置：info日志是否写入磁盘
     */
    private static a16;
    /**
     * 云控配置：info日志是否上报
     */
    private static b16;
    /**
     * 过滤条件，间隔是&。例如：AMapView.m20warning&AMapNavi.m20error
     */
    private static filters;
    private static c16;
    /**
     * md5(error)
     */
    private static d16;
    private static e16;
    private static f16;
    /**
     * 本地存储的最大文件数量 , DEF_MAX_FILE_NUMBER * DEF_INFO_MAX_LOCAL_SIZE = 500MB
     */
    private static g16;
    private static h16;
    private static i16;
    /**
     * error 间隔是30分钟
     */
    private static j16;
    /**
     * error日志单日上传是10MB
     */
    private static k16;
    constructor(u15: SDKInfo);
    static getInstance(t15: SDKInfo): b15 | undefined;
    /**
     * 是否可以进行日志记录，上报等
     *
     * @return
     */
    static l16(): boolean;
    /**
     * 利用exception链路进行上报
     *
     * @param isForce
     */
    static m16(isForce: boolean): void;
    static n16(isForce: boolean): void;
    /**
     * 获取日志类型对应的logConfig
     *
     * @param type
     * @return
     */
    static o16(type: number): z14;
    static s16(): z14;
    /**
     * 更新配置
     *
     * @return
     */
    static r16(): z14 | undefined;
    /**
     * 更新配置
     *
     * @return
     */
    static t16(): z14 | undefined;
    /**
     * 获得info日志的路径
     * amapLog/info/sdkname
     *
     * @return
     */
    static v16(): string | undefined;
    static e17(): string | undefined;
    /**
     * 从SharedPreferences中读取指定日期和键值的已上传日志大小
     */
    static c17(key: string): number;
    /**
     * amapLog/类型/sdkname
     *
     * @param context
     * @param type
     * @param sdkInfo
     * @return
     */
    static f17(context: Context, type: string, k15: SDKInfo): string | undefined;
    /**
     * 初始化
     * @param context
     */
    g17(context: Context): void;
    init(context: Context, g15: boolean, h15: boolean, i15: boolean, j15: boolean, filters: ArrayList<string>): void;
    /**
     * 更新云控
     *
     * @param able
     * @param mobileAble
     * @param debugWriteAble
     * @param debugUploadAble
     */
    h17(c15: boolean, d15: boolean, e15: boolean, f15: boolean, filters: ArrayList<string>): void;
    /**
     * 主动触发上报。会强制进行上报
     * 可能是被用户触发
     */
    i17(isForce: boolean): void;
    flush(): void;
}
