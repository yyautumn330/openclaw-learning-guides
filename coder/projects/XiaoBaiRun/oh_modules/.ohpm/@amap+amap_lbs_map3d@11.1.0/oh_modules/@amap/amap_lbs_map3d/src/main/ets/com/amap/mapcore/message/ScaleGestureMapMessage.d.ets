// @keepTs
// @ts-nocheck
import { x59 } from '../interface/IGLMapState';
import { p72 } from './AbstractGestureMapMessage';
export declare class t130 extends p72 {
    f179: number;
    o178: number;
    p178: number;
    private static readonly j26;
    static obtain(state: number, scale: number, d179: number, e179: number): t130;
    recycle(): void;
    static h177(): void;
    private g177;
    constructor(state: number, scale: number, p342: number, q342: number);
    getType(): number;
    y111(u178: x59): void;
    private d90;
}
