// @keepTs
// @ts-nocheck
import { Point } from '../api/model/Point';
import { x59 } from './interface/IGLMapState';
export declare class s72 implements x59 {
    private k156;
    private z151;
    private l156;
    private engineId;
    constructor(h156: number, i156: bigint, j156: bigint);
    constructor(f156: number, g156: bigint);
    onMapChange(a156: number, b156: number, zoom: number, bearing: number, tilt: number): void;
    onMapBoundsChange(w155: number, x155: number, y155: number, z155: number): void;
    d90(v155: number): void;
    s88(): number;
    m88(): number;
    o88(): number;
    q88(): number;
    b92(s155: number, t155: number, point: Point): void;
    i92(x: number, y: number, q155: Point): void;
    i88(): Point;
    recycle(): void;
    reset(): void;
    q92(p155: number): void;
    g92(o155: number): void;
    h92(): void;
    f90(m155: number, n155: number): void;
    v154(centerX: number, centerY: number, k155: number, l155: number, screenY: number): number;
    p95(screenWidth: number, screenHeight: number, j155: number): number;
    n152(h155: number, i155: bigint): void;
    a71(): bigint;
    getViewMatrix(viewMatrix: Float64Array): void;
    getProjectionMatrix(c155: Float64Array): void;
    s142(b155: number): number;
    t92(a155: number): number;
    static lonlat2Geo(x154: number, y154: number, z154: Point): void;
    static geo2LonLat(x: number, y: number, w154: Point): void;
}
