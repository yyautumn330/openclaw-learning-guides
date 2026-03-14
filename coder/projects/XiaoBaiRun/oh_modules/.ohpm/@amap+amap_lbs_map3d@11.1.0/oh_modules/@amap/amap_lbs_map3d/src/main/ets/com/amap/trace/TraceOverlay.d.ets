// @keepTs
// @ts-nocheck
import ArrayList from "@ohos.util.ArrayList";
import { AMap } from '../api/AMap';
import { LatLng } from '../api/model/LatLng';
/**
 * 用于绘制轨迹纠偏接口回调的一条平滑轨迹
 * @author zxy
 * @since 2.2.5
 */
export declare class TraceOverlay {
    private y292?;
    private mContext?;
    private z292?;
    private m51;
    private a293;
    /**
     * 描述轨迹绘制状态，绘制过程中
     * @since 2.2.5
     */
    static readonly TRACE_STATUS_PROCESSING: number;
    /**
     * 描述轨迹绘制状态，绘制完成
     * @since 2.2.5
     */
    static readonly TRACE_STATUS_FINISH: number;
    /**
     * 描述轨迹绘制状态，失败
     * @since 2.2.5
     */
    static readonly TRACE_STATUS_FAILURE: number;
    /**
     * 描述轨迹绘制状态，准备（默认状态）
     * @since 2.2.5
     */
    static readonly TRACE_STATUS_PREPARE: number;
    private b293;
    private c293;
    private d293;
    /**
     * 构造方法
     *
     * @param amap
     *            AMap对象
     * @param lines
     *            一条轨迹或一条轨迹第一段
     * @since 2.2.5
     */
    constructor(x292: AMap, lines?: ArrayList<LatLng>, context?: Context);
    /**
     * 添加轨迹回调的一段，需要按照index顺序添加才能正常绘制
     *
     * @param segments 一段经纬度信息
     * @since 2.2.5
     */
    add(segments: ArrayList<LatLng>): void;
    /**
     * 移除一条轨迹线路
     * @since 2.2.5
     */
    remove(): void;
    /**
     * 根据传入的点集合设置合适的Camera
     *
     * @param lists
     *            点集合
     * @since 2.2.5
     */
    setProperCamera(u292: ArrayList<LatLng> | undefined): void;
    /**
     * 设置当前合适显示Camera
     * @since 2.2.5
     */
    zoopToSpan(): void;
    private options;
    /**
     * 获取轨迹绘制状态
     *
     * @return 返回轨迹绘制状态
     * @since 2.2.5
     */
    getTraceStatus(): number;
    /**
     * 设置轨迹绘制状态
     *
     * @param mTraceStatus 设置轨迹绘制状态
     * @since 2.2.5
     */
    setTraceStatus(s292: number): void;
    /**
     * 获取线路行驶距离
     *
     * @return 返回线路行驶距离
     * @since 2.2.5
     */
    getDistance(): number;
    /**
     * 设置线路行驶距离
     *
     * @param mDistance
     *            线路行驶距离
     * @since 2.2.5
     */
    setDistance(r292: number): void;
    /**
     * 获取线路停车时间
     *
     * @return 停车时间
     * @since 2.2.5
     */
    getWaitTime(): number;
    /**
     * 设置线路停车时间
     *
     * @param mWaitTime
     *            线路停车时间
     * @since 2.2.5
     */
    setWaitTime(q292: number): void;
}
