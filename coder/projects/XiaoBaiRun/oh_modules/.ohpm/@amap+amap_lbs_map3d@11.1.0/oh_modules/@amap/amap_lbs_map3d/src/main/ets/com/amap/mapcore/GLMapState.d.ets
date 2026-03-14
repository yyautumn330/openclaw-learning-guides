// @keepTs
// @ts-nocheck
import { Point } from '../api/model/Point';
import { IAMap } from './interface/IAMap';
import { x59 } from './interface/IGLMapState';
import { d16 } from './interface/IGLOverlayLayer';
import { b53 } from './MapConfig';
/**
 * 地图状态
 */
export declare class y59 implements x59 {
    private readonly r107;
    private readonly glOverlayLayer;
    private readonly c96;
    private u154?;
    constructor(r154: IAMap, s154: d16, t154: b53);
    getProjectionMatrix(q154: Float64Array): void;
    s88(): number;
    getViewMatrix(viewMatrix: Float64Array): void;
    s142(p154: number): number;
    t92(o154: number): number;
    i92(x: number, y: number, n154: Point): void;
    a71(): bigint;
    p95(screenWidth: number, screenHeight: number, m154: number): number;
    d90(l154: number): void;
    m88(): number;
    o88(): number;
    q88(): number;
    b92(j154: number, k154: number, point: Point): void;
    i88(): Point;
    recycle(): void;
    q92(i154: number): void;
    g92(h154: number): void;
    h92(): void;
    f90(f154: number, g154: number): void;
    v154(centerX: number, centerY: number, d154: number, e154: number, screenY: number): number;
    private z87;
    /**
     * 地图状态变更回调
     */
    onMapChange(z153: number, a154: number, zoom: number, bearing: number, tilt: number): void;
    onMapBoundsChange(v153: number, w153: number, x153: number, y153: number): void;
    n152(t153: number, u153: bigint): void;
}
