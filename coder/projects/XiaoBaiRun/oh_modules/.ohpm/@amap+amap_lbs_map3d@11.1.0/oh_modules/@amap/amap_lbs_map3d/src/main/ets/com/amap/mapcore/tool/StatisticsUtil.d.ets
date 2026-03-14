// @keepTs
// @ts-nocheck
import { Context } from '@ohos.abilityAccessCtrl';
/**
 * 性能埋点相关
 *
 */
export declare class l7 {
    /**
     * 自定义样式埋点id
     */
    static readonly v251: string;
    static readonly w251: string;
    static readonly x251: string;
    static readonly y251: string;
    static readonly z251: string;
    static readonly a252: string;
    static readonly b252: string;
    static readonly c252: string;
    static readonly d252: string;
    private static e252;
    private static f252;
    private static g252;
    private static h252;
    private static i252;
    static readonly q7: string;
    static readonly s7: string;
    static readonly x7: string;
    static readonly t7: string;
    static readonly u7: string;
    static readonly v7: string;
    static readonly w7: string;
    private static j252;
    /**
     * 首屏渲染耗时
     */
    static readonly k252: string;
    /**
     * 地图启动时长
     */
    static readonly l252: string;
    /**
     * mapbox埋点id
     */
    static readonly m252: string;
    /**
     * /**
     * 自定义样式埋点日志
     * @param context
     * @param isSuccess
     */
    static e59(context: Context, isSuccess: boolean): void;
    /**
     * @param isSuccess
     * @return
     */
    private static n252;
    /**
     * MAPBOX埋点日志
     * @param context
     * @param isSuccess
     */
    static o252(context: Context, isSuccess: boolean): void;
    /**
     * 构建使用MapBox地图
     * @param isSuccess MapBox是否加载成功
     * @return
     */
    private static p252;
    /**
     * 地图首屏渲染时长埋点日志
     * @parm context
     * @param firstFrameSpendTime
     */
    static q252(context: Context, t251: number): void;
    /**
     * 地图引擎初始化完成
     * @parm context
     */
    static t252(context: Context, time: number): void;
    /**
     * 地图自定义样式埋点日志
     * @parm context
     * @param enable
     */
    static z58(context: Context, enable: boolean): void;
    /**
     * 室内地图设置埋点日志
     * @parm context
     * @param opened
     */
    static f97(context: Context, enable: boolean): void;
    /**
     * 坐标设置埋点日志
     * @parm context
     * @param type
     */
    static y7(context: Context, type: string): void;
    /**
     * 普通地图审图号埋点日志
     * @parm context
     */
    static n65(context: Context): void;
    /**
     * 卫星地图审图号埋点日志
     * @parm context
     */
    static q65(context: Context): void;
    /**
     * 地形图审图号埋点日志
     * @parm context
     */
    static t65(context: Context): void;
    private static r252;
    private static s252;
}
