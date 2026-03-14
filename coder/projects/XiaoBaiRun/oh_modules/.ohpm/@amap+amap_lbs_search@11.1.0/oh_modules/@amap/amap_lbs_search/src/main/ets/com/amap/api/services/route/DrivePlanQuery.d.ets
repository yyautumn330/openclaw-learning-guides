// @keepTs
// @ts-nocheck
import { FromAndTo } from "./FromAndTo";
export declare class DrivePlanQuery {
    private p75;
    private q75?;
    private mode;
    private r75;
    private s75;
    private interval;
    private count;
    /**
     * DriveRouteQuery构造函数。
     *
     * @param fromAndTo             路径的起点终点。
     * @param firstTime             出发时间，第一个时间戳（unix时间戳，精确到秒)。
     * @param interval              规划的时间间隔，单位为秒。
     * @param count                 规划时间点个数，最大48个。
     * @since V6.9.0
     */
    constructor(n75: FromAndTo, o75: number, interval: number, count: number);
    /**
     * 返回查询路径的起终点。
     *
     * @return 查询路径的起终点。
     * @since V6.9.0
     */
    getFromAndTo(): FromAndTo;
    /**
     * 返回查询路径终点父POI的ID。
     *
     * @return 查询路径终点父POI的ID。
     * @since V6.9.0
     */
    getDestParentPoiID(): string;
    /**
     * 返回计算路径的模式。
     *
     * @return 计算路径的模式。
     * @since V6.9.0
     */
    getMode(): number;
    /**
     * 返回汽车类型
     *
     * @return 汽车类型。
     * @since V6.9.0
     */
    getCarType(): number;
    /**
     * 返回第一次规划的时间
     *
     * @return 第一次规划时间，unix时间戳，精确到秒。
     * @since V6.9.0
     */
    getFirstTime(): number;
    /**
     * 返回规划的时间间隔
     *
     * @return 规划的时间间隔，单位为秒。
     * @since V6.9.0
     */
    getInterval(): number;
    /**
     * 返回规划的时间点个数
     *
     * @return 规划的时间点个数。
     * @since V6.9.0
     */
    getCount(): number;
    /**
     * @exclude javadoc中不显示。
     */
    clone(): DrivePlanQuery;
    /**
     * 设置终点的父POIID，无父POI的情况留空即可
     *
     * @param destParentPoiID 终点的父POIID, 可以提升终点抓路的准确性。如果已知父POI的ID，可以传入，无父POI的情况留空即可。
     * @since 6.9.0
     */
    setDestParentPoiID(m75: string | undefined): void;
    /**
     * 设置规划策略模式，默认为普通汽车
     *
     * @param mode 规划策略模式，可选，默认为速度优先 {@link RouteSearch#DRIVEING_PLAN_DEFAULT}
     * @since 6.9.0
     */
    setMode(mode: number): void;
    /**
     * 设置车辆类型，默认为普通汽车
     *
     * @param carType 车辆类型,支持0：普通汽车，1：纯电动车，2：插电混动车
     * @since 6.9.0
     */
    setCarType(l75: number): void;
}
