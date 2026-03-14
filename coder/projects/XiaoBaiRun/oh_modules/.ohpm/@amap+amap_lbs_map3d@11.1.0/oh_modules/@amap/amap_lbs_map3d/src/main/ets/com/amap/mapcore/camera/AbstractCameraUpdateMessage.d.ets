// @keepTs
// @ts-nocheck
import { CancelableCallback } from '../../api/AMap';
import { CameraPosition } from '../../api/model/CameraPosition';
import { LatLngBounds } from '../../api/model/LatLngBounds';
import { Point } from '../../api/model/Point';
import { s60 } from '../interface/IGLMapEngine';
import { x59 } from '../interface/IGLMapState';
import { b53 } from '../MapConfig';
/**
 * camera更新消息接口
 */
export declare abstract class v6 {
    u95?: t72;
    m112: number;
    n112: number;
    amount: number;
    cameraPosition?: CameraPosition;
    bounds?: LatLngBounds;
    focus?: Point;
    zoom: number;
    tilt: number;
    bearing: number;
    z6: Point;
    w92: boolean;
    a96: number;
    b96: number;
    y95: boolean;
    paddingLeft: number;
    paddingRight: number;
    paddingTop: number;
    paddingBottom: number;
    d20: number;
    c96: b53;
    maxZoomLevel: number;
    minZoomLevel: number;
    z112: number;
    width: number;
    height: number;
    e96?: CancelableCallback;
    abstract x95(y112: v6): void;
    abstract y111(x112: x59): void;
    protected b112(w112: x59): void;
    protected c113(t112: x59, u112: Point, x: number, y: number): void;
    protected b113(r112: x59, x: number, y: number): Point;
    d113(o112: s60): void;
}
/**
 * camera 要执行的操作
 */
export declare enum t72 {
    /**
     * 空，默认无效值
     */
    none = 0,
    /**
     * 放大一级
     */
    zoomIn = 1,
    /**
     * 只修改中心点 geoPoint有效
     */
    changeCenter = 2,
    /**
     * 只调整仰角
     */
    changeTilt = 3,
    /**
     * 只旋转
     */
    changeBearing = 4,
    changeBearingGeoCenter = 5,
    /**
     * 改变中心点和级别
     */
    changeGeoCenterZoom = 6,
    /**
     * 缩小一级
     */
    zoomOut = 7,
    /**
     * 缩放到指定级别
     */
    zoomTo = 8,
    /**
     * 按偏移缩放
     */
    zoomBy = 9,
    /**
     * 按像素移动
     */
    scrollBy = 10,
    /**
     * 改变所有状态，中心点用经纬度
     */
    newCameraPosition = 11,
    /**
     * 根据bounds移动
     */
    newLatLngBounds = 12,
    /**
     * 根据bounds+ padding移动
     */
    newLatLngBoundsWithSize = 13,
    /**
     * 改变所有状态，中心点用geo坐标
     */
    changeGeoCenterZoomTiltBearing = 14
}
