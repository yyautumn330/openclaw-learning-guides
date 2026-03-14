// @keepTs
// @ts-nocheck
import { LatLng } from '../api/model/LatLng';
import { Point } from '../api/model/Point';
import { VisibleRegion } from '../api/model/VisibleRegion';
import { z48 } from '../mapcore/AMapCallback';
import { a49 } from '../mapcore/interface/IProjection';
import { x52 } from './interface/IAMapJsCall';
import { LatLngBounds } from '../api/model/LatLngBounds';
import { AMapCameraInfo } from '../api/model/AMapCameraInfo';
import { TileProjection } from '../api/model/TileProjection';
export declare class d60 implements a49 {
    private f56;
    constructor(u213: x52);
    fromScreenLocationSync(t213: Point): LatLng;
    toScreenLocationSync(s213: LatLng): Point;
    toMapLocation(r213: LatLng): Point;
    getVisibleRegion(): VisibleRegion;
    k49(q213: number): number;
    fromBoundsToTile(p213: LatLngBounds, zoom: number, width: number): TileProjection;
    getMapBounds(center: LatLng, zoom: number): LatLngBounds;
    t167(): AMapCameraInfo;
    l49(target: LatLng, o213: number): number;
    fromScreenLocation(n213: Point, callback: z48<LatLng>): void;
    toScreenLocation(m213: LatLng, callback: z48<Point>): void;
}
