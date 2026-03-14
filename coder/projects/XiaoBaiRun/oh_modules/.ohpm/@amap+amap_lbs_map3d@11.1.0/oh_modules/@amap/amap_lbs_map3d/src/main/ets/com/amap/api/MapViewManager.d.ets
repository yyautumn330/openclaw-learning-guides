// @keepTs
// @ts-nocheck
import { MapView } from './MapView';
export type MapViewCreateCallback = (mapView?: MapView, mapViewName?: string) => void;
export declare enum MapViewStyle {
    LITE = "lite",
    NATIVE = "native"
}
/**
 * 地图mapview管理类
 */
export declare class MapViewManager {
    private static sInstance;
    private mapViewCreateCallbacks;
    private mapViewHashMap;
    private x15;
    private constructor();
    /**
     * 获取地图实例
     *
     * @returns 返回MapViewManager
     */
    static getInstance(): MapViewManager;
    /**
     * 注册地图mapview创建回调
     *
     * @param callback
     */
    registerMapViewCreatedCallback(callback: MapViewCreateCallback): void;
    /**
     * 反注册地图mapview创建回调
     * @param callback
     */
    unregisterMapViewCreatedCallback(callback: MapViewCreateCallback): void;
}
