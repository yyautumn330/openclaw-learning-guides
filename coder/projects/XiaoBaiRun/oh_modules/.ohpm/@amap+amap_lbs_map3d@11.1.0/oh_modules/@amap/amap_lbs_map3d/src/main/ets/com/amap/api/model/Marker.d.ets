// @keepTs
// @ts-nocheck
import { d16 } from '../../mapcore/interface/IGLOverlayLayer';
import { BasePointOverlay } from './BasePointOverlay';
import { BitmapDescriptor } from './BitmapDescriptor';
import { LatLng } from './LatLng';
import { MarkerOptions } from './MarkerOptions';
import { Point } from './Point';
import { IPoint } from '../utils/overlay/IPoint';
import { s36 } from '../../mapcore/interface/INativeOverlayLayer';
import ArrayList from "@ohos.util.ArrayList";
import { Animation, AnimationListener } from './animation/Animation';
export declare class Marker extends BasePointOverlay {
    private static readonly TAG;
    private options;
    private glOverlayLayer;
    private n37?;
    private object?;
    private aIsRemoved;
    private o37;
    p37?: LatLng;
    private z6;
    private q37?;
    private r37?;
    private s37;
    private t37?;
    constructor(j37: d16, k37: MarkerOptions, l37: string, m37?: s36);
    /**
     * 删除当前marker。在删除当前marker之后，它的所有方法将不被支持。
     *
     * @since 1.0.0
     */
    remove(): void;
    /**
     * 删除当前marker并销毁Marker的图片等资源。一旦使用此方法，该对象将被彻底释放。
     *
     * @since 1.0.0
     */
    destroy(): void;
    /**
     * 返回Marker 的Id，每个marker 的唯一标识，用来区分不同的Marker。
     *
     * @return Marker的Id。
     * @since 1.0.0
     */
    getId(): string;
    /**
     * 设置 Marker 覆盖物的位置坐标。
     * <p>若想让标记随地图移动，可以使用此方法改变。若想让 marker 在屏幕固定显示，可以使用 {@link #setPositionByPixels(number, number) setPositionByPixels(number, number)} 方法。</p>
     *
     * @param latlng 位置坐标。
     * @since 1.0.0
     */
    setPosition(i37: LatLng): void;
    /**
     * 获取 Marker 覆盖物的位置坐标。
     *
     * @return Marker 覆盖物的位置坐标。
     * @since 1.0.0
     */
    getPosition(): LatLng;
    /**
     * 设置Marker 覆盖物的标题。
     *
     * @param title 标题信息。
     * @since 1.0.0
     */
    setTitle(title: string): void;
    /**
     * 获取Marker 覆盖物的标题。
     *
     * @return Marker 覆盖物的标题。
     * @since 1.0.0
     */
    getTitle(): string;
    /**
     * 设置Marker 覆盖物的文字片段。
     *
     * @param snippet 文字片段。
     * @since 1.0.0
     */
    setSnippet(snippet: string): void;
    /**
     * 获取Marker 覆盖物的文字片段。
     *
     * @return marker 覆盖物的文字片段。
     * @since 1.0.0
     */
    getSnippet(): string;
    /**
     * 设置 Marker覆盖物的图标
     *
     * @param icon 图标
     * @since 1.0.0
     */
    setIcon(icon: BitmapDescriptor): void;
    /**
     * 返回Marker动画帧的图标列表。
     *
     * @return Marker动画帧的图标列表。
     * @since 1.0.0
     */
    getIcon(): BitmapDescriptor | undefined;
    /**
     * 设置Marker覆盖物的锚点比例。
     * 锚点是定位图标接触地图平面的点。图标的左上顶点为（0,0）点，右下点为（1,1）点。默认情况下，锚点为（0.5,1.0）。
     *
     * @param anchorU 锚点水平范围的比例。
     * @param anchorV 锚点垂直范围的比例。
     * @since 1.0.0
     */
    setAnchor(anchorU: number, anchorV: number): void;
    /**
     * 设置Marker覆盖物是否允许拖拽。默认不可拖拽
     * 当标记设置为可拖拽，用户可通过长按标记来进行拖拽。
     *
     * @param paramBoolean Marker是否可拖动，true表示可拖拽，false表示不可拖拽。
     * @since 1.0.0
     */
    setDraggable(h37: boolean): void;
    /**
     * 获得Marker覆盖物的拖拽状态。
     *
     * @return true 可以拖拽；false 不可以拖拽。
     * @since 1.0.0
     */
    isDraggable(): boolean;
    /**
     * 显示 Marker 覆盖物的信息窗口。
     *
     * @since 1.0.0
     */
    showInfoWindow(): void;
    /**
     * 隐藏Marker覆盖物的信息窗口。如果Marker本身是不可以见的，此方法将不起任何作用。
     *
     * @since 1.0.0
     */
    hideInfoWindow(): void;
    /**
     * 返回Marker覆盖物的信息窗口是否显示，true: 显示，false: 不显示。此方法返回值时不会参考这个信息窗口是否在当前屏幕上真的可见。
     *
     * @return Marker 覆盖物的信息窗口是否显示。
     * @since 1.0.0
     */
    isInfoWindowShown(): boolean;
    /**
     * 获取Marker覆盖物是否允许InfoWindow显示, 可以通过 {@link #setInfoWindowEnable(boolean)} 进行设置
     * @return true: 允许显示,false:不允许显示
     * @since 1.0.0
     */
    isInfoWindowEnable(): boolean;
    /**
     * 设置Marker覆盖物的InfoWindow是否允许显示,默认为true <br>
     * 设置为false之后, 调用{@link #showInfoWindow()} 将不会生效
     * @param enabled true:允许显示,false:不允许显示
     * @since 1.0.0
     */
    setInfoWindowEnable(enabled: boolean): void;
    /**
     * 设置 Marker 覆盖物的可见属性。如果Marker 的可见属性为false 时，信息窗口也会同时为不可见。
     *
     * @param visible 一个布尔值，表示Marker是否可见，true表示可见，false表示不可见。
     * @since 1.0.0
     */
    setVisible(visible: boolean): void;
    /**
     * 返回Marker是否可见。
     *
     * @return Marker是否可见。true：可见；false：不可见。
     * @since 1.0.0
     */
    isVisible(): boolean;
    /**
     * 设置Marker覆盖物图片旋转的角度，从正北开始，逆时针计算。
     *
     * @param rotate Marker图片旋转的角度，从正北开始，逆时针计算。
     * @since 1.0.0
     */
    setRotateAngle(rotate: number): void;
    /**
     * 获取Marker覆盖物的选项类
     * @return 获取失败的时候返回null,详见 {@link MarkerOptions}
     * @since V4.0.0
     */
    getOptions(): MarkerOptions;
    /**
     * 获取 Marker覆盖物的图片旋转角度，从正北开始，逆时针计算。
     *
     * @return Marker覆盖物的图片旋转角度。
     * @since 1.0.0
     */
    getRotateAngle(): number;
    /**
     * 设置Marker覆盖物的附加信息对象。用户可以自定义Marker的属性。
     *
     * @param object Marker覆盖物的附加信息对象
     * @since 1.0.0
     */
    setObject(object: object): void;
    /**
     * 获取Marker覆盖物的附加信息对象，即自定义的Marker的属性。
     *
     * @return Marker覆盖物的附加信息对象。
     * @since 1.0.0
     */
    getObject(): object | undefined;
    /**
     * 设置Marker覆盖物的z轴值。
     *
     * @param zIndex z轴，即竖直方向上的值
     * @since 1.0.0
     */
    setZIndex(zIndex: number): void;
    /**
     * 获取Marker覆盖物的z轴值。
     *
     * @return zIndex z轴，即竖直方向上的值
     * @since 1.0.0
     */
    getZIndex(): number;
    /**
     * 设置动画,动画包含，旋转，缩放，消失，平移以及它们的组合动画
     * @param animation 动画类，详情请看 {@link Animation}
     * @since V4.0.0
     */
    setAnimation(animation: Animation): void;
    /**
     * 开始动画
     * @return 返回false表示开启动画失败
     * @since V4.0.0
     */
    startAnimation(): boolean;
    /**
     * 设置动画监听，可以监听动画的开始和结束
     * @param listener 动画监听回调
     * @since V4.0.0
     * @exclude javadoc中不显示 滴滴使用
     */
    setAnimationListener(listener: AnimationListener): void;
    /**
     * 获取Marker覆盖物的透明度,透明度范围[0,1] 1为不透明,默认值为1
     * @return 透明度
     * @since 2.0.0
     */
    getAlpha(): number;
    /**
     * 设置Marker覆盖物的透明度
     * @param alpha 透明度范围[0,1] 1为不透明
     * @since 2.0.0
     */
    setAlpha(alpha: number): void;
    /**
     * 获取Maker覆盖物的点击状态,可以通过 {@link #setClickable(boolean)} 设置是否可以点击
     *
     * @return true : 表示可以点击,false:表示不可点击
     * @since 1.0.0
     */
    isClickable(): boolean;
    /**
     * 设置Marker覆盖物的属性选项类
     * 通过markerOption 给marker设置属性
     *
     * @param opt 一个MarkerOptions 对象，它定义了如何渲染Marker 的属性。
     * @since 1.0.0
     */
    setMarkerOptions(y36: MarkerOptions): void;
    /**
     * 设置Marker覆盖物是否可以点击
     *
     * @param clickable true : 表示可以点击,false:表示不可点击
     * @since 1.0.0
     */
    setClickable(clickable: boolean): void;
    /**
     * 获取当前Marker是否是被移除状态
     *
     * @return true表示已经被移除，false表示没有
     * @since 1.0.0
     */
    isRemoved(): boolean;
    /**
     * 获取Marker覆盖物锚点在水平范围的比例,这个比例值从图标的左边开始计算。
     *
     * @return 锚点在水平范围的比例。
     * @exclude javadoc中不显示 滴滴使用
     * @since 1.0.0
     */
    getAnchorU(): number;
    /**
     * 获取Marker覆盖物锚点在垂直范围的比例,这个比例值从图标的顶端开始计算。
     *
     * @return 锚点在垂直范围的比例。
     * @exclude javadoc中不显示 滴滴使用
     * @since 1.0.0
     */
    getAnchorV(): number;
    private updateOption;
    /**
     * 获取是否是viewmode 内部使用
     *
     * @exclude javadoc中不显示
     */
    isViewMode(): boolean;
    /**
     * 图片的高度+infowindow的偏移
     *
     * @exclude javadoc中不显示
     */
    getRealInfoWindowOffset(point: Point): void;
    /**
     * 设置Marker覆盖物是否平贴在地图上。
     *
     * @param flat Marker平贴地图设置为 true，面对镜头设置为 false。
     * @since V2.0.0
     */
    setFlat(flat: boolean): void;
    /**
     * 返回Marker覆盖物是否是平贴在地图上。
     *
     * @return 若marker平贴在地图上返回 true；若marker面对镜头返回 false。
     * @since V2.0.0
     */
    getFlat(): boolean;
    /**
     * 设置marker海拔
     *
     * @param altitude
     * @since 2.0.0
     */
    setAltitude(altitude: number): void;
    /**
     * 获取marker海拔
     *
     * @return marker海拔
     * @since 2.0.0
     */
    getAltitude(): number;
    /**
     * 设置marker覆盖物在屏幕的像素坐标。若用此方式，Marker固定显示在屏幕上；如果想让标记随地图移动，可以使用 {@link #setPosition(LatLng) setPosition(LatLng)} 改变。
     *
     * @param x 横向像素点。
     * @param y 纵向像素点。
     * @since V2.0.0
     */
    setPositionByPixels(x: number, y: number): void;
    /**
     * 设置当前marker在最上面。
     *
     * @since V2.0.0
     */
    setToTop(): void;
    setGeoPoint(t36: IPoint): void;
    /**
     * 是否icon是view
     * @return true:是view,false:不是view
     */
    w37(): boolean;
    /**
     * 设置多少帧刷新一次图片资源，Marker动画的间隔时间，值越小动画越快。默认为20，最小为1。
     *
     * @param period 刷新周期，越小速度越快。默认为20，最小为1。
     * @since V2.2.3
     */
    setPeriod(period: number): void;
    /**
     * 得到多少帧刷新一次图片资源。默认为20，最小为1。
     *
     * @return 刷新周期，速度越小速度越快。默认为20，最小为1。
     * @since V2.2.3
     */
    getPeriod(): number;
    /**
     * 设置 Marker 的图标集合，相同图案的 icon 的 marker 最好使用同一个 BitmapDescriptor 对象以节省内存空间。
     * Marker动画的每一帧图片，动画的描点和大小以第一帧为准，建议图片大小保持一致。
     *
     * @param icons Marker动画帧的列表。
     * @since V2.2.3
     */
    setIcons(icons: ArrayList<BitmapDescriptor>): void;
}
