// @keepTs
// @ts-nocheck
import { CameraPosition } from './model/CameraPosition';
export declare class AMapOptions {
    private aMapType;
    private isRotateGesturesEnabled;
    private isScrollGesturesEnabled;
    private isTiltGesturesEnabled;
    private isZoomGesturesEnabled;
    private isZoomEnabled;
    /**
     * 默认是false 这里写true 是为了防止黑屏
     */
    private isZOrderOnTop;
    private cameraPosition?;
    private isCompassEnabled;
    private isScaleControlsEnabled;
    private aLogoPosition;
    /**
     * Logo位置常量（地图左下角）。
     *
     * @since V2.0.0
     */
    static readonly LOGO_POSITION_BOTTOM_LEFT: number;
    /**
     * Logo位置常量（地图底部居中）。
     *
     * @since V2.0.0
     */
    static readonly LOGO_POSITION_BOTTOM_CENTER: number;
    /**
     * Logo位置常量（地图右下角）。
     *
     * @since V2.0.0
     */
    static readonly LOGO_POSITION_BOTTOM_RIGHT: number;
    /**
     * 缩放按钮位置常量（地图右边居中）。
     *
     * @since V2.0.0
     */
    static readonly ZOOM_POSITION_RIGHT_CENTER: number;
    /**
     * 缩放按钮位置常量（地图右下角）
     *
     * @since V2.0.0
     */
    static readonly ZOOM_POSITION_RIGHT_BUTTOM: number;
    /**
     * LOGO边缘MARGIN常量（左边）
     *
     * @since V2.0.0
     */
    static readonly LOGO_MARGIN_LEFT: number;
    /**
     * LOGO边缘MARGIN常量（右边）
     *
     * @since V2.0.0
     */
    static readonly LOGO_MARGIN_RIGHT: number;
    /**
     * LOGO边缘MARGIN常量（底部）
     *
     * @since V2.0.0
     */
    static readonly LOGO_MARGIN_BOTTOM: number;
    /**
     * MapView 初始化选项。
     *
     * @since V2.0.0
     */
    constructor();
    /**
     * 设置“高德地图”Logo的位置。
     *
     * @param position Logo的位置。
     *                 左下：LOGO_POSITION_BOTTOM_LEFT
     *                 底部居中：LOGO_POSITION_BOTTOM_CENTER
     *                 右下：LOGO_POSITION_BOTTOM_RIGHT
     * @return AMapOptions 该地图初始化选项对象。
     * @since V2.0.0
     */
    logoPosition(position: number): AMapOptions;
    /**
     * 设置Z 轴排序是否被允许。
     *
     * @param zOrderOnTop true 允许，false 不允许。
     * @return 一个设置Z轴排序的AMapOptions对象。
     * @since V2.0.0
     * @exclude javadoc中不显示
     */
    zOrderOnTop(d5: boolean): AMapOptions;
    /**
     * 设置地图模式，默认普通地图。
     *
     * @param mapType 地图模式： MAP_TYPE_NORMAL：普通地图，值为1；
     *             MAP_TYPE_SATELLITE：卫星地图，值为2；
     *             MAP_TYPE_NIGHT 夜景图模式，值为3；
     *             MAP_TYPE_NAVI 导航模式，值为4；
     *             MAP_TYPE_BUS 公交模式，值为5；
     *             MAP_TYPE_NAVI_NIGHT 导航夜间模式，值为6.
     * @return AMapOptions 该地图初始化选项对象。
     * @since V2.0.0
     */
    mapType(mapType: number): AMapOptions;
    /**
     * 设置地图初始化时的地图状态， 默认地图中心点为北京天安门，缩放级别为 10.0f。
     *
     * @param camera 地图状态。
     * @return AMapOptions 该地图初始化选项对象。
     * @since V2.0.0
     */
    camera(camera: CameraPosition): AMapOptions;
    /**
     * 设置地图是否显示比例尺，默认为false。
     *
     * @param enabled true 显示，false 不显示。
     * @return AMapOptions 该地图初始化选项对象。
     * @since V2.0.0
     */
    scaleControlsEnabled(enabled: boolean): AMapOptions;
    /**
     * 设置地图是否允许缩放。默认为true。
     *
     * @param enabled true 支持，false 不支持。
     * @return AMapOptions 该地图初始化选项对象。
     * @since V2.0.0
     */
    zoomControlsEnabled(enabled: boolean): AMapOptions;
    /**
     * 设置指南针是否可用。默认为启用。
     *
     * @param enabled true表示可用，false表示不可用。
     * @return AMapOptions 该地图初始化选项对象。
     * @since V2.0.0
     */
    compassEnabled(enabled: boolean): AMapOptions;
    /**
     * 设置地图是否可以通过手势滑动。默认为true。
     *
     * @param enabled true 支持，false 不支持。
     * @return AMapOptions 该地图初始化选项对象。
     * @since V2.0.0
     */
    scrollGesturesEnabled(enabled: boolean): AMapOptions;
    /**
     * 设置地图是否可以通过手势进行缩放。默认为true。
     *
     * @param enabled true 支持，false 不支持。
     * @return AMapOptions 该地图初始化选项对象。
     * @since V2.0.0
     */
    zoomGesturesEnabled(enabled: boolean): AMapOptions;
    /**
     * 设置地图是否可以通过手势倾斜（3D效果），默认为true。
     *
     * @param enabled true 支持，false 不支持。
     * @return AMapOptions 该地图初始化选项对象。
     * @since V2.0.0
     */
    tiltGesturesEnabled(enabled: boolean): AMapOptions;
    /**
     * 设置地图是否可以通过手势进行旋转。默认为true.
     *
     * @param enabled true 支持，false 不支持。
     * @return AMapOptions 该地图初始化选项对象。
     * @since V2.0.0
     */
    rotateGesturesEnabled(enabled: boolean): AMapOptions;
    /**
     * 获取初始化选项“高德地图”Logo的位置。
     *
     * @return 返回“高德地图”Logo的位置常量。
     * @since V2.0.0
     */
    getLogoPosition(): number;
    /**
     * 返回Z 轴排序是否被允许，如果返回null 则表示未设置。
     *
     * @return true 允许，false 不允许。
     * @since V2.0.0
     * @exclude javadoc中不显示
     */
    getZOrderOnTop(): boolean;
    /**
     * 返回初始化选项中地图模式。
     *
     * @return 初始化选项中地图模式。
     * @since V2.0.0
     */
    getMapType(): number;
    /**
     * 获取初始化选项中地图状态。
     *
     * @return CameraPosition 初始化选项中地图状态。
     * @since V2.0.0
     */
    getCamera(): CameraPosition | undefined;
    /**
     * 返回初始化选项中比例尺功能是否可用。
     *
     * @return 初始化选项中比例尺功能是否可用。
     * @since V2.0.0
     */
    getScaleControlsEnabled(): boolean;
    /**
     * 返回初始化选项中地图是否允许缩放。
     *
     * @return 初始化选项中地图是否允许缩放。
     * @since V2.0
     */
    getZoomControlsEnabled(): boolean;
    /**
     * 返回初始化选项中指南针功能是否可用。
     *
     * @return 初始化选项中指南针是否可用。
     * @since V2.0.1
     */
    getCompassEnabled(): boolean;
    /**
     * 返回初始化选项中拖动手势是否可用。
     *
     * @return 初始化选项中拖动手势是否可用。
     * @since V2.0
     */
    getScrollGesturesEnabled(): boolean;
    /**
     * 返回初始化选项中缩放手势是否可用。
     *
     * @return 初始化选项中缩放手势是否可用。
     * @since V2.0
     */
    getZoomGesturesEnabled(): boolean;
    /**
     * 返回初始化选项中地图倾斜手势（显示3D效果）是否可用。
     *
     * @return 初始化选项中地图倾斜手势（显示3D效果）是否可用。
     * @since V2.0
     */
    getTiltGesturesEnabled(): boolean;
    /**
     * 返回初始化选项中地图旋转手势是否可用。
     *
     * @return 初始化选项中地图旋转手势是否可用。
     * @since V2.0
     */
    getRotateGesturesEnabled(): boolean;
}
