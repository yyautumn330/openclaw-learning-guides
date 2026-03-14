// @keepTs
// @ts-nocheck
import { Point } from '../../api/model/Point';
export interface x59 {
    onMapChange(lat: number, lng: number, zoom: number, bearing: number, tilt: number): void;
    onMapBoundsChange(n_lat: number, n_lng: number, s_lat: number, s_lng: number): void;
    d90(mapZoom: number): void;
    m88(): number;
    o88(): number;
    q88(): number;
    b92(xPixel: number, yPixel: number, point: Point): void;
    i92(x: number, y: number, fpoint: Point): void;
    i88(): Point;
    recycle(): void;
    q92(mapAngle: number): void;
    g92(cameraDegree: number): void;
    h92(): void;
    f90(geoX: number, geoY: number): void;
    v154(centerX: number, centerY: number, pntX: number, pntY: number, screenY: number): number;
    p95(screenWidth: number, screenHeight: number, densityDpi: number): number;
    n152(engineId: number, engineInstance: bigint): void;
    a71(): bigint;
    s142(winPixelLen: number): number;
    t92(screenunit: number): number;
    getViewMatrix(viewMatrix: Float64Array): void;
    getProjectionMatrix(projMatrix: Float64Array): void;
    s88(): number;
}
