// @keepTs
// @ts-nocheck
import { LatLonPoint } from "../core/LatLonPoint";
/**
 * 定义了公交换乘路径规划的一个换乘点的出入口信息。换乘点目前指换乘地铁。
 * @since V2.1.0
 */
export declare class Doorway {
    private n74?;
    private z65?;
    /**
     * 返回公交换乘中换乘点的出（入）口名称 。
     * @return 公交换乘中换乘点的出（入）口名称 。
     * @since V2.1.0
     */
    getName(): string;
    /**
     * 设置公交换乘中换乘点的出（入）口名称。
     * @param mName 公交换乘中换乘点的出（入）口名称。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    setName(m74: string): void;
    /**
     * 返回公交换乘中换乘点的出（入）口坐标。
     * @return 公交换乘中换乘点的出（入）口坐标。
     * @since V2.1.0
     */
    getLatLonPoint(): LatLonPoint;
    /**
     * 设置公交换乘中换乘点的出（入）口坐标。
     * @param mLatLonPoint 公交换乘中换乘点的出（入）口坐标。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    setLatLonPoint(l74: LatLonPoint): void;
    /**
     * @exclude javadoc中不显示。
     */
    q2(): number;
    /**
     * Doorway的构造方法。
     * @since V2.1.0
     * @exclude javadoc中不显示。
     */
    constructor();
}
