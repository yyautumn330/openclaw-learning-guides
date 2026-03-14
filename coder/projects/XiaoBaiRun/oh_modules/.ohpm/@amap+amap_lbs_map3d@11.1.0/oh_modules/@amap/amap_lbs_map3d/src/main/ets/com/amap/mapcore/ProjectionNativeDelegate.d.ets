// @keepTs
// @ts-nocheck
import { LatLng } from '../api/model/LatLng';
import { Point } from '../api/model/Point';
import { z48 } from './AMapCallback';
import { p66 } from './interface/IAMapNativeDelegate';
import { a49 } from './interface/IProjection';
import { LatLngBounds } from '../api/model/LatLngBounds';
import { VisibleRegion } from '../api/model/VisibleRegion';
import { TileProjection } from '../api/model/TileProjection';
import { AMapCameraInfo } from '../api/model/AMapCameraInfo';
export declare class o72 implements a49 {
    private l2;
    constructor(s214: p66);
    toMapLocation(q214: LatLng): Point;
    getVisibleRegion(): VisibleRegion;
    k49(p214: number): number;
    fromBoundsToTile(f214: LatLngBounds, zoom: number, g214: number): TileProjection;
    getMapBounds(center: LatLng, zoom: number): LatLngBounds;
    t167(): AMapCameraInfo;
    l49(target: LatLng, c214: number): number;
    fromScreenLocationSync(a214: Point): LatLng;
    toScreenLocationSync(z213: LatLng): Point;
    fromScreenLocation(y213: Point, callback: z48<LatLng>): void;
    toScreenLocation(x213: LatLng, callback: z48<Point>): void;
}
