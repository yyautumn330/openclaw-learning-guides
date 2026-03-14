// @keepTs
// @ts-nocheck
/**
 * 统一回调管理类
 */
import ArrayList from '@ohos.util.ArrayList';
import * as AMap from '../api/AMap';
import { a66 } from './widget/AMapWidgetListener';
type b66 = AMap.OnCameraChangeListener | AMap.OnMapClickListener | AMap.OnMapPOIClickListener | AMap.OnMapTouchListener | AMap.OnMapLongClickListener | AMap.OnMapTouchListener | AMap.OnMapReadyListener | AMap.OnMarkerClickListener | AMap.OnMarkerDragListener | AMap.OnPolylineClickListener | AMap.OnInfoWindowClickListener | AMap.OnMyLocationChangeListener | AMap.InfoWindowListener | AMap.AMapAppResourceRequestListener | AMap.OnMapScreenShotListener | AMap.AMapGestureListener | a66;
export declare class c66<T extends b66> {
    j66: ArrayList<T>;
    setListener?: T;
}
export declare class a60 {
    private k66;
    addListener<T extends b66>(key: number, listener: T): void;
    removeListener<T extends b66>(key: number, listener?: T): void;
    l66<T extends b66>(key: number): void;
    m66<T extends b66>(key: number): ArrayList<b66>;
    setListener<T extends b66>(key: number, listener: T): void;
    clear<T extends b66>(): void;
}
export {};
