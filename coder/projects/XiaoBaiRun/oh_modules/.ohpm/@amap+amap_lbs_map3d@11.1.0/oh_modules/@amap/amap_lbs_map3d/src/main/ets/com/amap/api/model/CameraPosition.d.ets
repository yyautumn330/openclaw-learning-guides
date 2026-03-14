// @keepTs
// @ts-nocheck
import { LatLng } from './LatLng';
/**
 * 相机位置，这个类包含了所有的可视区域的位置参数。
 * @since 1.0.0
 */
export declare class CameraPosition {
    private static readonly CLASSNAME;
    /**
     * 目标位置的屏幕中心点经纬度坐标。
     * @since 1.0.0
     */
    readonly target: LatLng;
    /**
     * 目标可视区域的缩放级别。
     * @since 1.0.0
     */
    readonly zoom: number;
    /**
     * 目标可视区域的倾斜度，以角度为单位。
     * @since 1.0.0
     */
    readonly tilt: number;
    /**
     * 可视区域指向的方向，以角度为单位，从正北向逆时针方向计算，从0 度到360 度。
     * @since 1.0.0
     */
    readonly bearing: number;
    /**
     * 该位置是否在国外（此属性不是精确计算，不能用于边界区域）
     * @since 1.0.0
     */
    readonly isAbroad: boolean;
    /**
     * 构造一个CameraPosition 对象。
     *
     * @param target  目标位置的屏幕中心点经纬度坐标。
     * @param zoom    目标可视区域的缩放级别。
     * @param tilt    目标可视区域的倾斜度，以角度为单位。
     * @param bearing 可视区域指向的方向，以角度为单位，从正北向顺时针方向计算，从0度到360度。
     * @throws NullPointerException     如果传入的目标位置为null，则抛出NullPointerException
     * @throws IllegalArgumentException 如果倾斜度超过0到90度的区域，则抛出IllegalArgumentException。
     * @since 1.0.0
     */
    constructor(target: LatLng, zoom: number, tilt: number, bearing: number);
    /**
     * 根据传入的经纬度、缩放级别构造一个CameraPosition 对象。这个CameraPosition
     * 对象指向正北，并且可视区域的视角垂直于地图。
     *
     * @param target 目标位置的屏幕中心点坐标经纬度。
     * @param zoom   目标位置的缩放级别。
     * @return 一个CameraPosition对象。
     * @since 1.0.0
     */
    static fromLatLngZoom(target: LatLng, zoom: number): CameraPosition;
    /**
     * 创建一个CameraPosition.Builder 对象
     *
     * @since 1.0.0
     */
    static builder(): Builder;
    /**
     * 根据传入的CameraPosition 创建一个CameraPosition.Builder 对象。
     *
     * @param camera 传入的CameraPosition对象。
     * @return 一个CameraPosition.Builder对象。
     * @since 1.0.0
     */
    static builder(camera: CameraPosition): Builder;
}
/**
 * 创建一个摄像机的位置。
 *
 * @since 1.0.0
 */
export declare class Builder {
    private aTarget;
    private aZoom;
    private aTilt;
    private aBearing;
    /**
     * 构造一个新的CameraPosition对象。
     */
    constructor();
    /**
     * 根据给定的参数构造一个CameraPosition的新对象。
     *
     * @param previous 一个CameraPosition对象。
     * @since 1.0.0
     */
    constructor(previous: CameraPosition);
    /**
     * 设置目标位置的地图中心点经纬度坐标。
     *
     * @param location 目标位置的地图中心点经纬度坐标。
     * @return Builder对象。
     * @since 1.0.0
     */
    target(location: LatLng): Builder;
    /**
     * 设置目标可视区域的缩放级别。
     *
     * @param zoom 目标可视区域的缩放级别。
     * @return Builder的对象。
     * @since 1.0.0
     */
    zoom(zoom: number): Builder;
    /**
     * 设置目标可视区域的倾斜度
     *
     * @param tilt 目标可视区域的倾斜度，以角度为单位。
     * @return Builder对象。
     * @since 1.0.0
     */
    tilt(tilt: number): Builder;
    /**
     * 设置可视区域的旋转方向，以角度为单位，正北方向到地图方向逆时针旋转的角度，范围从0度到360度
     *
     * @param bearing 可视区域的旋转方向，以角度为单位，正北方向到地图方向逆时针旋转的角度，范围从0度到360度
     * @return Builder对象。
     * @since 1.0.0
     */
    bearing(bearing: number): Builder;
    /**
     * 构造一个CameraPosition 对象。
     *
     * @return 新创建的CameraPosition对象。
     * @since 1.0.0
     */
    build(): CameraPosition;
}
