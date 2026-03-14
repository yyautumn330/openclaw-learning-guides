// @keepTs
// @ts-nocheck
import { LatLonPoint } from '../core/LatLonPoint';
import ArrayList from "@ohos.util.ArrayList";
/**
 * 新能源电量消耗信息
 *
 * @exclude javadoc中不显示
 */
export declare class s14 {
    /**
     * 路线消耗总能量，单位：瓦时
     */
    private h79;
    /**
     * 能量耗尽点的导航段steps索引
     */
    private i79;
    /**
     * 能量耗尽点坐标
     */
    private j79?;
    /**
     * 途经点及终点的剩余能量，有符号，按顺序，最后一个是终点，单位：百分之一瓦时
     */
    private k79;
    /**
     * 获取路线消耗总能量，单位：瓦时
     *
     * @return 路线消耗总能量，单位：瓦时
     * @exclude javadoc中不包含
     */
    l79(): number;
    /**
     * 设置路线消耗总能量，单位：瓦时
     *
     * @param consumeEnergy 路线消耗总能量，单位：瓦时
     * @exclude javadoc中不包含
     */
    n36(g79: number): void;
    /**
     * 获取能量耗尽点的导航段steps索引
     *
     * @return 能量耗尽点的导航段steps索引
     * @exclude javadoc中不包含
     */
    m79(): number;
    /**
     * 设置能量耗尽点的导航段steps索引
     *
     * @param runOutStepIndex 能量耗尽点的导航段steps索引
     * @exclude javadoc中不包含
     */
    m36(f79: number): void;
    /**
     * 获取能量耗尽点坐标
     *
     * @return 能量耗尽点坐标
     * @exclude javadoc中不包含
     */
    n79(): LatLonPoint;
    /**
     * 设置能量耗尽点坐标
     *
     * @param runOutPoint 能量耗尽点坐标
     * @exclude javadoc中不包含
     */
    l36(e79: LatLonPoint): void;
    /**
     * 获取途经点及终点的剩余能量，有符号，按顺序，最后一个是终点，单位：百分之一瓦时
     *
     * @return 途经点及终点的剩余能量，有符号，按顺序，最后一个是终点，单位：百分之一瓦时
     * @exclude javadoc中不包含
     */
    o79(): ArrayList<number>;
    /**
     * 设置途经点及终点的剩余能量，有符号，按顺序，最后一个是终点，单位：百分之一瓦时
     *
     * @param leftEnergy 途经点及终点的剩余能量，有符号，按顺序，最后一个是终点，单位：百分之一瓦时
     * @exclude javadoc中不包含
     */
    o36(d79: ArrayList<number>): void;
}
