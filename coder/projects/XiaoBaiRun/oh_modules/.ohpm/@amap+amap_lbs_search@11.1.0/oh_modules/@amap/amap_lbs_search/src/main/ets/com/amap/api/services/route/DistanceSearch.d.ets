// @keepTs
// @ts-nocheck
import { LatLonPoint } from "../core/LatLonPoint";
import { DistanceResult } from "./DistanceResult";
import ArrayList from "@ohos.util.ArrayList";
/**
 * 距离测量，通过两点计算直线距离或者驾车导航距离，相比路径规划返回内容较少，适合频繁调用场景。
 *
 * @since V1.0.0
 */
export declare class DistanceSearch {
    private static v44;
    private search;
    /**
     * 距离测量方法：直线距离
     * @since V1.0.0
     */
    static TYPE_DISTANCE: number;
    /**
     * 距离测量方法：驾车导航距离（仅支持国内坐标）<br>
     * 会考虑路况，在不同时间请求返回结果可能不同。<br>
     * 此策略和driving接口的 strategy=4 策略一致
     * @since V1.0.0
     */
    static TYPE_DRIVING_DISTANCE: number;
    /**
     * 距离测量方法：步行导航距离（仅支持国内坐标）<br>
     * @since V1.0.0
     */
    static TYPE_WALK_DISTANCE: number;
    /**
     * 扩展字段all，会返回完整参数
     * @since V1.0.0
     */
    static EXTENSIONS_ALL: string;
    /**
     * 扩展字段base，会返回部分参数
     * @since V1.0.0
     */
    static EXTENSIONS_BASE: string;
    /**
     * 距离测量搜索的构造函数
     * @param context 上下文
     * @since V1.0.0
     */
    constructor(context: Context);
    /**
     * 设置距离测量异步请求监听回调
     * @param listener 监听回到实现
     * @since V1.0.0
     */
    setDistanceSearchListener(listener: OnDistanceSearchListener): void;
    /**
     * 测量距离请求接口，调用后会发起距离测量请求。
     * 该接口为同步接口，由于带有网络操作需要在子线程中调用。
     * @param query 请求参数
     * @return 距离测量结果
     * @since V1.0.0
     */
    calculateRouteDistance(query: DistanceQuery): Promise<DistanceResult | undefined>;
    /**
     * 测量距离请求接口，调用后会发起距离测量请求。
     * 该接口为异步接口，请求结果会在{@link OnDistanceSearchListener }中进行回调。
     * @param query 请求参数
     * @return 距离测量结果
     * @since V1.0.0
     */
    calculateRouteDistanceAsyn(query: DistanceQuery): void;
}
/**
 * 距离测量属性设置类，其中包含起终点以及测量类型的设置。
 * @since V1.0.0
 */
export declare class DistanceQuery {
    private type;
    private origins;
    private destination;
    /**
     * 扩展字段 base表示只返回基础数据，all表示所有数据 ，默认 base
     */
    private z2;
    /**
     * 驾车距离测量模式， 默认是4
     * 仅驾车距离测量生效
     */
    private t67;
    /**
     * @exclude javadoc中不显示。
     */
    clone(): DistanceQuery;
    /**
     * 获取距离测量方式
     * @return 方式包含{@link #TYPE_DISTANCE} {@link #TYPE_DRIVING_DISTANCE}
     * @since V1.0.0
     */
    getType(): number;
    /**
     * 获取距离测量起点集合
     * @return 起点集合是一个数据，默认数据为空
     * @since V1.0.0
     */
    getOrigins(): ArrayList<LatLonPoint>;
    /**
     * 获取距离测量终点
     * @return 终点坐标，默认为null
     * @since V1.0.0
     */
    getDestination(): LatLonPoint | undefined;
    /**
     * 设置距离测量方式
     * @param type 参考 {@link #TYPE_DISTANCE} {@link #TYPE_DRIVING_DISTANCE}
     * @since V1.0.0
     */
    setType(type: number): void;
    /**
     * 设置距离测量起点数据集合,建议不超过100个坐标
     * @param origins 起点数据集合，优先级高于{@link #addOrigins(LatLonPoint...)}
     *                调用此接口会覆盖 {@link #addOrigins(LatLonPoint...)}添加的内容
     * @since V1.0.0
     */
    setOrigins(origins: ArrayList<LatLonPoint>): void;
    /**
     * 设置距离测量起点数据集合,建议不超过s100个坐标
     * 和{@link #setOrigins(List)} 不同，不需要自行创建集合对象
     * 如果已经调用了{@link #setOrigins(List)}，再次调用此方法，之前的内容也会被保留
     * @param origins 起点数据
     * @since V1.0.0
     */
    addOrigins(origins: ArrayList<LatLonPoint>): void;
    /**
     * 设置距离测量终点，和起点不同终点仅支持一个坐标
     * @param destination 终点坐标
     * @since V1.0.0
     */
    setDestination(destination: LatLonPoint | undefined): void;
    /**
     * 扩展字段 base表示只返回基础数据，all表示所有数据 ，默认 base
     * @since V1.0.0
     */
    getExtensions(): string;
    /**
     * 扩展字段 base表示只返回基础数据，all表示所有数据 ，默认 base
     * @since V1.0.0
     */
    setExtensions(extensions: string): void;
    /**
     * 驾车距离测量模式， 默认是4, 参加驾车路径规划策略模式
     * @since V1.0.0
     */
    getMode(): number;
    /**
     * 驾车距离测量模式， 默认是4， 参加驾车路径规划策略模式
     * @param mMode 驾车模式
     * @since V1.0.0
     */
    setMode(d74: number): void;
}
/**
 * 距离测量异步请求回调。
 *
 * @since V1.0.0
 */
export interface OnDistanceSearchListener {
    /**
     * 返回距离测量搜索异步处理结果
     * @param distanceResult 距离测量结果
     * @param errorCode 返回结果成功或者失败的响应码。1000为成功，其他为失败（详细信息参见网站开发指南-错误码对照表）。
     * @since V1.0.0
     */
    onDistanceSearched: (distanceResult: DistanceResult, errorCode: number) => void;
}
