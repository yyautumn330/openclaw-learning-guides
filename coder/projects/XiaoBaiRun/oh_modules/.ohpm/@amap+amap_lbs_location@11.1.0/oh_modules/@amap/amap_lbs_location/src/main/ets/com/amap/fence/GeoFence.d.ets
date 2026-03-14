// @keepTs
// @ts-nocheck
import { AMapLocation } from "../location/AMapLocation";
import { q13 } from "./DistrictItem";
import { PoiItem } from "./PoiItem";
import ArrayList from "@ohos.util.ArrayList";
import { DPoint } from "../location/DPoint";
/**
 * 地理围栏对象
 * @项目名称： AMapLocationSDK
 * @文件名称：GeoFence
 * @类型名称：GeoFence
 * @since 3.2.0
 */
export declare class GeoFence {
    /**
     * 超时时间的最小值
     */
    private static readonly m17;
    /**
     * 超时时间的默认值
     */
    private static readonly n17;
    /**
     * 地理围栏广播中Bundle的key-围栏Id
     * @since 3.2.0
     */
    static readonly o17: string;
    /**
     * 地理围栏广播中Bundle的key-业务Id
     * @since 3.2.0
     */
    static readonly p17: string;
    /**
     * 地理围栏广播中Bundle的key-围栏状态
     * @since 3.2.0
     */
    static readonly q17: string;
    /**
     * 地理围栏广播中Bundle的key-定位错误码
     * @since 3.3.0
     */
    static readonly f9: string;
    /**
     * 地理围栏广播中Bundle的key-围栏对象
     * @since 3.2.0
     */
    static readonly r17: string;
    /**
     * 创建地理围栏成功
     * @since 3.2.0
     */
    static readonly ADDGEOFENCE_SUCCESS: number;
    /**
     * 错误码：参数错误
     * @since 3.2.0
     */
    static readonly a10: number;
    /**
     * 错误码：网络连接异常
     * @since 3.2.0
     */
    static readonly g11: number;
    /**
     * 错误码：解析数据失败（有可能是连接的需要登录的网络但是没有登录）
     * @since 3.4.0
     */
    static readonly o12: number;
    /**
     * 错误码：鉴权失败
     * @since 3.2.0
     */
    static readonly n12: number;
    /**
     * 错误码：其他未知错误
     * @since 3.2.0
     */
    static readonly h11: number;
    /**
     * 错误码：无可用地理围栏
     * @since 3.2.0
     */
    static readonly d11: number;
    /**
     * 错误码： 相同的围栏已经存在，无需重复添加
     * <p>
     * 当地理围栏的customID，半径，周边点（多边形），中心点坐标（圆形）这几个属性完全一致时，则认为是相同围栏
     * </p>
     *
     * @since 3.3.0
     */
    static readonly q11: number;
    /**
     * 围栏状态-进入围栏
     * @since 3.2.0
     */
    static readonly STATUS_IN: number;
    /**
     * 围栏状态-离开围栏
     * @since 3.2.0
     */
    static readonly STATUS_OUT: number;
    /**
     * 围栏状态-在围栏内停留
     * @since 3.2.0
     */
    static readonly STATUS_STAYED: number;
    /**
     * 围栏状态-定位失败(定位失败时，围栏状态无法进行检测)
     * @since 3.2.0
     */
    static readonly s17: number;
    /**
     * 围栏状态-初始状态，表示从未触发过围栏
     * @since 3.2.0
     */
    static readonly x9: number;
    /**
     * 自建的圆形围栏
     * @since 3.2.0
     */
    static readonly p10: number;
    /**
     * 自建的多边形围栏
     * @since 3.2.0
     */
    static readonly j10: number;
    /**
     * 高德POI围栏
     * @since 3.2.0
     */
    static readonly j12: number;
    /**
     * 高德行政区划围栏
     * @since 3.2.0
     */
    static readonly k12: number;
    /**
     * fenceId，自动生成
     * @since 3.2.0
     */
    private fenceId;
    /**
     * 自定义的业务ID
     * @since 3.2.0
     */
    private customId;
    /**
     * 围栏类型
     * <p>
     * 目前支持的类型:
     * <dl>
     * <dt>{@link #TYPE_ROUND}(自建的圆形围栏)</dt>
     * <dt>{@link #TYPE_POLYGON}(自建的圆形围栏)</dt>
     * <dt>{@link #TYPE_AMAPPOI}(高德POI围栏)</dt>
     * <dt>{@link #TYPE_DISTRICT}(高德政区划围栏)</dt>
     * </dl>
     * </p>
     * @since 3.2.0
     */
    private type;
    /**
     * 只有poi类型的围栏才有值
     * @since 3.2.0
     */
    private t17?;
    /**
     * 只有行政区划类型的围栏才有值
     * @since 3.2.0
     */
    private u17?;
    /**
     * 坐标点列表
     * @since 3.2.0
     */
    private v17?;
    /**
     * 地理围栏半径，单位米 当围栏为周边搜围栏时，半径默认为200m<br>
     * 当围栏为关键字搜索创建的围栏时，半径默认为1000m
     * @since 3.2.0
     */
    private radius;
    /**
     * 过期时间, 单位毫秒 暂时不对用户提供
     * @since 3.2.0
     */
    private expiration;
    /**
     * 触发地理围栏提醒的条件, 默认为进入地理围栏提醒
     * @since 3.2.0
     */
    private w17;
    /**
     * 内部使用，地理围栏边界与中心点最小距离
     * @since 3.2.0
     */
    private x17;
    /**
     * 内部使用，地理围栏边界与中心点最大距离
     * @since 3.2.0
     */
    private y17;
    /**
     * 围栏中心点
     * @since 3.2.0
     * @exclude
     */
    private center?;
    /**
     * 地理围栏的状态
     * <p>
     * 目前的状态有:
     * <dl>
     * <dt>{@link #STATUS_IN} 进入围栏</dt>
     * <dt>{@link #STATUS_OUT} 离开围栏</dt>
     * <dt>{@link #STATUS_STAYED} 在围栏内停留</dt>
     * <dt>{@link #STATUS_UNKNOWN} 初始转态，表示此围栏从未触发过</dt>
     * </dl>
     * </p>
     * @since 3.2.0
     */
    private status;
    /**
     * 进入围栏的时间，如果是离开围栏则为-1
     * @since 3.2.0
     */
    private z17;
    /**
     * 围栏是否可用，用于判断围栏的暂停和回复
     * @since 3.6.0
     */
    private a18;
    /**
     * 当前位置，只有在围栏被触发时才有值
     * @since 3.7.0
     */
    private b18?;
    /**
     * 构造方法
     */
    constructor();
    /**
     * 获取地理围栏的ID
     *
     * @return 围栏的ID(自动生成)
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    getFenceId(): string;
    /**
     * 设置围栏ID
     *
     * @param fenceId
     * @since 3.2.0
     * @author hongming.wang
     * @exclude
     */
    u10(l17: string): void;
    /**
     * 获取自定义的围栏ID(添加围栏时设置)
     *
     * @return 自定义的围栏ID
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    getCustomId(): string;
    /**
     * 设置自定义的围栏ID
     *
     * @param customId
     *            自定义的围栏ID
     * @since 3.2.0
     * @author hongming.wang
     * @exclude
     */
    r10(customId: string): void;
    /**
     * 获取围栏类型
     *
     * @return 围栏类型
     *         <p>
     *         目前支持的类型:
     *         <dl>
     *         <dt>{@link #TYPE_ROUND}(自建的圆形围栏)</dt>
     *         <dt>{@link #TYPE_POLYGON}(自建的圆形围栏)</dt>
     *         <dt>{@link #TYPE_AMAPPOI}(高德POI围栏)</dt>
     *         <dt>{@link #TYPE_DISTRICT}(高德政区划围栏)</dt>
     *         </dl>
     *         </p>
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    getType(): number;
    /**
     * 设置围栏类型
     *
     * @param type
     *            围栏类型
     *            <p>
     *            目前支持的类型:
     *            <dl>
     *            <dt>{@link #TYPE_ROUND}(自建的圆形围栏)</dt>
     *            <dt>{@link #TYPE_POLYGON}(自建的圆形围栏)</dt>
     *            <dt>{@link #TYPE_AMAPPOI}(高德POI围栏)</dt>
     *            <dt>{@link #TYPE_DISTRICT}(高德政区划围栏)</dt>
     *            </dl>
     *            </p>
     * @since 3.2.0
     * @author hongming.wang
     * @exclude
     */
    setType(type: number): void;
    /**
     * 获取围栏内的兴趣点属性
     * <p>
     * 只有围栏类型为:{@link #TYPE_AMAPPOI}时才有值
     * </p>
     * @return 围栏内的兴趣点属性（如果有）
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    c18(): PoiItem | undefined;
    /**
     * 设置围栏内的兴趣点属性
     *
     * @param poiItem
     * @since 3.2.0
     * @author hongming.wang
     * @exclude
     */
    o16(k17: PoiItem): void;
    /**
     * 获取该围栏中的行政区划列表
     * <p>
     * 只有围栏类型为:{@link #TYPE_DISTRICT}时才有值
     * </p>
     * @return 围栏中的行政区划列表（如果有）
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    d18(): ArrayList<q13> | undefined;
    /**
     * 设置行政区划
     *
     * @param districtItemList
     * @since 3.2.0
     * @author hongming.wang
     * @exclude
     */
    t16(j17: ArrayList<q13>): void;
    /**
     * 获取围栏坐标点
     *
     * @return 围栏坐标点
     *         <p>
     *         <dl>
     *         <dt>当围栏类型为{@link #TYPE_ROUND}或者
     *         {@link #TYPE_AMAPPOI}时, 坐标点只有一个，即围栏的中心点</dt>
     *         <dt>当围栏类型为{@link #TYPE_POLYGON}或者
     *         {@link #TYPE_DISTRICT}时，坐标点是多个，即围栏的边线点</dt>
     *         </dl>
     *         </p>
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    getPointList(): ArrayList<ArrayList<DPoint>> | undefined;
    /**
     * 设置围栏的坐标点
     *
     * @param pointList
     *            围栏坐标点
     *            <p>
     *            <dl>
     *            <dt>当围栏类型为{@link #TYPE_ROUND}或者
     *            {@link #TYPE_AMAPPOI}时, 坐标点只有一个，即围栏的中心点</dt>
     *            <dt>当围栏类型为{@link #TYPE_POLYGON}或者
     *            {@link #TYPE_DISTRICT}时，坐标点是多个，即围栏的边线点</dt>
     *            </dl>
     *            </p>
     * @since 3.2.0
     * @author hongming.wang
     * @exclude
     */
    s10(i17: ArrayList<ArrayList<DPoint>>): void;
    /**
     * 获取地理围栏半径
     * 当围栏类型为{@link #TYPE_ROUND}或者
     *         {@link #TYPE_AMAPPOI}时,才有效
     * @return
     * @since 3.2.0
     * @author hongming.wang
     * @exclude
     */
    getRadius(): number;
    /**
     * 设置地理围栏半径
     *
     * @param radius
     * @since 3.2.0
     * @author hongming.wang
     * @exclude
     */
    setRadius(radius: number): void;
    /**
     * 获取超时时间, 默认为-1（暂时不对外提供）
     *
     * @return 超时时间
     * @since 3.2.0
     * @author hongming.wang
     * @exclude
     */
    e18(): number;
    /**
     * 设置超时时间, 默认为-1（暂时不对外提供）
     *
     * @param expiration
     * @since 3.2.0
     * @author hongming.wang
     * @exclude
     */
    t10(expiration: number): void;
    /**
     * 获取设置的地理围栏触发条件
     * <p>
     *
     * @see {@link GeoFenceClient#setActivateAction(int)
     *      GeoFenceClientsetActivatesAction}
     *      </p>
     * @return 触发地理围栏的条件
     * @since 3.2.0
     * @author hongming.wang
     */
    f18(): number;
    /**
     * 设置用户设置的地理围栏触发条件
     *
     * @param activatesAction
     * @since 3.2.0
     * @author hongming.wang
     * @exclude
     */
    q10(h17: number): void;
    /**
     * 获取围栏的状态
     *
     * @return 围栏的状态
     *         <p>
     *         目前的状态有：
     *         <dl>
     *         <dt>{@link #STATUS_IN} 进入围栏</dt>
     *         <dt>{@link #STATUS_OUT} 离开围栏</dt>
     *         <dt>{@link #STATUS_STAYED} 停留在围栏内</dt>
     *         </dl>
     *         </p>
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    getStatus(): number;
    /**
     * 设置围栏的状态
     *
     * @param status
     *            围栏的状态
     *            <p>
     *            目前的状态有：
     *            <dl>
     *            <dt>{@link #STATUS_IN} 进入围栏</dt>
     *            <dt>{@link #STATUS_OUT} 离开围栏</dt>
     *            <dt>{@link #STATUS_STAYED} 在围栏内停留10分钟以上</dt>
     *            </dl>
     *            </p>
     * @since 3.2.0
     * @author hongming.wang
     * @exclude
     */
    setStatus(status: number): void;
    /**
     * 获取进入围栏的系统时间（启动时间），单位:毫秒
     *
     * @return 进入围栏的时间, -1:表示不在围栏内
     * @since 3.2.0
     * @author hongming.wang
     * @exclude
     */
    l12(): number;
    /**
     * 设置进入围栏的系统时间(启动时间), 单位:毫秒
     *
     * @param enterTime
     *            最后进入围栏的系统时间(启动时间)，离开设置为-1;
     * @since 3.2.0
     * @author hongming.wang
     * @exclude
     */
    y9(g17: number): void;
    /**
     * 获取围栏中心点坐标
     * @since 3.2.0
     */
    getCenter(): DPoint | undefined;
    /**
     * 设置围栏中心点坐标
     * @since 3.2.0
     * @exclude
     */
    setCenter(center: DPoint): void;
    /**
     * 获取围栏边界与中心点的最小距离
     * @since 3.2.0
     * @exclude
     */
    c12(): number;
    /**
     * 设置围栏边界与中心点的中心点最小距离
     * @since 3.2.0
     * @exclude
     */
    n10(f17: number): void;
    /**
     * 获取围栏边界与中心点的点最大距离
     * @since 3.2.0
     * @exclude
     */
    d12(): number;
    /**
     * 设置围栏边界与中心点的最大距离
     * @since 3.2.0
     * @exclude
     */
    l10(e17: number): void;
    /**
     * 获取围栏是否可用
     * @return 围栏是否可用, 默认为true，可用
     * @since 3.6.0
     */
    k11(): boolean;
    /**
     * 设置围栏是否可用
     * @param able true:可用；false:不可用
     * @since 3.6.0
     */
    i11(d17: boolean): void;
    /**
     * 设置当前位置， 触发围栏时设置
     * @since 3.7.0
     * @param loc
     * @exclude
     */
    w11(c17: AMapLocation): void;
    /**
     * 获取当前位置，只有在围栏触发时才有值,其它情况值为null
     * @return
     * @since 3.7.0
     */
    getCurrentLocation(): AMapLocation | undefined;
}
