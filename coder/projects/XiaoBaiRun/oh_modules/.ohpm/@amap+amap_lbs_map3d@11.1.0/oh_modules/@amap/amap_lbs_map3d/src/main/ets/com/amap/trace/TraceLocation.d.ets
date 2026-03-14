// @keepTs
// @ts-nocheck
/**
 * 用于轨迹纠偏的一个点的信息，目前该点需要：经度、纬度、速度、方向角（和gps返回一致）、定位时间
 *
 * @author zxy
 * @since 2.2.5
 */
export declare class TraceLocation {
    private mLatitude;
    private m292;
    private n292;
    private o292;
    private b284;
    /**
     * 构造方法
     *
     * @param latitude
     *            纬度
     * @param longitude
     *            经度
     * @param speed
     *            速度 单位m/s
     * @param bearing
     *            方向角 单位:度
     * @param time
     *            定位时间
     *  @since 2.2.5
     */
    constructor(latitude?: number, longitude?: number, speed?: number, bearing?: number, time?: number);
    getLatitude(): number;
    /**
     * 设置纬度
     *
     * @param mLatitude
     *            纬度
     *  @since 2.2.5
     */
    setLatitude(l292: number): void;
    /**
     * 获取经度
     *
     * @return 经度
     *  @since 2.2.5
     */
    getLongitude(): number;
    /**
     * 设置经度
     *
     * @param mLongitude
     *            经度
     *  @since 2.2.5
     */
    setLongitude(k292: number): void;
    /**
     * 获取速度
     *
     * @return 速度 单位m/s
     * @since 2.2.5
     */
    getSpeed(): number;
    /**
     * 设置速度
     *
     * @param mSpeed
     *            速度 单位m/s
     * @since 2.2.5
     */
    setSpeed(j292: number): void;
    /**
     * 获取方向角
     *
     * @return 方向角 定义同GPS bearing
     *  @since 2.2.5
     */
    getBearing(): number;
    /**
     * 设置方向角
     *
     * @param mBearing
     *            方向角 定义同GPS bearing
     * @since 2.2.5
     */
    setBearing(i292: number): void;
    /**
     * 获取定位时间
     *
     * @return 定位时间
     * @since 2.2.5
     */
    getTime(): number;
    /**
     * 设置定位时间
     *
     * @param mTime
     *            定位时间
     * @since 2.2.5
     */
    setTime(h292: number): void;
    private static p292;
    /**
     * 复制轨迹纠偏点
     *
     * @return 轨迹纠偏点
     * @since 2.2.5
     */
    copy(): TraceLocation;
    /**
     * @return
     * @exclude javadoc中不显示
     */
    toString(): string;
}
