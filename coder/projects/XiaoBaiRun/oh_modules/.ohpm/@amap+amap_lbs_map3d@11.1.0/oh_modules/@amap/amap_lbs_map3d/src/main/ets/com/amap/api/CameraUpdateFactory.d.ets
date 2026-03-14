// @keepTs
// @ts-nocheck
import { CameraPosition } from './model/CameraPosition';
import { CameraUpdate } from './CameraUpdate';
import { LatLng } from './model/LatLng';
import { LatLngBounds } from './model/LatLngBounds';
import { Point } from './model/Point';
/**
 * 创建CameraUpdate 对象,用来改变地图状态。<br>
 * 调用 {@link AMap#animateCamera(CameraUpdate)} or {@link AMap#moveCamera(CameraUpdate)}。
 * @since 1.0.0
 */
export declare class CameraUpdateFactory {
    private static readonly CLASSNAME;
    private static cameraUpdateFactoryDelegate;
    /**
     * 放大地图缩放级别，在当前地图显示的级别基础上加1。
     *
     * @return 包含缩放级别改变的cameraUpdate对象.
     * @since 1.0.0
     */
    static zoomIn(): CameraUpdate;
    /**
     * 缩小地图缩放级别，在当前地图显示的级别基础上减1。
     *
     * @return 包含缩放级别改变的cameraUpdate对象。
     * @since 1.0.0
     */
    static zoomOut(): CameraUpdate;
    /**
     * 设置地图缩放级别。
     *
     * @param zoom 地图缩放级别。
     * @return 包含指定缩放级别的cameraUpdate对象
     * @since 1.0.0
     */
    static zoomTo(zoom: number): CameraUpdate;
    /**
     * 根据给定增量缩放地图级别，在当前地图显示的级别基础上加上这个增量。
     *
     * @param amount 地图缩放级别增量。
     * @return 包含指定缩放级别增量的cameraUpdate对象。
     * @since 1.0.0
     */
    static zoomBy(amount: number): CameraUpdate;
    /**
     * 根据给定增量并以给定的屏幕像素点为中心点缩放地图级别。
     *
     * @param amount 地图缩放级别增量。
     * @param focus  地图缩放中心点对应的屏幕坐标。
     * @return 包含指定缩放级别增量及中心点像素坐标的cameraUpdate对象。
     * @since 1.0.0
     */
    static zoomBy(amount: number, focus: Point): CameraUpdate;
    /**
     * 按像素移动地图中心点
     * @param xPixel 这是水平移动的像素数。正值代表可视区域向右移动，负值代表可视区域向左移动。
     * @param yPixel 这是垂直移动的像素数。正值代表可视区域向下移动，负值代表可视区域向上移动。
     * @return 包含x，y方向上移动像素数的cameraUpdate对象。
     * @since V2.0
     */
    static scrollBy(h7: number, i7: number): CameraUpdate;
    /**
     * 给地图设置一个新的状态。
     *
     * @param cameraPosition 新的地图状态。
     * @return 包含新的地图状态的cameraUpdate对象
     * @since 1.0.0
     */
    static newCameraPosition(cameraPosition: CameraPosition): CameraUpdate;
    /**
     * 设置地图的中心点。
     *
     * @param latLng 地图中心点。
     * @return 包含新的地图中心点的cameraUpdate对象。
     * @since 1.0.0
     */
    static newLatLng(latLng: LatLng): CameraUpdate;
    /**
     * 设置地图中心点以及缩放级别。
     *
     * @param latLng 地图中心点。
     * @param zoom   缩放级别，[3-20]。
     * @return 包含新的地图中心点及缩放级别的cameraUpdate对象。
     * @since 1.0.0
     */
    static newLatLngZoom(latLng: LatLng, zoom: number): CameraUpdate;
    /**
     * 设置显示在规定屏幕范围内的地图经纬度范围。
     。
     *
     * @param bounds   地图显示经纬度范围，不能为 null。
     * @param padding  设置经纬度范围和mapView边缘的空隙，单位像素。这个值适用于区域的四个边。
     * @return 包含新的经纬度范围及边缘间隙的cameraUpdate对象。
     * @since 1.0.0
     */
    static newLatLngBounds(bounds: LatLngBounds, padding: number): CameraUpdate;
    /**
     * 设置显示在规定宽高中的地图经纬度范围。
     *
     * @param bounds  地图显示经纬度范围。
     * @param width   限制区域的宽度，单位像素。
     * @param height  限制区域的高度，单位像素。
     * @param padding 经纬度范围与限制区域的边缘间隙，单位像素。
     * @return 包含经纬度范围及限制区域宽高的cameraUpdate对象
     * @since 1.0.0
     */
    static newLatLngBounds(bounds: LatLngBounds, padding: number, width: number, height: number): CameraUpdate;
    /**
     * 设置地图的中心点。
     *
     * @param latLng 地图中心点。
     * @return 包含新的地图中心点的cameraUpdate对象。
     * @since 1.0.0
     */
    static changeLatLng(latLng: LatLng): CameraUpdate;
    /**
     * 设置地图的旋转角度。
     *
     * @param bearing 地图旋转角度。以角度为单位，正北方向为0度，逆时针范围从0度到360度。
     * @return 包含新的地图旋转角度的cameraUpdate对象
     * @since 1.0.0
     */
    static changeBearing(bearing: number): CameraUpdate;
    /**
     * 设置地图倾斜度。
     *
     * @param tilt 地图倾斜度。以角度为单位，范围（0,60）。
     * @return 包含新的地图倾斜角度的cameraUpdate对象。
     * @since 1.0.0
     */
    static changeTilt(tilt: number): CameraUpdate;
    /**
     * 设置显示在规定屏幕范围内的地图经纬度范围。
     *
     * @param latlngbounds 地图显示经纬度范围。
     * @param paddingLeft 设置经纬度范围和mapView左边缘的空隙。
     * @param paddingRight 设置经纬度范围和mapView右边缘的空隙。
     * @param paddingTop 设置经纬度范围和mapView上边缘的空隙。
     * @param paddingBottom 设置经纬度范围和mapView下边缘的空隙。
     * @return 包含新的经纬度范围及边缘间隙的cameraUpdate对象。
     * @since 1.0.0
     */
    static newLatLngBoundsRect(c7: LatLngBounds, d7: number, e7: number, f7: number, g7: number): CameraUpdate;
}
