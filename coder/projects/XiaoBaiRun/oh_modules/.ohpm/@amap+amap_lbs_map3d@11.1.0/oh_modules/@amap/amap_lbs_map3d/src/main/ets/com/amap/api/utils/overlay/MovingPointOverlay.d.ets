// @keepTs
// @ts-nocheck
import { AMap } from "../../AMap";
import ArrayList from "@ohos.util.ArrayList";
import LinkedList from "@ohos.util.LinkedList";
import { LatLng } from "../../model/LatLng";
import { BasePointOverlay } from "../../model/BasePointOverlay";
import taskpool from "@ohos.taskpool";
/**
 * 平滑移动时返回剩余距离接口
 *
 * @since V6.3.1
 */
export interface MoveListener {
    /**
     * 返回 距离终点的距离
     *
     * @param distance 单位 米
     * @since V6.3.1
     */
    move: (distance: number) => void;
}
/**
 * 按照指定的经纬度数据和时间，平滑移动
 *
 * @author xudong.tang
 * @since V6.3.1
 */
export declare class MovingPointOverlay {
    private m51;
    /**
     * Marker位置
     **/
    private n51;
    /**
     * 每段点的队列，第一个点为起点
     **/
    points: LinkedList<LatLng>;
    /**
     * 每段距离队列  大小为points.size() - 1
     **/
    o51: LinkedList<number>;
    private p51;
    private static TAG;
    private q51;
    private r51;
    /**
     * 根据给定的参数来构造SmoothMoveMarker对象。
     *
     * @param mAMap 地图AMap对象
     * @since V6.3.1
     */
    constructor(k50: AMap, overlay: BasePointOverlay);
    task: taskpool.LongTask;
    /**
     * 设置平滑移动的经纬度数组
     *
     * @param points 平滑移动轨迹的坐标数组
     * @since V6.3.1
     */
    setPoints(points: ArrayList<LatLng>): void;
    /**
     * 点更新后需要恢复成初始状态。
     */
    private reset;
    s51(): void;
    /**
     * 设置平滑移动的总时间
     *
     * @param duration 单位: 秒
     * @since V6.3.1
     */
    setTotalDuration(duration: number): void;
    /**
     * 开始平滑移动
     *
     * @since V6.3.1
     */
    startSmoothMove(): void;
    /**
     * 停止平滑移动
     *
     * @since V6.3.1
     */
    stopMove(): void;
    /**
     * 获取当前移动的Marker
     *
     * @return 放回当期那移动的Marker
     * @since V6.3.1
     */
    getObject(): BasePointOverlay | undefined;
    /**
     * 获取当前位置坐标
     *
     * @return 返回当前Marker的坐标
     * @since V6.3.1
     */
    getPosition(): LatLng | undefined;
    /**
     * 获取某段索引
     *
     * @return 返回某段索引
     * @exclude javadoc中不显示 用户暂时不需要
     */
    getIndex(): number;
    /**
     * 停止滑动并销毁Marker
     *
     * @since V6.3.1
     */
    destroy(): void;
    /**
     * @exclude javadoc中不显示
     */
    u51(): void;
    /**
     * @exclude javadoc中不显示
     */
    setPosition(position: LatLng): void;
    /**
     * 设置Marker 角度
     *
     * @exclude javadoc中不显示 咱不提供给用户，设置角度有问题
     */
    setRotate(rotate: number): void;
    /**
     * 设置 Marker 是否可见
     *
     * @param b true 可见  false  不可见
     * @since V6.3.1
     */
    setVisible(b: boolean): void;
    /**
     * 设置Marker移动的回调方法
     *
     * @param moveListener 回调监听参数
     * @since V6.3.1
     */
    setMoveListener(f50: MoveListener | undefined): void;
    private t51;
}
