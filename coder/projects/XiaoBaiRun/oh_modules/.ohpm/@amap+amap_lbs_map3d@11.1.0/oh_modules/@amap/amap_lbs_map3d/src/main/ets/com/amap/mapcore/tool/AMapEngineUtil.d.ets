// @keepTs
// @ts-nocheck
import { InitParam } from '../AMapEngineConfig';
/**
 * 引擎资源相关工具类
 *
 */
export declare class AMapEngineUtil {
    /**
     * 主图类型
     */
    static readonly c95: number;
    /**
     * 鹰眼小地图类型
     */
    static readonly h231: number;
    static readonly q41: string;
    /**
     * 引擎样式文件路径
     */
    static readonly v41: string;
    /**
     * 自定义样式文件路径
     */
    static readonly j58: string;
    /**
     * png引擎图标资源
     */
    static readonly r41: string;
    static readonly t41: string;
    static readonly i231: string;
    /**
     * 默认路况纹理，用来生成自定义纹理颜色的原始文件
     */
    static readonly l59: string;
    /**
     * 默认背景纹理
     */
    static readonly j231: string;
    /**
     * 可自定义的背景纹理
     */
    static readonly p59: string;
    /**
     * 默认面纹理资源
     */
    static readonly k231: string;
    /**
     * 默认无效纹理文件，关闭纹理功能时，用它来冲掉缓存中的纹理
     */
    static readonly v58: string;
    /**
     * 默认标准样式文件
     */
    static readonly x58: string;
    /**
     * 地形图样式，调整了审图相关的内容
     */
    static readonly e153: string;
    /**
     * 默认海外标准样式文件，海外需要修改水系颜色，保证和样式平台中默认颜色一致
     */
    static readonly w58: string;
    /**
     * 用于处理自定义纹理的样式文件
     */
    static readonly g58: string;
    static readonly h58: string;
    static readonly l231: number;
    static readonly m231: number;
    static readonly n231: number;
    static readonly o231: string;
    static readonly l96: number;
    static readonly d96: number;
    /**
     * 墨卡托投影20级坐标最大值
     */
    static readonly p231: number;
    /**
     * 墨卡托投影20级坐标最大值的一半
     */
    static readonly q231: number;
    /**
     * 最大经度范围
     */
    static readonly r231: number;
    /**
     * 最小经度范围
     */
    static readonly s231: number;
    /**
     * Logo 白天模式
     */
    static readonly t231: number;
    /**
     * Logo 黑夜模式
     */
    static readonly u231: number;
    /**
     * Logo 海外模式
     */
    static readonly v231: number;
    /**
     * Logo 本地存放缓存文件名称 白天图片
     */
    static w231: string;
    /**
     * Logo 本地存放缓存文件名称 黑夜图片
     */
    static x231: string;
    /**
     * 引擎导览线纹理资源 箭头资源ID
     */
    static readonly y231: number;
    /**
     * 引擎导览线纹理资源 箭头边框资源ID
     */
    static readonly z231: number;
    /**
     * 引擎导览线纹理资源 箭头阴影资源ID
     */
    static readonly a232: number;
    /**
     * 下沉，jni hitTest判断类型
     * 值和AMapNativeGlOverlayLayer.cpp中nativeContains对应
     */
    static readonly m97: number;
    static readonly u97: number;
    static readonly b232: number;
    static readonly c232 = "amap";
    static readonly y184 = "data_v6";
    static readonly d232 = "GNaviConfig.xml";
    static readonly e232 = "res.zip";
    /**
     * res目标名称
     */
    static readonly f232 = "res920";
    private static readonly g232;
    private static readonly h232;
    private static readonly i232;
    private static readonly j232;
    private static readonly k232;
    static readonly l232 = "online";
    static readonly z184 = "map";
    private static m232;
    private static n232?;
    static o232(): string;
    static initResource(context: Context): InitParam;
    static i95(context: Context): InitParam;
    private static p232;
    private static r232;
    private static s232;
    private static q232;
    private static v232;
}
