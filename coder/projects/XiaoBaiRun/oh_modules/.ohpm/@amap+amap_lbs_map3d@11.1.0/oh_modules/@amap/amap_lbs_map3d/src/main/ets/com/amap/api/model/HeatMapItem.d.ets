// @keepTs
// @ts-nocheck
/**
 *
 * 热力图聚合点信息
 * @author qsh
 * @data 2025/10/20
 *
 * @since 2.2.5
 */
import { LatLng } from "./LatLng";
export declare class HeatMapItem {
    /**
     * 热力中心点坐标
     */
    private center?;
    /**
     * 当前热力值
     */
    private intensity;
    /**
     * 当前包含的数据索引
     */
    private indexes;
    /**
     * 当前蜂窝或者网格中心点
     * @since 2.2.5
     */
    getCenter(): LatLng;
    /**
     *
     * @since 2.2.5
     */
    setCenter(b29: number, c29: number): void;
    /**
     * 获取当前热力值，当前蜂窝或者网格的热力值
     * @return
     * @since 2.2.5
     */
    getIntensity(): number;
    /**
     *
     * @param intensity
     * @since 2.2.5
     */
    setIntensity(intensity: number): void;
    /**
     * 获取当前蜂窝或者网格包含数据的索引
     * @return
     * @since 2.2.5
     */
    getIndexes(): number[];
    /**
     *
     */
    setIndexes(indexes: Array<number>): void;
}
