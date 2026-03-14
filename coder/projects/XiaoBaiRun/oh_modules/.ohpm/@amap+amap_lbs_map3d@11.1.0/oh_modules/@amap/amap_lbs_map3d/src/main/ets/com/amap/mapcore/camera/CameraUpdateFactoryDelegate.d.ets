// @keepTs
// @ts-nocheck
import { CameraPosition } from '../../api/model/CameraPosition';
import { LatLng } from '../../api/model/LatLng';
import { LatLngBounds } from '../../api/model/LatLngBounds';
import { Point } from '../../api/model/Point';
import { b7 } from '../interface/ICameraUpdateFactory';
import { v6 } from './AbstractCameraUpdateMessage';
/**
 *  相机更新状态实现
 */
export declare class a7 implements b7 {
    private static readonly TAG;
    constructor();
    zoomIn(): v6;
    zoomOut(): v6;
    scrollBy(j114: number, k114: number): v6;
    zoomTo(zoom: number): v6;
    zoomBy(amount: number): v6;
    zoomBy(amount: number, focus: Point): v6;
    newCameraPosition(cameraPosition: CameraPosition): v6;
    /**
     * 只修改中心点
     *
     * @param geo
     * @return
     */
    o114(c114: Point): v6;
    /**
     * 只修改中心点
     *
     * @param geo
     * @return
     */
    changeLatLng(a114: LatLng): v6;
    /**
     * 只修改仰角
     *
     * @param tilt
     * @return
     */
    changeTilt(tilt: number): v6;
    /**
     * 只调整旋转角度
     *
     * @param angle
     * @return
     */
    changeBearing(angle: number): v6;
    changeBearingGeoCenter(angle: number, v113: Point): v6;
    /**
     * 只调整中心点和级别
     *
     * @param geo
     * @param zoom
     * @return
     */
    changeGeoCenterZoom(t113: Point, zoom: number): v6;
    newLatLng(latLng: LatLng): v6;
    newLatLngZoom(latLng: LatLng, zoom: number): v6;
    p114(zoom: number, bearing: number, tilt: number, r113: Point | LatLng): v6 | undefined;
    newLatLngBounds(bounds: LatLngBounds, padding: number): v6;
    newLatLngBoundsWithSize(bounds: LatLngBounds, width: number, height: number, padding: number): v6;
    newLatLngBoundsRect(j113: LatLngBounds, k113: number, l113: number, m113: number, n113: number): v6;
    j7(): v6;
}
