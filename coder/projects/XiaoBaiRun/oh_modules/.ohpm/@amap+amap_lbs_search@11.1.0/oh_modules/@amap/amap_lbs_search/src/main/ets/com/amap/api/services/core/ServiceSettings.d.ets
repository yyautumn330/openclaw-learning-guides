// @keepTs
// @ts-nocheck
import { AMapPrivacyAgreeStatus, AMapPrivacyInfoStatus, AMapPrivacyShowStatus } from "@amap/amap_lbs_common";
/**
 * 设置API接口访问协议的单例。
 * @since 1.0.0
 */
export declare class ServiceSettings {
    /**
     * 英文
     * @see ServiceSettings#setLanguage(String)
     * @since 1.0.0
     */
    static readonly ENGLISH = "en";
    /**
     * 中文
     * @see ServiceSettings#setLanguage(String)
     * @since 1.0.0
     */
    static readonly CHINESE = "zh-CN";
    /**
     * Http协议。
     * @since 1.0.0
     */
    static readonly HTTP = 1;
    /**
     * Https协议。
     * @since 1.0.0
     */
    static readonly HTTPS = 2;
    private d56;
    private e56;
    private static f56;
    private static readonly g56;
    private static readonly h56;
    private i56;
    private j56;
    /**
     * 返回搜索服务建立连接超时限制。
     * @return 毫秒级参数
     * @since 1.0.0
     */
    getConnectionTimeOut(): number;
    /**
     * 读取返回结果超时限制
     * @return 毫秒级参数
     * @since 1.0.0
     */
    getSoTimeOut(): number;
    /**
     * 设置搜索服务建立连接超时。默认为20000，阈值下限为5000，上限为30000.
     * @param connectionTimeout 毫秒级参数。
     * @since 1.0.0
     */
    setConnectionTimeOut(connectionTimeout: number): void;
    /**
     * 设置搜索读取返回结果超时。默认为20000，阈值下限为5000，上限为30000.
     * @param soTimeOut 毫秒级参数。
     * @since 1.0.0
     */
    setSoTimeOut(c56: number): void;
    private constructor();
    /**
     * 初始化ServiceSettings的单例对象。
     * @return ServiceSettings单例对象。
     * @since 1.0.0
     */
    static getInstance(): ServiceSettings;
    /**
     * 设置搜索、地理/逆地理编码、输入提示中英文切换的接口。
     * 国内仅支持中文和英文
     *
     * 如果在海外使用，还可以支持更多语言，7.4.0 开始支持<br>
     * 语言代码  语言_EN  语言<br>
     * da  Danish  丹麦语<br>
     * de  German  德语<br>
     * en  English  英语<br>
     * es  Spanish  西班牙语<br>
     * es-ES  Spanish (Spain)  西班牙语（西班牙）<br>
     * fi  Finnish  芬兰语<br>
     * fr  French  法语<br>
     * id  Indonesian  印尼语<br>
     * it  Italian  意大利语<br>
     * ko  Korean  韩语<br>
     * my  Burmese  缅甸语<br>
     * nl  Dutch  荷兰语<br>
     * no  Norwegian (Bokmål)  挪威语<br>
     * pt-BR  Portuguese (Brazil)  葡萄牙语（巴西）<br>
     * pt-PT  Portuguese (Portugal)  葡萄牙语（葡萄牙）<br>
     * ru  Russian  俄语<br>
     * sv  Swedish  瑞典语<br>
     * tr  Turkish  土耳其语<br>
     * vi  Vietnamese  越南语<br>
     *
     * @param language 语言类型 {@link ServiceSettings#ENGLISH} 或者 {@link ServiceSettings#CHINESE}。
     * @since 1.0.0
     */
    setLanguage(language: string): void;
    /**
     * 设置访问使用的协议类别。
     * @param protocol 包含Http和Https两种协议。
     * @since 1.0.0
     */
    setProtocol(protocol: number): void;
    /**
     * 搜索、地理/逆地理编码、输入提示的返回结果语言类型，中英文。
     * @return 语言类型
     * @since 1.0.0
     */
    getLanguage(): string;
    /**
     * 返回访问使用的协议类别
     * @return 协议类别，包含Http和Https两种协议。
     * @since 1.0.0
     */
    getProtocol(): number;
    /**
     * 动态设置apiKey。
     * @param apiKey 在高德官网上申请的apiKey。
     * @since 1.0.0
     */
    setApiKey(b56: string): void;
    /**
     * 销毁搜索异步搜索线程池,会调用内部线程池的shutdown方法
     * 之后在调用各搜索的异步接口 如{@link PoiSearch#searchPOIAsyn()}  还会自动新建线程池
     * @exclude javadoc中不显示。
     * @since 1.0.0
     */
    /**
     * 更新隐私合规状态,需要在初始化地图之前完成
     * @param showStatus 隐私弹窗状态
     * @param containStatus 包含高德SDK隐私协议状态
     * @param context: 上下文
     * @since 1.0.0
     */
    static updatePrivacyShow(z55: AMapPrivacyShowStatus, a56: AMapPrivacyInfoStatus, context: Context): void;
    /**
     * 更新同意隐私状态,需要在初始化地图之前完成
     * @param agreeStatus 用户授权高德SDK隐私协议状态
     * @param context: 上下文
     * @since 1.0.0
     */
    static updatePrivacyAgree(y55: AMapPrivacyAgreeStatus, context: Context): void;
}
