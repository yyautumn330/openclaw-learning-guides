// @keepTs
// @ts-nocheck
/**
 * Marker 的选项类。
 *
 * @since 1.0.0
 */
import { BaseOptions, BaseUpdateFlags } from './BaseOptions';
import { BitmapDescriptor } from './BitmapDescriptor';
import { LatLng } from './LatLng';
import ArrayList from "@ohos.util.ArrayList";
export declare class MarkerOptions extends BaseOptions {
    private latLng;
    private gpsLatLng;
    private title;
    private snippet;
    private anchorU;
    private anchorV;
    private zIndex;
    private draggable;
    private visible;
    private altitude;
    private offsetX;
    private offsetY;
    private bitmapDescriptors;
    /**
     * 刷新周期
     */
    private period;
    private gps;
    private flat;
    private rotatingMode;
    private angleOffset;
    private screenX;
    private screenY;
    private viewMode;
    protected alpha: number;
    protected autoOverturn: boolean;
    protected infoWindowEnabled: boolean;
    protected dispLevel: number;
    protected rotate: number;
    private belowMaskLayer;
    private updateFlags;
    private clickable;
    private resource;
    private bitmapDescriptor;
    private bitmapDescriptorsArray;
    /**
     * Marker覆盖物的原生view图标
     */
    private n38?;
    /**
     * 创建MarkerOptions对象。
     * @since 1.0.0
     */
    constructor();
    /**
     * gps坐标，需要转换为高德坐标
     */
    private checkGpsPosition;
    /**
     * 设置多少帧刷新一次图片资源，Marker动画的间隔时间，值越小动画越快。
     *
     * @param period 帧数， 刷新周期，值越小速度越快。默认为20，最小为1。
     * @return MarkerOptions 对象。
     * @since V2.0.0
     */
    setPeriod(period: number): MarkerOptions;
    /**
     * 得到多少帧刷新一次图片资源，值越小动画越快。
     *
     * @return 刷新周期，值越小速度越快。默认为20，最小为1。
     * @since V2.1.4
     */
    getPeriod(): number;
    /**
     * 设置Marker覆盖物的坐标是否是Gps，默认为false。
     *
     * @param isGps true 是Gps，false 不是Gps。
     * @return MarkerOptions 对象。
     * @since V2.2.0
     */
    setGps(m38: boolean): MarkerOptions;
    /**
     * 获取Marker覆盖物的坐标是否是Gps，默认为false。
     *
     * @return true 是Gps，false 不是Gps。
     * @since V2.0.0
     */
    isGps(): boolean;
    /**
     * 设置Marker覆盖物的透明度
     * @param alpha 透明度范围[0,1] 1为不透明
     * @return 修改了透明度的MarkerOptions对象
     * @since 2.0.0
     */
    setAlpha(alpha: number): MarkerOptions;
    /**
     * 获取Marker覆盖物的透明度,透明度范围[0,1] 1为不透明,默认值为1
     * @return 透明度
     * @since 2.0.0
     */
    getAlpha(): number;
    /**
     * 设置Marker覆盖物的InfoWindow是否自动旋转
     * @param autoOverturn ture : 表示自动翻转,false:表示不自动翻转
     * @return MarkerOptions对象
     * @since V4.0.0
     * @exclude javadoc中不显示 滴滴使用
     */
    autoOverturnInfoWindow(l38: boolean): MarkerOptions;
    /**
     * 获取Marker覆盖物的InfoWindow自动翻转状态,可以通过 {@link #autoOverturnInfoWindow(boolean)} 设置是否自动翻转
     * @return ture : 表示自动翻转,false:表示不自动翻转
     * @since V4.0.0
     * @exclude javadoc中不显示 滴滴使用
     */
    isInfoWindowAutoOverturn(): boolean;
    /**
     * 设置Marker覆盖物的InfoWindow避让优先级
     * 如果当前显示InfoWindow的Marker A优先级是5,但是InfoWindow挡住了级别为1的Marker B,则InfoWindow需要翻转,避开Marker B<br>
     * 如果设置了InfoWindow可翻转, 设置方法见{@link #autoOverturnInfoWindow(boolean)} <br>
     * 如果设置为0,则表示不参与翻转判断
     * @param level 避让优先级,默认值为5
     * @return MarkerOptions对象
     * @since V4.0.0
     * @exclude javadoc中不显示 滴滴使用
     */
    setDisplayLevel(level: number): MarkerOptions;
    /**
     * 获取Marker覆盖物的InfoWindow避让优先级<br>
     * @see #displayLevel(int)
     * @return 避让优先级,默认为5
     * @since V4.0.0
     * @exclude javadoc中不显示 滴滴使用
     */
    getDisplayLevel(): number;
    /**
     * 设置Marker覆盖物的位置坐标。Marker经纬度坐标不能为Null，坐标无默认值。
     *
     * @param position 当前MarkerOptions对象的经纬度。
     * @return MarkerOptions对象。
     * @since 1.0.0
     */
    setPosition(position: LatLng): MarkerOptions;
    /**
     * 设置Marker覆盖物是否平贴地图。
     *
     * @param flat 平贴地图设置为 true，面对镜头设置为 false。
     * @return MarkerOptions 对象。
     * @since V2.2.1
     */
    setFlat(flat: boolean): MarkerOptions;
    /**
     * 获取Marker覆盖物是否平贴地图。
     *
     * @return 若marker平贴在地图上返回 true；若marker面对镜头返回 false。
     * @since V2.2.1
     */
    getFlat(): boolean;
    /**
     * 设置Marker覆盖物的图标。相同图案的 icon 的 Marker 最好使用同一个 BitmapDescriptor 对象以节省内存空间。
     *
     * @param icon 图标的BitmapDescriptor对象
     * @return MarkerOptions对象。
     * @since 1.0.0
     */
    setIcon(icon: BitmapDescriptor): MarkerOptions;
    /**
     * 设置Marker覆盖物的锚点比例。锚点是marker 图标接触地图平面的点。图标的左顶点为（0,0）点，右底点为（1,1）点。<br>
     * 默认为（0.5,1.0）
     * @param u 锚点水平范围的比例，建议传入0 到1 之间的数值。
     * @param v 锚点垂直范围的比例，建议传入0 到1 之间的数值。
     * @return 一个设置了锚点的MarkerOptions 对象
     * @since 1.0.0
     */
    setAnchor(k38: number, v: number): MarkerOptions;
    /**
     * 设置Marker覆盖物的InfoWindow相对Marker的偏移。
     * <p>坐标系原点为marker的中上点，InfoWindow相对此原点的像素偏移，向左和向上上为负，向右和向下为正。InfoWindow的初始位置为marker上边线与InfoWindow下边线重合，并且两者的中线在一条线上。</p>
     *
     * @param offsetX InfoWindow相对原点的横向像素偏移量，单位：像素。
     * @param offsetY InfoWindow相对原点的纵向像素偏移量，单位：像素。
     * @return MarkerOptions对象。
     * @V2.0.0
     */
    setInfoWindowOffset(offsetX: number, offsetY: number): MarkerOptions;
    /**
     * 设置 Marker覆盖物 的标题
     *
     * @param title Marker 的标题
     * @return 一个设置标题的MarkerOptions对象。
     * @since 1.0.0
     */
    setTitle(title: string): MarkerOptions;
    /**
     * 设置 Marker覆盖物的 文字描述
     *
     * @param snippet Marker上的文字描述
     * @return 一个设置文字描述的MarkerOptions对象。
     * @since 1.0.0
     */
    setSnippet(snippet: string): MarkerOptions;
    /**
     * 设置Marker覆盖物是否可拖拽。
     *
     * @param enable 一个布尔值，表示Marker是否可拖拽，true表示可拖拽，false表示不可拖拽。
     * @return 设Marker是否可拖拽的MarkerOptions对象。
     * @since 1.0.0
     */
    setDraggable(enable: boolean): MarkerOptions;
    /**
     * 设置Marker覆盖物是否可见。
     *
     * @param visible Marker的可见性。
     * @return 设置Marker覆盖物是否可见的MarkerOptions对象。
     * @since 1.0.0
     */
    setVisible(visible: boolean): MarkerOptions;
    /**
     * 获取Marker覆盖物的坐标位置。
     *
     * @return 当前MarkerOptions 对象所设置的经纬度。
     * @since 1.0.0
     */
    getPosition(): LatLng;
    /**
     * 获取Marker覆盖物的标题。
     *
     * @return Marker的标题。
     * @since 1.0.0
     */
    getTitle(): string;
    /**
     * 获取Marker覆盖物的文字片段。
     *
     * @return 当前MarkerOptions 对象所设置的文字片段。
     * @since 1.0.0
     */
    getSnippet(): string;
    /**
     * 获取Marker覆盖物的图标。
     *
     * @return 设置图标的BitmapDescriptor 对象，此对象无Bitmap对象，只有宽度和高度，如果未设置返回null。
     * @since 1.0.0
     */
    getIcon(): BitmapDescriptor;
    /**
     * 获取Marker覆盖物锚点在水平范围的比例。这个比例值从图标的左边开始计算。
     *
     * @return 锚点在水平范围的比例。
     * @since 1.0.0
     */
    getAnchorU(): number;
    /**
     * 获取Marker覆盖物的水平偏移距离
     *
     * @return infowindow偏移水平距离
     * @V2.0.0
     */
    getInfoWindowOffsetX(): number;
    /**
     * 获取Marker覆盖物的垂直偏移距离
     *
     * @return infowindow偏移垂直距离
     * @V2.0.0
     */
    getInfoWindowOffsetY(): number;
    /**
     * 获取Marker覆盖物锚点垂直范围的比例。这个比例值从顶端开始计算。
     *
     * @return 锚点在垂直范围的比例。
     * @since 1.0.0
     */
    getAnchorV(): number;
    /**
     * 获取Marker覆盖物的拖拽状态。
     *
     * @return true 可以拖动；false 不可以拖动。
     * @since 1.0.0
     */
    getDraggable(): boolean;
    /**
     * 获取Marker覆盖物是否可见。
     *
     * @return true: 可见， false: 不可见
     * @since 1.0.0
     */
    getVisible(): boolean;
    /**
     * 设置Marker覆盖物 zIndex。
     *
     * @param zIndex
     * @return MarkerOptions对象。
     * @V2.5.0
     */
    setZIndex(zIndex: number): MarkerOptions;
    /**
     * 获取Marker覆盖物zIndex。
     *
     * @return zIndex
     * @V2.5.0
     */
    getZIndex(): number;
    /**
     * 设置Marker覆盖物的图片旋转角度，从正北开始，逆时针计算。
     *
     * @param rotate Marker图片旋转的角度，从正北开始，逆时针计算。
     * @return MarkerOptions对象
     * @since 1.0.0
     */
    setRotateAngle(rotate: number): MarkerOptions;
    /**
     * 获取 Marker覆盖物的图片旋转角度，从正北开始，逆时针计算。
     *
     * @return Marker图片旋转的角度。
     * @since 1.0.0
     */
    getRotateAngle(): number;
    /**
     * 设置Marker覆盖物的InfoWindow是否允许显示,默认为true
     * @param enabled true:允许显示,false:不允许显示
     * @return MarkerOptions对象
     * @since 1.0.0
     */
    setInfoWindowEnable(enabled: boolean): MarkerOptions;
    /**
     * 获取Marker覆盖物的InfoWindow是否允许显示, 可以通过 {@link #infoWindowEnable(boolean)} 进行设置
     * @return true: 允许显示,false:不允许显示
     * @since 1.0.0
     */
    getInfoWindowEnable(): boolean;
    /**
     * 设置Marker覆盖物在蒙层下面,默认在蒙层上面,蒙层详见 {@link com.amap.api.maps.AMap#setMaskLayerParams(int, int, int, int, int, long)}
     * @param isBelowMaskLayer true 放在蒙层下面,false:放在蒙层上面,默认为false
     * @return MarkerOptions对象
     * @since V4.0.0
     * @exclude javadoc中不显示 滴滴使用
     */
    setIsBelowMaskLayer(j38: boolean): MarkerOptions;
    /**
     * 获取Marker覆盖物是否在蒙层下面
     * @return ture:在蒙层下面,false:在蒙层上面
     * @since V4.0.0
     * @exclude javadoc中不显示 滴滴使用
     */
    getIsBelowMaskLayer(): boolean;
    /**
     * marker的海拔
     *
     * @param altitude
     * @return MarkerOptions
     * @since 9.5.0
     */
    setAltitude(altitude: number): MarkerOptions;
    /**
     * 获取marker海拔高度
     *
     * @return
     */
    getAltitude(): number;
    /**
     * @exclude javadoc中不显示
     */
    /**
     * 屏幕坐标
     * @exclude javadoc中不显示
     */
    setScreenPosition(x: number, y: number): void;
    /**
     * 获取是否是ViewMode
     * @exclude javadoc中不显示
     */
    getViewMode(): boolean;
    /**
     * 获取屏幕坐标
     * @exclude javadoc中不显示
     */
    getScreenX(): number;
    /**
     * 获取屏幕坐标
     * @exclude javadoc中不显示
     */
    getScreenY(): number;
    /**
     * 获取屏幕坐标
     * @exclude javadoc中不显示
     */
    toJson(): string;
    getClickable(): boolean;
    setClickable(clickable: boolean): void;
    /**
     * 设置Marker覆盖物的动画帧图标列表，多张图片模拟gif的效果。
     *
     * @param icons Marker的动画帧列表。
     * @return MarkerOptions 对象。
     * @since V2.1.4
     */
    setIcons(icons: ArrayList<BitmapDescriptor>): MarkerOptions;
    /**
     * 设置Marker覆盖物图标列表，根据旋转角度自动切换到对应的icon
     * 例如：如果需要每5度变换一张图片，则icons需要添加72张（360/5）图片
     * @param icons 图片列表
     * @param angleOffset 角度间隔，需要与icons列表对应（360/icons.size()），逆时针为正向，顺时针为负方向
     * @return
     * @since V6.5.1
     * @exclude javadoc中不显示 网约车使用
     */
    rotatingIcons(icons: ArrayList<BitmapDescriptor>, i38: number): MarkerOptions;
    /**
     * 设置切换icon的角度间隔
     * @param angleOffset 角度间隔
     * @return
     * @since V6.5.1
     * @exclude javadoc中不显示 网约车使用
     */
    setAngleOffset(h38: number): MarkerOptions;
    /**
     * 返回切换icon的角度间隔
     * @return
     * @since V6.5.1
     * @exclude javadoc中不显示 网约车使用
     */
    getAngleOffset(): number;
    /**
     * 设置当前Marker是否是根据角度切换icon模式
     * @param rotatingMode
     * @return
     * @exclude javadoc中不显示 网约车使用
     */
    setRotatingMode(g38: boolean): MarkerOptions;
    /**
     * 当前Marker是否是根据角度切换icon模式
     * @return
     * @since V6.5.1
     * @exclude javadoc中不显示 网约车使用
     */
    getRotatingMode(): boolean;
    resetUpdateFlags(): void;
    getUpdateFlags(): MarkerUpdateFlags;
    /**
     * 设置Marker覆盖物的图标,图标使用原生view。
     * @param icon view
     * @return MarkerOptions对象。
     */
    icon(icon: PixelMap): MarkerOptions;
    /**
     * 获取Marker覆盖物的图标 原生view。
     * @return Marker的view，可能为空
     */
    c38(): PixelMap | undefined;
}
declare class MarkerUpdateFlags {
    latlngUpdate: boolean;
    gpsLatLngUpdate: boolean;
    bitmapDescriptorsUpdate: boolean;
    baseUpdateFlags: BaseUpdateFlags;
    reset(): void;
}
export {};
