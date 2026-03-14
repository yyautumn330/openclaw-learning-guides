// @keepTs
// @ts-nocheck
import { Point } from '../../model/Point';
export declare class IPoint extends Point {
    private static readonly j26;
    static obtain(x?: number, y?: number): IPoint;
    set(x: number, y: number): void;
    recycle(): void;
    constructor(t49?: number, u49?: number);
    clone(): object | undefined;
    distance(point: IPoint): number;
}
