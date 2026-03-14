// @keepTs
// @ts-nocheck
import { z59 } from '../interface/IAMapJsCallback';
import { d12 } from '../interface/bridge/IMapViewBridge';
export declare class AMapJsCallbackBridge {
    private aMapJsCallback?;
    private aMapJsCallbackProxy;
    constructor();
    setAMapJsCallback(callback: z59): void;
    initAMapJsCallback(l271: d12): void;
}
/**
 * js回调壳
 *
 * 鸿蒙系统不支持在回调中直接操作方法和属性，需要转接
 *
 */
export declare class AMapJsCallbackProxy implements z59 {
    private aMapJsCallback?;
    setRealAMapJsCallback(callback: z59): void;
    log(info: string): void;
    initWorker(): void;
    nativeCall(k271: string, params: string[]): void;
    onMapRenderComplete(): void;
    onMapLoadComplete(): void;
    onMapClick(i271: number, j271: number): void;
    onPolylineClick(h271: string): void;
    onMarkerClick(g271: string): void;
    onMarkerDragstart(d271: string, e271: number, f271: number): void;
    onMarkerDragging(a271: string, b271: number, c271: number): void;
    onMarkerDragend(x270: string, y270: number, z270: number): void;
    onMapChange(v270: number, w270: number, zoom: number, bearing: number, tilt: number): void;
    onMapChangeFinish(t270: number, u270: number, zoom: number, bearing: number, tilt: number): void;
    onMapBoundsChange(p270: number, q270: number, r270: number, s270: number): void;
}
