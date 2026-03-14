// @keepTs
// @ts-nocheck
import { FromAndTo } from "./FromAndTo";
/**
 * 公交线路模式
 */
export declare class w67 {
    /**
     * 推荐模式，综合权重，同高德APP默认
     *
     * @since V9.4.0
     */
    static BUS_DEFAULT: number;
    /**
     * 最经济模式，票价最低
     *
     * @since V9.4.0
     */
    static BUS_SAVE_MONEY: number;
    /**
     * 最少换乘模式，换乘次数少
     *
     * @since V9.4.0
     */
    static BUS_LEASE_CHANGE: number;
    /**
     * 最少步行模式，尽可能减少步行距离
     *
     * @since V9.4.0
     */
    static BUS_LEASE_WALK: number;
    /**
     * 最舒适模式，尽可能乘坐空调车
     *
     * @since V9.4.0
     */
    static BUS_COMFORTABLE: number;
    /**
     * 不乘地铁模式，不乘坐地铁路线
     *
     * @since V9.4.0
     */
    static BUS_NO_SUBWAY: number;
    /**
     *  地铁图模式，起终点都是地铁站
     * （地铁图模式下originpoi及destinationpoi为必填项）
     *
     * @since V9.4.0
     */
    static l68: number;
    /**
     * 地铁优先模式，步行距离不超过4KM
     *
     * @since V9.4.0
     */
    static m68: number;
    /**
     * 时间短模式，方案花费总时间最少
     *
     * @since V9.4.0
     */
    static n68: number;
}
/**
 * 此类定义了公交路径规划查询路径的起终点、计算路径的模式、城市和是否计算夜班车。
 *
 * @since V9.4.0
 */
