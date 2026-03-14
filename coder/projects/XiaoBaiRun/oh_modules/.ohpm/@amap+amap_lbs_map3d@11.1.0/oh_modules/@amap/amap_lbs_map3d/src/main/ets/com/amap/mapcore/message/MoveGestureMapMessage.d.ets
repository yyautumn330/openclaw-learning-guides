// @keepTs
// @ts-nocheck
import { x59 } from '../interface/IGLMapState';
import { p72 } from './AbstractGestureMapMessage';
export declare class q130 extends p72 {
    q177: number;
    r177: number;
    s177: number;
    t177: number;
    protected static u177: number;
    private static readonly j26;
    static obtain(state: number, x: number, y: number, tx: number, ty: number): q130;
    recycle(): void;
    static h177(): void;
    private g177;
    constructor(state: number, x: number, y: number);
    getType(): number;
    y111(l177: x59): void;
}
