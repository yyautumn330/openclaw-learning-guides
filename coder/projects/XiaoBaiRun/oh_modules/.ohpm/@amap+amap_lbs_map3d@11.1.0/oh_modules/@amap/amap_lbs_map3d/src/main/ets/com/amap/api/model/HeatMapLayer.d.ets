// @keepTs
// @ts-nocheck
import { d16 } from "../../mapcore/interface/IGLOverlayLayer";
import { BaseOverlay } from "./BaseOverlay";
import { HeatMapItem } from "./HeatMapItem";
import { HeatMapLayerOptions } from "./HeatMapLayerOptions";
import { LatLng } from "./LatLng";
/**
 * 热力图图层
 * @author qsh
 * @data 2025/10/9
 *
 * @since 2.2.5
 */
export declare class HeatMapLayer extends BaseOverlay {
    private options;
    private glOverlayLayerRef;
    /**
     *  @exclude javadoc中不显示
     */
    constructor(g29: d16, options: HeatMapLayerOptions, h29: string);
    /**
     * 从地图上删除图层
     *
     * @since 2.2.5
     */
    destroy(): void;
    /**
     * 获取图层的Id
     *
     * @return 图层的Id
     * @since 2.2.5
     */
    getId(): string;
    /**
     * 设置图层的Z轴值
     *
     * @param zIndex Z轴值
     * @since 7.0.0
     */
    setZIndex(zIndex: number): void;
    /**
     * 获取图层的Z轴值
     *
     * @return 图层的Z轴值
     * @since 7.0.0
     */
    getZIndex(): number;
    /**
     * 设置图层可见属性
     *
     * @param visible true: 可见；false: 不可见
     * @since 7.0.0
     */
    setVisible(visible: boolean): void;
    /**
     * 获取图层是否可见。
     *
     * @return true: 可见；false: 不可见
     * @since 7.0.0
     */
    isVisible(): boolean;
    /**
     *
     * @param o
     * @return
     */
    equals(f29: object | HeatMapItem): boolean;
    /**
     * 根据经纬度获取当前的热力信息
     * @param latLng 经纬度
     * @return 如果没有找到时返回null
     * @since 7.0.0
     */
    getHeatMapItem(latLng: LatLng): HeatMapItem;
    /**
     * 获取热力图属性，如果初始化传入的null 则返回也是null
     * @since 7.0.0
     */
    getOptions(): HeatMapLayerOptions;
    /**
     * 更新热力图属性
     * 更新时会重新计算热力图数据，建议不要频繁更新
     * @since 7.0.0
     */
    setOptions(options: HeatMapLayerOptions): void;
    private updateOption;
}
