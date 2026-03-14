// @keepTs
// @ts-nocheck
import { d16 } from '../../mapcore/interface/IGLOverlayLayer';
import { BasePointOverlay } from './BasePointOverlay';
import { GL3DModelOptions } from './GL3DModelOptions';
import { LatLng } from './LatLng';
import { Point } from './Point';
export declare class GL3DModel extends BasePointOverlay {
    private options;
    private glOverlayLayer;
    private object?;
    /**
     * @exclude javadoc中不显示
     */
    constructor(n26: d16, options: GL3DModelOptions, o26: string);
    /**
     * 设置当前模型位置
     *
     * @param position 经纬度
     */
    setPosition(position: LatLng): void;
    /**
     * 设置GL3DModel角度
     *
     * @param rotate 角度值
     */
    setAngle(rotate: number): void;
    /**
     * 设置GL3DModel的高度
     *
     * @param altitude
     */
    setAltitude(altitude: number): void;
    /**
     * 获取GL3DModel的高度
     *
     * @return
     */
    getAltitude(): number;
    /**
     * 获取GL3DModel角度
     *
     * @return 角度值
     */
    getAngle(): number;
    /**
     * 获取当前模型位置
     *
     * @return 位置经纬度
     */
    getPosition(): LatLng;
    getId(): string;
    /**
     * 设置动画对象
     *
     * @param animation 指定的动画obj
     */
    /**
     * 开始动画
     *
     * @return true代表开始成功，false代表失败
     */
    /**
     * 设置模型固定长度，设置的是最长的边。
     *
     * @param px 模型最长边的长度，单位：像素
     */
    setModelFixedLength(px: number): void;
    /**
     * 将GL3DModel模型从地图上移除
     */
    remove(): void;
    isVisible(): boolean;
    setVisible(visible: boolean): void;
    setObject(object: Object): void;
    getObject(): Object | undefined;
    setRotateAngle(rotate: number): void;
    getRotateAngle(): number;
    setZoomLimit(m26: number): void;
    destroy(): void;
    setGeoPoint(l26: Point): void;
    setTitle(title: string): void;
    getTitle(): string;
    getSnippet(): string;
    setSnippet(snippet: string): void;
    showInfoWindow(): void;
    isInfoWindowEnable(): boolean;
    setZIndex(zIndex: number): void;
    getZIndex(): number;
    private updateOption;
}