export declare class BusRouteQueryV2 {
    private s67;
    private t67;
    private o68;
    private p68;
    private q68;
    private r68;
    private v67;
    private s68;
    private t68;
    private u68;
    private v68;
    private w68;
    private x68;
    private y68;
    /**
     * 扩展字段，all表示所有数据 ，默认 cost
     */
    private t65;
    /**
     * BusRouteQuery构造函数。
     *
     * @param fromAndTo 路径的起终点。
     * @param mode      计算路径的模式。可选，默认为最快捷 {@link BusMode}。
     * @param city      城市区号/电话区号。此项不能为空。
     * @param nightFlag 是否计算夜班车，默认为不计算。0：不计算，1：计算。可选。
     * @since V2.1.0
     */
    constructor(j68: FromAndTo, mode: number, city: string, k68: number);
    /**
     * 返回查询路径的起终点。
     *
     * @return 查询路径的起终点。
     * @since V9.4.0
     */
    getFromAndTo(): FromAndTo;
    /**
     * 返回计算路径的模式。
     *
     * @return 计算路径的模式。
     * @since V9.4.0
     */
    getMode(): number;
    /**
     * 返回查询的城市。
     *
     * @return 查询的城市。
     * @since V9.4.0
     */
    getCity(): string;
    /**
     * 返回是否计算夜班车。
     *
     * @return 是否计算夜班车，默认为不计算。0：不计算，1：计算。可选。
     * @since V9.4.0
     */
    getNightFlag(): number;
    /**
     * 返回目的地的城市（跨城公交路径规划）。
     *
     * @return 目的地的城市。
     * @since V9.4.0
     */
    getCityd(): string;
    /**
     * 设置跨城公交规划的目的地城市。
     *
     * @param cityd 目的地城市。跨城公交规划必填参数。可选值：城市名称/citycode
     * @since V9.4.0
     */
    setCityd(i68: string): void;
    /**
     * 扩展字段，all表示所有数据 ，默认 cost {@link ShowFields}
     * @since 9.4.0
     */
    getShowFields(): number;
    /**
     * 扩展字段，all表示所有数据 ，默认 cost {@link ShowFields}
     * @since 9.4.0
     */
    setShowFields(h68: number): void;
    /**
     * 请求日期
     *
     * 例如:2013-10-28
     *
     * @return
     */
    getDate(): string;
    /**
     * 请求日期
     *
     * 例如:2013-10-28
     *
     * @param mDate
     */
    setDate(g68: string): void;
    /**
     * 请求时间
     *
     * 例如:9-54
     *
     * @return
     */
    getTime(): string;
    /**
     * 请求时间
     *
     * 例如:9-54
     *
     * @param mTime
     */
    setTime(f68: string): void;
    /**
     * 起点POI ID
     *
     * 1、起点POI ID与起点经纬度均填写时，服务使用起点 POI ID；
     *
     * 2、该字段必须和目的地 POI ID 成组使用。
     *
     * @return
     */
    getOriginPoiId(): string;
    /**
     * 起点POI ID
     *
     * 1、起点POI ID与起点经纬度均填写时，服务使用起点 POI ID；
     *
     * 2、该字段必须和目的地 POI ID 成组使用。
     *
     *
     * @param mOriginPoiId
     */
    setOriginPoiId(e68: string): void;
    /**
     * 目的地POI ID
     *
     * 1、目的地POI ID与目的地经纬度均填写时，服务使用目的地 POI ID；
     *
     * 2、该字段必须和起点 POI ID 成组使用。
     *
     * @return
     */
    getDestinationPoiId(): string;
    /**
     * 目的地POI ID
     *
     * 1、目的地POI ID与目的地经纬度均填写时，服务使用目的地 POI ID；
     *
     * 2、该字段必须和起点 POI ID 成组使用。
     *
     */
    setDestinationPoiId(d68: string): void;
    /**
     * 起点所在行政区域编码
     *
     * 仅支持adcode，参考行政区域编码表
     *
     * @return
     */
    getAd1(): string;
    /**
     * 起点所在行政区域编码
     *
     * 仅支持adcode，参考行政区域编码表
     *
     * @param mAd1
     */
    setAd1(c68: string): void;
    /**
     * 终点所在行政区域编码
     *
     * 仅支持adcode，参考行政区域编码表
     *
     * @return
     */
    getAd2(): string;
    /**
     * 终点所在行政区域编码
     *
     * 仅支持adcode，参考行政区域编码表
     *
     * @param mAd2
     */
    setAd2(b68: string): void;
    /**
     * 返回方案条数
     *
     * 可传入1-10的阿拉伯数字，代表返回的不同条数。
     *
     * @return
     */
    getAlternativeRoute(): number;
    /**
     * 返回方案条数
     *
     * 可传入1-10的阿拉伯数字，代表返回的不同条数。
     *
     * @param mAlternativeRoute
     */
    setAlternativeRoute(a68: number): void;
    /**
     * 地铁出入口数量
     *
     * 0：只返回一个地铁出入口
     *
     * 1：返回全部地铁出入口
     *
     * @return
     */
    getMultiExport(): number;
    /**
     * 地铁出入口数量
     *
     * 0：只返回一个地铁出入口
     *
     * 1：返回全部地铁出入口
     *
     * @param mMultiExport
     */
    setMultiExport(z67: number): void;
    /**
     * 最大换乘次数
     *
     * 0：直达
     *
     * 1：最多换乘1次
     *
     * 2：最多换乘2次
     *
     * 3：最多换乘3次
     *
     * 4：最多换乘4次
     *
     *
     * @return
     */
    getMaxTrans(): number;
    /**
     * 最大换乘次数
     *
     * 0：直达
     *
     * 1：最多换乘1次
     *
     * 2：最多换乘2次
     *
     * 3：最多换乘3次
     *
     * 4：最多换乘4次
     *
     *
     * @param mMaxTrans
     */
    setMaxTrans(y67: number): void;
    /**
     * @exclude javadoc中不显示。
     */
    clone(): BusRouteQueryV2;
}
