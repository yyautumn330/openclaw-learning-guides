// @keepTs
// @ts-nocheck
import { d16 } from '../../mapcore/interface/IGLOverlayLayer';
import { ArcOptions } from "./ArcOptions";
import { BaseOverlay } from "./BaseOverlay";
export declare class Arc extends BaseOverlay {
    private options;
    private glOverlayLayer;
    /**
     * @internal
     */
    constructor(w21: d16, options: ArcOptions, x21: string);
    /**
     * 删除从地图对象里圆弧
     *
     * @since 2.2.3
     */
    remove(): void;
    /**
     * 返回弧形的 Id。Id 是覆盖物在所属的地图对象里的唯一标识。
     *
     * @return 弧形的 Id。
     * @since 2.2.3
     */
    getId(): string | undefined;
    /**
     * 设置弧形的边框宽度，单位像素。参数必须大于等于0。如果为0则不会绘制边框。默认为10。
     *
     * @param width 边框宽度，单位像素
     * @throw IllegalArgumentException 如果宽度为负数
     * @since 2.2.3
     */
    setStrokeWidth(width: number): void;
    /**
     * 返回弧形的边框宽度
     *
     * @return 形边框宽度，单位像素。
     * @since 2.2.3
     */
    getStrokeWidth(): number;
    /**
     * 设置弧形的边框颜色。
     *
     * @param color 边框颜色，ARGB格式
     * @since 2.2.3
     */
    setStrokeColor(color: number): void;
    /**
     * 返回弧形的边框颜色
     *
     * @return 边框颜色，ARGB格式。
     * @since 2.2.3
     */
    getStrokeColor(): number;
    /**
     * 设置弧形Z轴数值。设置圆弧的Z轴数值。数值更高的多边形将绘制在数值较低的上面。
     *
     * @param zIndex Z轴数值。
     * @since 2.2.3
     */
    setZIndex(zIndex: number): void;
    /**
     * 返回圆弧Z轴数值
     *
     * @return 圆弧Z轴数值
     * @since 2.2.3
     */
    getZIndex(): number;
    /**
     * 设置弧形的可见属性。当不可见时，弧形将不会被绘制。默认值为 true。
     *
     * @param visible true为可见；false不可见。
     * @since 2.2.3
     */
    setVisible(visible: boolean): void;
    /**
     * 返回圆弧是否可见
     *
     * @return True为圆弧可见，false为不可见。
     * @since V2.0
     */
    isVisible(): boolean;
    /**
     * @internal
     * @param paramObject
     * @returns
     */
    equals(v21: Object): boolean;
    /**
     * @internal
     */
    private updateOption;
}
