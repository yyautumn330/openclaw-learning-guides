// @keepTs
// @ts-nocheck
import { DPoint } from "./DPoint";
export declare class p23 {
    readonly minX: number;
    readonly maxX: number;
    readonly minY: number;
    readonly maxY: number;
    readonly midX: number;
    readonly midY: number;
    constructor(q23: number, r23: number, s23: number, t23: number);
    contains(x: number, y: number): boolean;
    u23(bounds: p23): boolean;
    v23(point: DPoint): boolean;
    intersects(other: p23): boolean;
}
