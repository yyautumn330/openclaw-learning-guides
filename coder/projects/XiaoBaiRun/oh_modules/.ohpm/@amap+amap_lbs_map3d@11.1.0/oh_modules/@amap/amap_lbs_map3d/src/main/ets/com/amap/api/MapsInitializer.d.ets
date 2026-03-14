// @keepTs
// @ts-nocheck
import { AMapPrivacyAgreeStatus, AMapPrivacyInfoStatus, AMapPrivacyShowStatus } from '@amap/amap_lbs_common';
/**
 * 初始化 SDK context 全局变量，指定 sdcard 路径，设置鉴权所需的KEY。
 * 注：如果在创建地图之前使用BitmapDescriptorFactory的功能，则必须通过{@link #initialize(Context)}来设置一个可用的context。
 *
 * @since 1.0.0
 */
type ExceptionLogger = (error: Error) => void;
export declare class MapsInitializer {
    /**
     * 初始化全局 context。在使用SDK各组件之前调用。
     *
     * @param paramContext context对象，不能为空。
     * @throws RemoteException
     * @since 1.0.0
     */
    static initialize(i11: Context): void;
    private static isNetWorkEnable;
    private static exceptionLogger?;
    /**
     * 地图缓存目录。
     *
     * @since V2.0.2
     */
    static j11: string;
    /**
     * 是否海外mapbox矢量图
     * @exclude javadoc中不显示 暂时不显示
     */
    private static isloadWorldVectorMap;
    /**
     * 海外矢量图样式， 默认为中文
     * @exclude javadoc中不显示 暂时不显示
     */
    private static sVectorMapStyle;
    /**
     * 地图语言
     * @exclude javadoc中不显示 暂时不显示
     */
    private static sMapLanguage;
    /**
     * 是否提前初始化worker.js
     * @exclude javadoc中不显示 暂时不显示
     */
    private static sIsPreLoadWorkerJS;
    /**
     * 是否处于debugmode，demomode会打印日志
     * @exclude javadoc中不显示 暂时不显示
     */
    private static sIsDebugMode;
    /**
     * 是否包含Assets资源，如果没有会在线拉取
     * @exclude javadoc中不显示 暂时不显示
     */
    private static isContainsJsMapAssets;
    /**
     * @exclude javadoc中不显示 暂时不显示
     */
    private static k11;
    /**
     * 地形图 离线数据
     * @exclude javadoc中不显示
     */
    static l11: string | null;
    /**
     * 是否打开地形图, 默认为关闭
     * 打开地形图之后，底图会变成3D模式，添加的点线面等覆盖物也会自动带有高程
     *
     * @since 8.0.0
     */
    private static n11;
    private static o11;
    /**
     * 是否打开地形图, 默认为关闭
     * 打开地形图之后，底图会变成3D模式，添加的点线面等覆盖物也会自动带有高程
     *
     * @return true为打开，默认false
     * @since 8.0.0
     */
    static isTerrainEnable(): boolean;
    static isContourLineEnable(): boolean;
    /**
     * 设置是否打开地形图, 默认为关闭
     * 打开地形图之后，底图会变成3D模式，添加的点线面等覆盖物也会自动带有高程
     * <p>
     * 注意：需要在MapView创建之前调用
     *
     * @param isTerrainEnable true为打开，默认false
     * @since 2.2.4
     */
    static setTerrainEnable(h11: boolean): void;
    static setContourLineEnable(enable: boolean): void;
    /**
     * 地图缓存目录。
     *
     * @since V2.0.2
     */
    static p11(g11: string): void;
    /**
     * 是否包含Assets资源
     * @param isLoad true为打开，默认为false
     * @since 1.0.0
     * @exclude javadoc中不显示
     */
    static setContainsJsMapAssets(f11: boolean): void;
    /**
     * 是否包含Assets资源
     * @since 1.0.0
     * @exclude javadoc中不显示
     */
    static getContainsJsMapAssets(): boolean;
    /**
     * 设置是否可以联网获取地图数据
     *
     * @param enable 是否可以联网获取地图数据。默认为true，可以联网
     * @since 1.0.0
     */
    static setNetWorkEnable(enable: boolean): void;
    /**
     * 是否可以联网获取地图数据。
     *
     * @return 是否可以联网获取地图数据。默认为true，可以联网。
     * @since 1.0.0
     */
    static getNetWorkEnable(): boolean;
    /**
     * 动态设置apiKey。
     *
     * @param apiKey 在高德官网上申请的apiKey。
     * @since 1.0.0
     */
    static setApiKey(e11: string): void;
    /**
     * 返回地图SDK的版本号。
     *
     * @return 地图的版本号。
     * @since 1.0.0
     */
    static getVersion(): string;
    /**
     * 设置当可视区域显示国外数据时是否加载国外的矢量数据。
     * @param isLoad true为打开，默认为false
     * @since 1.0.0
     * @exclude javadoc中不显示
     */
    static setLoadWorldVectorMap(d11: boolean): void;
    /**
     * 设置当可视区域显示国外数据时是否加载国外的矢量数据。
     * @since 1.0.0
     * @exclude javadoc中不显示
     */
    static isLoadWorldVectorMap(): boolean;
    /**
     * 设置海外矢量地图样式,其中包括地图选用策略、地图样式（含语言）、抠边区域和重新绘制边界
     * 默认为中文样式
     *
     * @param style 支持有 style_zh_cn 中文样式，style_lazada lazada定制样式，style_en 英文样式，style_local 当地样式
     * @exclude javadoc中不显示
     * @since 2.0.0
     */
    static setWorldVectorMapStyle(style: string): void;
    /**
     * 获取海外矢量地图样式,其中包括地图选用策略、地图样式（含语言）、抠边区域和重新绘制边界
     *
     *
     * @return style 支持有style_zh_cn 中文样式，style_lazada lazada定制样式，并且可扩展
     * @exclude javadoc中不显示
     * @since 1.2.0
     */
    static getWorldVectorMapStyle(): string;
    /**
     * 设置地图底图语言，目前支持中文底图和英文底图
     *
     * @param language 中文"zh_cn", 英文"en"
     * @since 2.2.4
     */
    static setMapLanguage(language: string): void;
    /**
     * 获取地图底图语言，目前支持中文底图和英文底图
     *
     * @return language 中文"zh_cn", 英文"en"
     * @since 2.2.4
     */
    static getMapLanguage(): string;
    /**
     * 是否提前初始化worker.js，缩短初始化时间
     * @param isLoad true为打开，默认为false
     * @since 1.0.0
     * @exclude javadoc中不显示
     */
    static setPreLoadWorkerJS(c11: boolean): void;
    /**
     * 是否提前初始化worker.js，缩短初始化时间
     * @since 1.0.0
     * @exclude javadoc中不显示
     */
    static isPreLoadWorkerJS(): boolean;
    /**
     * 是否处于debugmode，demomode会打印日志
     * @param mode true为打开，默认为false
     * @since 1.0.0
     * @exclude javadoc中不显示
     */
    static setDebugMode(mode: boolean): void;
    /**
     * 是否处于debugmode，demomode会打印日志
     * @since 1.0.0
     * @exclude javadoc中不显示
     */
    static isDebugMode(): boolean;
    /**
     * Http协议。
     * @since 1.0.0
     */
    static readonly HTTP: number;
    /**
     * Https协议。
     * @since 1.0.0
     */
    static readonly HTTPS: number;
    /**
     * 网络请求协议类型
     * @since 1.0.0
     */
    private static mProtocol;
    /**
     * 设置访问使用的协议类别。
     * 如果是Android P及以上 默认使用Https，就算设置了Http内部也会走Https
     * @param protocol 包含Http和Https两种协议。
     * @since 1.0.0
     */
    static setProtocol(protocol: number): void;
    /**
     * 返回访问使用的协议类别
     * @return 协议类别，包含Http和Https两种协议。
     * @since 1.0.0
     */
    static getProtocol(): number;
    /**
     * @since 1.0.0
     * @return
     * @exclude javadoc中不显示
     */
    static setExceptionLogger(b11: ExceptionLogger): void;
    /**
     * @since 1.0.0
     * @return
     * @exclude javadoc中不显示
     */
    static getExceptionLogger(): ExceptionLogger | undefined;
    /**
     * 是否关闭底图缓存数据自动更新功能，关闭后一旦有过缓存，则不会再重新请求数据
     * @exclude javadoc中不显示
     * @deprecated 支付宝5.7.0，定制接口，后续已不使用，避免支付宝编译报错，所以保留接口空实现
     */
    static disableCachedMapDataUpdate(flag: boolean): void;
    /**
     * 是否关闭底图缓存数据自动更新功能，关闭后一旦有过缓存，则不会再重新请求数据
     * @exclude javadoc中不显示
     * @deprecated 支付宝5.7.0，定制接口，后续已不使用，避免支付宝编译报错，所以保留接口空实现
     */
    static isDisableCachedMapDataUpdate(): boolean;
    static q11(): boolean;
    /**
     * 更新App是否显示隐私弹窗的状态，隐私弹窗是否包含高德SDK隐私协议内容的状态，注意：必须在MapViewManager实例化之前调用。
     * @param showStatus 隐私弹窗状态
     * @param containStatus 包含高德SDK隐私协议状态
     * @param context: 上下文
     * @since 1.0.0
     */
    static updatePrivacyShow(z10: AMapPrivacyShowStatus, a11: AMapPrivacyInfoStatus, context: Context): void;
    /**
     * 更新用户授权高德SDK隐私协议状态，注意：必须在AMapLocationManager实例化之前调用。
     * @param agreeStatus 用户授权高德SDK隐私协议状态
     * @param context: 上下文
     * @since 1.0.0
     */
    static updatePrivacyAgree(y10: AMapPrivacyAgreeStatus, context: Context): void;
}
export {};
