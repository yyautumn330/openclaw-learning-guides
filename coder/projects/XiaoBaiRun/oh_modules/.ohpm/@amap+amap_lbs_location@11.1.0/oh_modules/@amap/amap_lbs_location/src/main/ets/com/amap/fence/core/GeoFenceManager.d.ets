// @keepTs
// @ts-nocheck
import { GeoFence } from "../GeoFence";
import ArrayList from "@ohos.util.ArrayList";
import HashMap from "@ohos.util.HashMap";
import { DPoint } from "../../location/DPoint";
import { GeoFenceListener } from "../GeoFenceListener";
import { AMapLocation } from "../../location/AMapLocation";
import { AMapLocationClientOption } from "../../location/AMapLocationClientOption";
export declare class t1 {
    static readonly v5: string;
    static readonly w5: string;
    static readonly x5: string;
    /**
     * 通过关键字搜索创建地理围栏的默认围栏半径，单位：米
     * <p>
     * 目前暂定为1000米
     * </p>
     *
     * @since 3.2.0
     */
    static readonly y5: number;
    /**
     * 通过周边搜创建地理围栏的默认围栏半径，单位：米
     * <p>
     * 目前暂定为200米
     * </p>
     *
     * @since 3.2.0
     */
    static readonly z5: number;
    /**
     * 添加圆形地理围栏
     *
     * @since 3.2.0
     */
    static readonly a6: number;
    /**
     * 添加多边形地理围栏
     *
     * @since 3.2.0
     */
    static readonly b6: number;
    /**
     * 通过关键字搜索添加地理围栏
     *
     * @since 3.2.0
     */
    static readonly c6: number;
    /**
     * 通过周边搜索添加地理围栏
     *
     * @since 3.2.0
     */
    static readonly d6: number;
    /**
     * 添加行政区划围栏
     *
     * @since 3.2.0
     */
    static readonly e6: number;
    /**
     * 检查定位策略，根据位置与边界的距离改变
     *
     * @since 3.2.0
     */
    static readonly f6: number;
    /**
     * 检查地理围栏，判断当前位置是否在围栏内， 如果不在围栏内根据距离改变定位策略
     *
     * @since 3.2.0
     */
    static readonly g6: number;
    /**
     * 启动单次定位
     *
     * @since 3.2.0
     */
    static readonly h6: number;
    /**
     * 启动持续定位
     *
     * @since 3.2.0
     */
    static readonly i6: number;
    /**
     * 设置触发围栏Action
     *
     * @since 3.2.0
     */
    static readonly j6: number;
    /**
     * 销毁
     * @since 3.4.0
     */
    static readonly k6: number;
    static readonly l6: number;
    /**
     * 设置围栏是否可用
     * @since 3.6.0
     */
    static readonly m6: number;
    /**
     * 暂停地理围栏
     * @since 3.6.0
     */
    static readonly n6: number;
    /**
     * 添加地理围栏完成
     *
     * @since 3.2.0
     */
    static readonly o6 = 1000;
    /**
     * 提醒触发地理围栏
     */
    static readonly p6: number;
    /**
     * 提醒定位失败
     * @since 3.3.0
     */
    static readonly q6: number;
    /**
     * 上次位置的有效时间，目前暂定为10秒
     */
    static readonly r6: number;
    /**
     * 传送触发条件Bundle的key值
     */
    static readonly s6: string;
    /**
     *  Bundle key -- 中心点
     * @since 4.1.0
     */
    static readonly t6: string;
    /**
     * Bundle key -- 多边形中的点列表
     * @since 4.1.0
     */
    static readonly u6: string;
    /**
     * Bundle key -- 围栏半径
     * @since 3.3.0
     */
    static readonly v6: string;
    /**
     * Bundle key -- pendingIntent
     * @since 3.3.0
     */
    static readonly w6: string;
    /**
     * Bundle key -- pendingIntentAction
     * @since 4.1.0
     */
    static readonly x6: string;
    /**
     * Bundle key -- 超时时间
     * @since 4.1.0
     */
    static readonly y6: string;
    /**
     * Bundle key -- 关键字
     * @since 4.1.0
     */
    static readonly z6: string;
    /**
     * Bundle key -- poi类型
     * @since 4.1.0
     */
    static readonly a7: string;
    /**
     * Bundle key -- 搜索的周边半径
     * @since 4.1.0
     */
    static readonly b7: string;
    /**
     * Bundle key -- 搜索限定的城市
     * @since 4.1.0
     */
    static readonly c7: string;
    /**
     * Bundle key -- 搜索时的最大数量
     * @since 4.1.0
     */
    static readonly d7: string;
    /**
     * Bundle key -- 自定义业务ID
     * @since 3.3.0
     */
    static readonly e7: string;
    /**
     * Bundle key -- 添加结果列表
     * @since 3.3.0
     */
    static readonly f7: string;
    /**
     * Bundle key -- 错误码
     * @since 3.3.0
     */
    static readonly g7: string;
    /**
     * Bundle key -- 围栏ID
     * @since 3.6.0
     */
    static readonly h7: string;
    /**
     * Bundle key -- 围栏是否有效(able)
     * @since 3.6.0
     */
    static readonly i7: string;
    /**
     * Bundle key -- 围栏对象
     * @since 3.6.0
     */
    static readonly j7: string;
    private mContext?;
    private k7?;
    private l7?;
    private m7;
    /**
     * 触发地理围栏的条件
     */
    private n7;
    private static readonly o7;
    /**
     * 围栏列表
     */
    p7?: ArrayList<GeoFence>;
    private q7;
    private r7;
    /**
     * 是否已经启动了连续定位
     */
    private s7;
    /**
     * 是否已经进行过初始化
     * @since 3.3.0
     */
    private t7;
    private u7;
    private v7?;
    private w7;
    private x7?;
    private y7?;
    private z7;
    private a8?;
    private static readonly b8;
    private static c8;
    private static readonly d8;
    private static readonly e8;
    private static readonly f8;
    private static readonly g8;
    private static readonly h8;
    private static readonly i8;
    private static readonly j8;
    private static readonly k8;
    /**
     * 默认的搜索半径
     */
    private static readonly l8;
    /**
     * 通过搜索添加地理围栏-关键字
     */
    static readonly m8: number;
    /**
     * 通过搜索添加地理围栏-周边
     */
    static readonly n8: number;
    /**
     * 行政区划
     */
    static readonly o8: number;
    private static readonly p8;
    private static readonly q8;
    private static readonly r8;
    private static readonly s8;
    private static readonly t8;
    private static readonly u8;
    private static readonly v8;
    private static readonly w8;
    private static readonly x8;
    /**
     * 定位失败的次数
     */
    private y8;
    /**
     * 判断是否停留在围栏内的时间，目前暂定为10分钟
     * @since 3.2.0
     */
    static readonly z8: number;
    private a9;
    private readonly b9;
    /**
     * 是否已经暂停
     * @since 3.6.0
     */
    private isPause;
    /**
     * 主线程Handler，用于回调和结果的返回
     */
    private c9;
    /**
     * 子线程Handler， 用于动作执行
     */
    private h9;
    constructor(context: Context);
    /**
     * 初始化
     */
    private init;
    /**
     * 设置触发条件
     *
     * @param activateAction
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    setActivateAction(s5: number): void;
    /**
     * 执行设置围栏触发条件
     *
     * @param bundle
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    q9(bundle: HashMap<string, ESObject> | undefined): void;
    /**
     * 设置围栏监听
     *
     * @param geoFenceListener
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    setGeoFenceListener(q5: GeoFenceListener): void;
    setLocationClientOption(option: AMapLocationClientOption): void;
    /**
     * 添加圆形地理围栏
     * <p>
     * 3.3.0进行了修改，增加3个参数，为了支持旧版地理围栏
     * </p>
     * @param point 中心点坐标
     * @param radius 地理围栏半径
     * @param customId 业务ID
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    addRoundGeoFence(point: DPoint, radius: number, customId: string): void;
    /**
     * 执行添加圆形围栏
     *
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    private i9;
    /**
     * 添加多边形围栏
     *
     * @param points
     *            边界点
     * @param customId
     *            业务ID
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    addPolygonGeoFence(points: ArrayList<DPoint>, customId: string): void;
    /**
     * 执行添加多边形围栏
     *
     * @param bundle
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    private j9;
    /**
     * 圆形或者多边形的GeoFence
     *
     * @param bundle
     * @param isPolygon
     *            是否多边形
     * @return
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    private g10;
    /**
     * 通过周边搜，添加地理围栏
     *
     * @param keyword
     *            关键字
     * @param poiType
     *            poi类型
     * @param point
     *            中心点坐标
     * @param aroundRadius
     *            搜索半径
     * @param size
     *            最大数量
     * @param customId
     *            业务ID
     * @since 3.2.0
     * @author hongming.wang
     */
    addNearbyGeoFence(d5: string, poiType: string, point: DPoint, e5: number, size: number, customId: string): void;
    /**
     * 执行周边搜添加围栏
     *
     * @param bundle
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    private l9;
    /**
     * 按照关键字搜索然后创建地理围栏
     *
     * @param keyword
     *            关键字
     * @param poiType
     *            poi类型
     * @param city
     *            城市
     * @param size
     *            最大数量
     * @param customId
     *            业务ID
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    addKeywordGeoFence(c5: string, poiType: string, city: string, size: number, customId: string): void;
    /**
     * 执行关键字搜索添加围栏
     *
     * @param bundle
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    private k9;
    /**
     * 添加行政区划地理围栏
     *
     * @param keyword
     *            关键字
     * @param customId
     *            业务ID
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    addDistrictGeoFence(b5: string, customId: string): void;
    /**
     * 执行添加行政区划围栏
     *
     * @param bundle
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    private m9;
    /**
     * 检查参数是否正确
     * @param fenceType
     * @param keyWord
     * @param poiType
     * @param centerPoint
     * @return
     */
    private w10;
    /**
     * 执行搜索并添加地理围栏
     * @param fenceType 要添加的围栏类型
     * @param bundle
     */
    private v10;
    /**
     * 移除地理围栏
     *
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    removeGeoFence(): void;
    /**
     * 移除指定的地理围栏
     * @param geoFence
     * @return 是否移除成功
     * @since 3.3.0
     * @author liqi
     */
    removeSpecifyGeoFence(p4: GeoFence): boolean;
    /**
     * 设置围栏是否生效
     * @param fenceId 地理围栏的ID
     * @param able 是否生效，true:生效；false:不生效, 默认：true
     * @since 3.6.0
     * @author hongming.wang
     */
    setGeoFenceAble(n4: string, o4: boolean): void;
    /**
     * 设置围栏是否生效
     * @param bundle
     */
    private t9;
    /**
     * 是否所有的围栏的able都是false
     * @return
     * @since 3.6.0
     */
    private j11;
    getAllGeoFence(): ArrayList<GeoFence>;
    private s9;
    private r9;
    /**
     * 销毁resultHandler
     *
     * @since 3.6.0
     * @author hongming.wang
     *
     */
    private o11;
    /**
     * 将地理围栏添加到列表中
     *
     * @param geoFence
     * @return 错误码
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    private h10;
    /**
     * 将多个围栏添加到围栏列表
     *
     * @param fences
     * @return
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    private e11;
    /**
     * 发送actionHandler消息
     *
     * @param msgWhat
     *            消息码(msg.what)
     * @param bundle
     *            消息内容(msg.data)
     * @param delayMillis
     *            延迟时间
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    private w9;
    /**
     * 移除actionHandler消息
     *
     * @param msgWhat
     *            消息码(msg.what)
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    private r11;
    /**
     * 销毁actionHandler
     *
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    private l11;
    /**
     * 发送创建围栏完成消息
     *
     * @param msgWhat
     *            消息码(msg.what)
     * @param bundle
     *            消息内容(msg.data)
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    private i10;
    /**
     * 添加围栏成功
     *
     * @param bundle
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    private d9;
    /**
     * 进行一次单次定位，检测当前位置和围栏的距离，改变围栏策略
     * @since 3.6.0
     */
    private z9;
    /**
     * 创建pendingIntetnt的bundle
     * @param fence 围栏对象
     * @param fenceId 围栏ID（自动生成）
     * @param customId 自定义的业务ID(用户传入)
     * @param fenceStatus 围栏状态
     * @param locErrorCode 定位错误码
     * @return
     * @since 3.3.0
     * @author hongming.wang
     *
     */
    private t11;
    /**
     * 提醒定位失败
     * @param locationErrorcode 定位错误码
     * @since 3.3.0
     * @author hongming.wang
     *
     */
    private g9;
    /**
     * 广播围栏提醒
     *
     * @param geoFence
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    private e9;
    /**
     * 检查围栏
     *
     * @param loc
     *            定位位置
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    doCheckFence(p3: AMapLocation | undefined): void;
    /**
     * 提醒围栏状态
     *
     * @param fence
     *            围栏对象
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    private x11;
    /**
     * 启动单次定位
     *
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    private o9;
    /**
     * 停止连续定位
     *
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    private y11;
    /**
     * 启动连续定位
     *
     * @param bundle
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    private p9;
    /**
     * 判断上次位置是否可用
     *
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    private s11;
    /**
     * 根据定位位置和地理围栏边界的距离，改变定位策略
     *
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    private n9;
    /**
     * 获取多边形的中心点坐标
     *
     * @param pointList
     *            多边形的坐标数据
     * @return 多边形的中心点坐标
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    private k10;
    /**
     * 计算当前的定位点与最近的围栏的边界距离
     *
     * @param curLoc
     *            当前的定位点
     * @param fenceList
     *            围栏列表
     * @return 当前的定位点与地理围栏列表中最近的中心点的距离
     *         <p>
     *         返回Float.MAX_VALUE代表无效
     *         </p>
     * @since 3.2.0
     * @author hongming.wang
     */
    private a12;
    /**
     * 获取多边形的最小半径
     *
     * @param centerPoint
     *            多边形的中心点
     * @param pointList
     *            多边形的点
     * @return 多边形的最小半径
     *         <p>
     *         Float.MAX_VALUE代表无效
     *         </p>
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    static o10(centerPoint: DPoint, z2: ArrayList<DPoint>): number;
    /**
     * 获取过变形的最大半径
     * @param centerPoint 多边形的中心点坐标
     * @param pointList 多边形的点
     * @return 变形的最大半径
     * <p>
     * Float.MIN_VALUE代表无效
     * </p>
     * @since 3.2.0
     * @author hongming.wang
     */
    static m10(centerPoint: DPoint, v2: ArrayList<DPoint>): number;
    static e12(centerPoint: DPoint, r2: DPoint[], s2: GeoFence): void;
    /**
     * 判断坐标点是否在圆形围栏内
     *
     * @param location
     *            定位点
     * @param centerPoint
     *            围栏设置的中心点坐标
     * @param fenceRadius
     *            围栏半径
     * @return 是否在圆形围栏内 true:在，false：不在
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    private f12;
    /**
     * 判断坐标点是否在多边形围栏内
     *
     * @param location
     * @param points
     * @return 是否在多边形围栏内 true:在，false：不在
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    private g12;
    /**
     * 判断是否在地理围栏内
     *
     * @param location
     * @param fence
     * @return
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    private i12;
    /**
     * 检查地理围栏状态是否改变了
     * @param currentLocation 当前位置
     * @param fence 地理围栏对象
     * @return 状态是否改变了, true:状态改变了
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    private u11;
    /**
     * 判断是否进行围栏提醒
     * @param fence 地理围栏对象
     * @param activatesAction 用户设定的触发提醒条件
     * @return
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    private v11;
    /**
     * 获取添加围栏的错误码
     * @param fenceErrorCode
     * @return
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    private f11;
    /**
     * 打印错误信息
     * @param title
     * @param errorCode
     * @param errorInfo
     * @param errDetails
     * @since 3.3.0
     * @author hongming.wang
     *
     */
    private f10;
    /**
     * 暂停地理围栏
     * <p>
     *     暂停地理围栏的检测、提醒、同时地理围栏内部的定位也会停止
     * </p>
     * @since 3.6.0
     * @author hongming.wang
     */
    pauseGeoFence(): void;
    private u9;
    /**
     * 恢复地理围栏
     * <p>
     *     恢复地理围栏的检测、提醒、同时地理围栏内部的定位也会重新开始定位
     * </p>
     * @since 3.6.0
     * @author hongming.wang
     */
    resumeGeoFence(): void;
    /**
     * 地理围栏是否已经暂停
     *
     * @return 地理围栏是否处于暂停状态
     * @author hongming.wang
     * @since 3.6.0
     */
    p12(): boolean;
    /**
     * 实现比较
     * @param array
     * @param item
     * @param compareFn
     * @returns
     */
    p11(array: ArrayList<GeoFence>, u1: GeoFence): boolean;
}
