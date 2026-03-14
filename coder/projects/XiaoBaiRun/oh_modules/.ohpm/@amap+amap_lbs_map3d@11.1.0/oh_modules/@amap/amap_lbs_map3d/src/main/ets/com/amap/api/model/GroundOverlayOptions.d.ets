// @keepTs
// @ts-nocheck
/**
 * 自定义图层覆盖物选项类
 *
 * @since 1.0.0
 */
import { LatLng } from './LatLng';
import { BaseOptions } from './BaseOptions';
import { BitmapDescriptor } from './BitmapDescriptor';
import { LatLngBounds } from './LatLngBounds';
export declare class GroundOverlayOptions extends BaseOptions {
    /**
     * 日志标记
     */
    private static readonly TAG;
    /**
     * BitmapDescriptor类把图片包装成对象
     */
    private bitmapDescriptor?;
    /**
     * Ground覆盖物的位置
     */
    private latLng?;
    /**
     * Ground覆盖物的宽度
     */
    private width;
    /**
     * Ground覆盖物的位置
     */
    private height;
    /**
     * Ground覆盖物的矩形区域
     */
    private latlngBounds?;
    /**
     * Ground覆盖物从正北顺时针的角度
     */
    private bearing;
    /**
     * Ground覆盖物的z轴指数
     */
    private zIndex;
    /**
     * Ground覆盖物是否可见
     */
    isVisible: boolean;
    /**
     * Ground覆盖物的透明度
     */
    private transparency;
    /**
     * Ground覆盖物在宽度（水平方向）上的对齐方式
     */
    private anchorU;
    /**
     * Ground覆盖物在高度（垂直方向）上的对齐方式
     */
    private anchorV;
    /**
     * 角度转弧度的系数（Math.PI / 180）
     * 用于将经纬度的度数转换为以弧度为单位的值，便于球面距离和位置计算
     */
    private readonly t6;
    /**
     * 地球平均半径（单位：米），用于根据经纬度差计算地表实际距离
     */
    private readonly R;
    /**
     * Ground 覆盖物矩形区域的西南角地理坐标
     * 在根据 LatLngBounds 设置位置和尺寸时使用
     */
    private southwest?;
    /**
     * Ground 覆盖物矩形区域的东北角地理坐标
     * 与 southwest 坐标共同确定覆盖物的包围范围
     */
    private northeast?;
    /**
     * 构造一个新的GroundOverlayOptions对象。
     *
     * @since 1.0.0
     */
    constructor();
    /**
     * 设置 ground 覆盖物的图片信息。
     *
     * @param image ground 覆盖物使用的图片。
     * @return 根据新图片返回的GroundOverlayOptions。
     * @since 1.0.0
     */
    image(image: BitmapDescriptor): GroundOverlayOptions;
    /**
     * 设置图片的对齐方式，[0,0]是左上角，[1,1]是右下角 。如果不设置，默认为[0.5,0.5]图片的中心点。
     *
     * @param anchorU 在宽度（水平方向）上的对齐方式，建议范围为[0,1]。
     * @param anchorV 在高度（垂直方向）上的对齐方式，建议范围为[0,1]。
     * @return 根据新的对齐方式返回的GroundOverlayOptions。
     * @since 1.0.0
     */
    anchor(anchorU: number, anchorV: number): GroundOverlayOptions;
    /**
     * 根据位置和宽高设置ground 覆盖物。在显示时，图片会被缩放来适应指定的尺寸。
     *
     * @param location ground 覆盖物的锚点。
     * @param width    ground 覆盖物的宽，单位：米。
     * @param height   ground 覆盖物的高，单位：米。
     * @return 根据位置和宽高设置ground 覆盖物的GroundOverlayOptions。
     * @since 1.0.0
     */
    position(location: LatLng | undefined, width: number, height?: number): GroundOverlayOptions;
    private putGroundOverlayOptions;
    /**
     * 根据矩形区域设置ground 覆盖物的位置。当设置时忽略旋转的角度，但是画此ground 覆盖物时还是会使用之前的旋转角度。
     *
     * @param paramLatLngBounds 设置ground 覆盖物的矩形区域。
     * @return 根据矩形区域设置ground 覆盖物位置的GroundOverlayOptions。
     * @since 1.0.0
     */
    positionFromBounds(v28: LatLngBounds): GroundOverlayOptions;
    /**
     * 设置ground 覆盖物从正北顺时针的角度，相对锚点旋转。
     *
     * @param bearing ground 覆盖物从正北顺时针的角度，范围为[0,360)。
     * @return 设置ground 覆盖物角度返回的GroundOverlayOptions。
     * @since 1.0.0
     */
    setBearing(bearing: number): GroundOverlayOptions;
    /**
     * 设置ground 覆盖物的z轴指数。
     *
     * @param zIndex z轴指数。
     * @return 设置ground 覆盖物z轴指数的GroundOverlayOptions。
     * @since 1.0.0
     */
    setZIndex(zIndex: number): GroundOverlayOptions;
    /**
     * 设置ground 覆盖物是否可见。默认为可见 。
     *
     * @param visible true 可见，false 不可见。
     * @return 设置ground 覆盖物可见属性的GroundOverlayOptions。
     * @since 1.0.0
     */
    visible(visible: boolean): GroundOverlayOptions;
    /**
     * 设置ground 覆盖物的透明度。默认为0，不透明。
     *
     * @param transparency ground 覆盖物的透明度，范围为[0,1]，0为不透明，1为全透明。
     * @return 设置ground 覆盖物透明度属性的GroundOverlayOptions。
     * @since 1.0.0
     */
    setTransparency(transparency: number): GroundOverlayOptions;
    /**
     * 获取 ground 覆盖物的bitmap描述信息。
     *
     * @return GroundOverlayOptions 的图片。
     * @since 1.0.0
     */
    getImage(): BitmapDescriptor | undefined;
    /**
     * 获取 Ground覆盖物 的位置。
     *
     * @return 此ground 覆盖物的位置。如果用矩形区域设置ground 覆盖物位置，此方法返回null。
     * @since 1.0.0
     */
    getLocation(): LatLng | undefined;
    /**
     * 获取 ground 覆盖物的宽 。
     *
     * @return ground 覆盖物的宽。单位：米。
     * @since 1.0.0
     */
    getWidth(): number;
    /**
     * 获取 ground 覆盖物的高。
     *
     * @return ground 覆盖物的高。单位：米。
     * @since 1.0.0
     */
    getHeight(): number;
    /**
     * 获取 ground 覆盖物 的矩形区域 。
     *
     * @return ground 覆盖物 的矩形区域（西南和东北点坐标范围）。如果用锚点设置ground 覆盖物位置，此方法会返回null。
     * @since 1.0.0
     */
    getBounds(): LatLngBounds | undefined;
    /**
     * 获取 ground 覆盖物的角度。
     *
     * @return ground 覆盖物的角度。
     * @since 1.0.0
     */
    getBearing(): number;
    /**
     * 获取 ground 覆盖物的z轴指数。
     *
     * @return ground 覆盖物的z轴指数。
     * @since 1.0.0
     */
    getZIndex(): number;
    /**
     * 获取 ground 覆盖物的透明度。
     *
     * @return ground 覆盖物的透明度。
     * @since 1.0.0
     */
    getTransparency(): number;
    /**
     * 从左边开始，水平方向的对齐方式，范围为[0,1]。
     *
     * @return 水平方向对齐返回的值。
     * @since 1.0.0
     */
    getAnchorU(): number;
    /**
     * 从上边开始，垂直方向的对齐方式，范围为[0,1]。
     *
     * @return 垂直方向对齐返回的值。
     * @since 1.0.0
     */
    getAnchorV(): number;
    /**
     * 获取ground 覆盖物是否可见。
     *
     * @return ground 覆盖物是否可见，true 可见，false 不可见。
     * @since 1.0.0
     */
    getIsVisible(): boolean;
    /**
     * @return
     * @exclude javadoc中不显示
     */
    describeContents(): number;
    /**
     * 根据已知的矩形区域边界（southwest、northeast），
     * 计算 Ground 覆盖物的中心坐标（latLng）以及实际宽度和高度。
     * 计算过程中会考虑设置的锚点比例（anchorU、anchorV），
     * 并使用地球半径 R 和角度转弧度系数 NF_PI 将经纬度差转换为地表距离。
     */
    private z28;
    /**
     * 根据当前 Ground 覆盖物的中心坐标（latLng）以及宽度和高度，
     * 计算出矩形包围区域（latlngBounds），并更新 southwest 与 northeast 边界点。
     * 计算过程中会考虑设置的锚点比例（anchorU、anchorV），
     * 并通过地球半径 R 和角度转弧度系数 NF_PI 在经纬度与实际距离之间进行换算。
     */
    private a29;
}
