// @keepTs
// @ts-nocheck
import { y72 } from "./StyleParserResult";
import ArrayList from "@ohos.util.ArrayList";
import { e53 } from "./StyleConfig";
import { i217 } from "./EngineStyleKeyItem";
/**
 * 包名： com.amap.api.mapcore.style
 * <p>
 * 创建时间：2016/11/29
 * 项目名称：AndroidMapSDK3D
 * <p>
 * 类说明：自定义样式解析及修改
 *
 * 文档说明见：https://lark.alipay.com/amapsdk/map/aam1d8
 *
 * @author zxy
 */
export declare class d53 {
    static readonly s225: string;
    static readonly t225: string;
    static readonly u225: string;
    static readonly v225: number;
    static readonly w225: number;
    static readonly x225: number;
    static readonly y225: number;
    static readonly z225: number;
    static readonly a226: string;
    static readonly b226: number;
    static readonly c226: number;
    static readonly d226: string;
    static readonly e226: string;
    private static readonly f226;
    /**
     * 网格背景色
     */
    private a172;
    /**
     * 开启路况时道路背景颜色
     */
    private x39;
    /**
     * 开启路况时道路背景颜色 mainkey
     */
    private static readonly g226;
    /**
     * 开启路况时道路背景颜色 subkey
     */
    private static readonly h226;
    /**
     * 自定义的配置元素 名称
     */
    private static readonly i226;
    private static readonly j226;
    constructor();
    /**
     * 获取自定义样式列表
     *
     * @param jsonPath
     * @return
     */
    v96(jsonPath: string, q225: boolean): y72 | undefined;
    /**
     * 通过二进制文件直接解析
     *
     * @param data               二进制数据
     * @param isUseCustomTexture
     * @return
     */
    u96(data: Uint8Array, o225: boolean): y72 | undefined;
    /**
     * 解析自定义样式文件
     *
     * @param data               二进制数据
     * @param isUseCustomTexture
     * @return
     */
    l226(data: Uint8Array, m225: boolean): y72;
    /**
     * 构建一个特殊样式
     * 处理自定义样式时路况底色问题
     *
     * @param styleParserResult
     */
    protected o226(h225: y72): void;
    /**
     * 解析自定义样式文件
     *
     * @param path 路径
     * @return
     */
    k226(path: string, f225: boolean): y72 | undefined;
    /**
     * 新版样式文件（加密后的）
     *
     * @param customStyleBytes
     * @param isUseCustomTexture
     */
    private n226;
    /**
     * 解析配置的自定义样式
     * <p>
     * 根据配置样式中，样式类别名称 去查找 引擎样式对应的 mainkey 和sukey
     * 一个类名可能对应多个 mainkey 和sukey
     * 一个mainkey 和sukey 对应引擎的中样式，如二级道路
     *
     * @param jsonObjectName      json 名称 一般是自定义样式的某一个大类
     * @param styles              保持的配置项目，解析完成的结果都会放在这里,最终将这份结果设置给引擎
     * @param styleItemJsonObject json信息
     * @param isUseCustomTexture  是否使用纹理
     * @throws JSONException
     */
    private s226;
    /**
     * 设置开启路况时 路线颜色
     *
     * @param trafficRoadBackgroundColor
     */
    l40(h224: number): void;
    private static readonly v226;
    private static readonly KEY_NAME;
    private static readonly w226;
    private static readonly x226;
    private static readonly u226;
    private static readonly y226;
    private static readonly z226;
    a227: ArrayList<i217> | undefined;
    /**
     * 代码为JSON解析
     * <p>
     * 服务端JSON全量内容，可以通过它获取 某种类型对应的mainkey和subkey
     * 一个类型可能对应多个mainkey 和subkey
     * <p>
     * 每一对mainkey-subkey可以对应地图中一种特定类型
     *
     * @return
     */
    private b227;
    /**
     * JSON解析，解析mainKey和subkey
     * 多个地方调用 所以抽成方法
     */
    private d227;
    /**
     * 获取某一类名称对应的引擎样式
     * 比如 land 对应的有 哪几种mainkey 和subKey
     *
     * @param name 名称
     * @return
     */
    private q226;
    /**
     * 解析新版样式json
     *
     * @param styleItemJsonObject
     */
    private t226;
    /**
     * 写入颜色（新）
     *
     * @param styles
     * @param styleSubItemJsonObject
     * @param colorKey
     * @param opacityKey
     * @param format
     * @throws JSONException
     */
    private e227;
    private f227;
    static h59(o221: Uint8Array): Promise<e53>;
    private static g227;
    static h227(f221: Uint8Array | undefined, privateKey: Uint8Array | undefined, g221: Uint8Array | undefined): Promise<string>;
    /**
     * 解析老版本的样式json
     *
     * @param customStyleBytes
     */
    private m226;
    /**
     * 批量写入
     *
     * @param styles
     * @param jsonObject
     * @param styleTypeKey       即rootName
     * @param styleTypeIds
     * @param styleElementTypeId
     * @throws JSONException
     */
    private i227;
    private j227;
    /**
     * 从map中获取StyleElement
     *
     * @param styles
     * @param styleTypeId
     * @param styleElementTypeId
     * @return
     */
    private r226;
    /**
     * 解析颜色
     *
     * @param color
     * @return
     */
    static k59(color: string): number;
    q67(): number;
    static k227(f220: string): number;
    static readonly c227: string;
}
