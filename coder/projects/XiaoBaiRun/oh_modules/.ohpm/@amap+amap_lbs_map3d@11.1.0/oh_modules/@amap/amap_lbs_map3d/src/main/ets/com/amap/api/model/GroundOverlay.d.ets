// @keepTs
// @ts-nocheck
/**
 * 定义在地图上绘制一个 Ground 覆盖物（一张图片以合适的大小贴在地图上的图片层）
 *
 * 位置： 可以通过设置中心点或者图片区域来确定图片层的位置。在添加图片层之前，如果不设置中心点或者图片区域，会报IllegalArgumentException异常。
 * 图片： 覆盖物的贴图。在添加图片层之前，如果没有设置图片，会报IllegalArgumentException 异常。
 * 角度： 图片从正北开始，顺时针方向旋转，中心点为锚点。
 * Z轴 ： Z轴是控制地图覆盖物（overlay）之间的绘制层次的参数。这个参数能够控制Circles、Polygons、Polyline的绘制层次，但不会影响marker。Z轴数值越大的覆盖物（overlay）将会绘制在更上层。如果两个及两个以上覆盖物（overlay）的Z轴数值相同，则最后的绘制结果是随机的 。覆盖物（overlay）的默认为Z轴为0。
 * 可见：这个属性表示了线段是否可以显示在地图上。如果设置为不可见，则绘制地图时不会绘制此线段，但其他属性不受影响。默认为可见。
 *
 * @since 1.0.0
 */
import { GroundOverlayOptions } from './GroundOverlayOptions';
import { BaseOverlay } from './BaseOverlay';
import { d16 } from '../../mapcore/interface/IGLOverlayLayer';
import { LatLng } from './LatLng';
import { BitmapDescriptor } from './BitmapDescriptor';
import { LatLngBounds } from './LatLngBounds';
export declare class GroundOverlay extends BaseOverlay {
    /**
     * 日志标记
     */
    static readonly TAG: string;
    /**
     * Ground覆盖物的选项
     */
    private options;
    /**
     * 对底层 OpenGL 覆盖物图层（IGLOverlayLayer）的弱引用
     */
    private glOverlayLayerRef?;
    /**
     * Ground覆盖物的位置
     */
    private point?;
    /**
     * Ground覆盖物的宽度
     */
    private width;
    /**
     * Ground覆盖物的高度
     */
    private high;
    /**
     * 构造一个新的 GroundOverlay 对象。
     * @param glOverlayLayer 覆盖物图层。
     * @param options ground覆盖物的选项。
     * @param overlayName 覆盖物种类名称。
     * @exclude javadoc中不显示
     */
    constructor(t28: d16, options: GroundOverlayOptions, u28: string);
    /**
     * 从地图中删除当前 Ground 覆盖物，删除后它的所有方法不可用。
     * @since 1.0.0
     */
    remove(): void;
    /**
     * 得到Ground 覆盖物的Id，一个地图上的每个图片层都有自己的ID。
     *
     * @return 当前Ground覆盖物的Id。
     * @since 1.0.0
     */
    getId(): string;
    /**
     * 设置ground 覆盖物的位置，ground 覆盖物的其他属性不变。
     *
     * @param latLng 可以设置ground覆盖物的位置的锚点。
     * @since 1.0.0
     */
    setPosition(latLng: LatLng): void;
    /**
     * 获取 ground 覆盖物位置。
     *
     * @return ground 覆盖物的位置。
     * @since 1.0.0
     */
    getPosition(): LatLng | undefined;
    /**
     * 设置ground 覆盖物的图片信息，新图片会使用老图片的矩形区域。
     *
     * @param icon 新图片。
     * @since 1.0.0
     */
    setImage(icon: BitmapDescriptor): void;
    /**
     * 设置ground 覆盖物的宽度和高度，图片会被拉伸，可能不会保留之前的图片比例。
     *
     * @param width  ground 覆盖物的宽度。单位:米
     * @param height ground 覆盖物的高度。单位:米
     * @since 1.0.0
     */
    setDimensions(width: number, height?: number): void;
    /**
     * 获取 ground 覆盖物的宽度。
     *
     * @return ground 覆盖物的宽。单位:米
     * @since 1.0.0
     */
    getWidth(): number;
    /**
     * 获取ground 覆盖物的高。
     *
     * @return ground 覆盖物的高。单位:米
     * @since 1.0.0
     */
    getHeight(): number;
    /**
     * 根据矩形区域设置ground 覆盖物的位置。当设置时忽略旋转的角度，但是画此ground 覆盖物时还是会使用之前的旋转角度。
     *
     * @param latLngBounds 可以设置ground 覆盖物位置的矩形区域。（西南与东北坐标范围）
     * @since 1.0.0
     */
    setPositionFromBounds(q28: LatLngBounds): void;
    /**
     * 获取ground 覆盖物的地理坐标范围。
     *
     * @return ground 覆盖物位置的矩形区域（西南与东北坐标范围）。
     * @since 1.0.0
     */
    getBounds(): LatLngBounds | undefined;
    /**
     * 设置ground 覆盖物从正北开始顺时针旋转的角度，中心点为锚点。
     *
     * @param bearing 旋转的角度。
     * @since 1.0.0
     */
    setBearing(bearing: number): void;
    /**
     * 获取ground 覆盖物旋转的角度。
     *
     * @return 旋转的角度。
     * @since 1.0.0
     */
    getBearing(): number;
    /**
     * 设置ground 覆盖物的z轴指数。
     *
     * @param zIndex ground 覆盖物的z轴指数。
     * @since 1.0.0
     */
    setZIndex(zIndex: number): void;
    /**
     * 获取ground 覆盖物的z轴指数。
     *
     * @return ground 覆盖物的z轴指数。
     * @since 1.0.0
     */
    getZIndex(): number;
    /**
     * 设置ground 覆盖物是否可见。
     *
     * @param visible true 可见, false 不可见。
     * @since 1.0.0
     */
    setVisible(visible: boolean): void;
    /**
     * 得到当前ground 覆盖物的可见性。不管是否在屏幕中，只看是否在地图中存在。
     *
     * @return 当前ground 覆盖物是否可见，true 可见，false 不可见。
     * @since 1.0.0
     */
    isVisible(): boolean;
    /**
     * 设置ground 覆盖物的透明度，默认为0，不透明。
     *
     * @param transparency 0~1之间的数值，0为不透明，1为全透明。
     * @since 1.0.0
     */
    setTransparency(transparency: number): void;
    /**
     * 获取ground 覆盖物的透明度。
     *
     * @return ground 覆盖物的透明度。
     * @since 1.0.0
     */
    getTransparency(): number;
    /**
     * @param object
     * @return
     * @exclude javadoc中不显示
     */
    equals(other: object): boolean;
    /**
     * 从地图中销毁当前 Ground 覆盖物。
     * @since 1.0.0
     */
    destroy(): void;
    /**
     * 更新当前 Ground 覆盖物的配置信息。
     * @since 1.0.0
     */
    private updateOption;
}
