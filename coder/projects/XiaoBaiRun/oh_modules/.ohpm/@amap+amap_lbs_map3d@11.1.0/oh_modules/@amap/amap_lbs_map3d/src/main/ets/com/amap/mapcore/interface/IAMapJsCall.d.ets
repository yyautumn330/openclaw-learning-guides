// @keepTs
// @ts-nocheck
import { CameraUpdate } from '../../api/CameraUpdate';
import { LatLng } from '../../api/model/LatLng';
export type m110<T> = (t: T) => void;
export interface x52 {
    init(): void;
    z65(): void;
    onDestroy(): void;
    k64(overlayName: string, baseOptions: string): void;
    i162(overlayName: string, baseOptions: string): void;
    removeOverlay(overlayName: string): void;
    moveCamera(cameraUpdate: CameraUpdate, isAnimate: boolean, curZoom: number): void;
    stopAnimation(): void;
    y58(updateType: number, options: string): void;
    k166(): void;
    l166(): void;
    v37(x: number, y: number, dp: m110<string>): void;
    d92(lat: number, lng: number, dp: m110<string>): void;
    b59(type: number, mapStyle: string): void;
    setMapStatusLimits(northeast: LatLng, southwest: LatLng): void;
    f65(minZoomLevel: number, maxZoomLevel: number): void;
    setScrollGesturesEnabled(enabled: boolean): void;
    setRotateGesturesEnabled(enabled: boolean): void;
    setTiltGesturesEnabled(enabled: boolean): void;
    setZoomGesturesEnabled(enabled: boolean): void;
    setGestureScaleByMapCenter(isGestureScaleByMapCenter: boolean): void;
    setTrafficEnabled(enabled: boolean): void;
    g65(enabled: boolean): void;
    h65(enabled: boolean): void;
    m166(): void;
}
