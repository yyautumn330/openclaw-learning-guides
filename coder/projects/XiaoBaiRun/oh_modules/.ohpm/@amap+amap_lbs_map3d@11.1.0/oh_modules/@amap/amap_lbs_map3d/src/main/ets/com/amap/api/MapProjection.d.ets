// @keepTs
// @ts-nocheck
import { Point } from './model/Point';
export declare class MapProjection {
    static lonlat2Geo(l8: number, m8: number, n8: Point): void;
    static geo2LonLat(x: number, y: number, k8: Point): void;
}
