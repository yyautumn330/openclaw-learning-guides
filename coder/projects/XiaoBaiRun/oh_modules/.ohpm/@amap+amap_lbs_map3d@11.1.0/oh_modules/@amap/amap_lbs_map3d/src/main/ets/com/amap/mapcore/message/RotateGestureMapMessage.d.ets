// @keepTs
// @ts-nocheck
import { x59 } from '../interface/IGLMapState';
import { p72 } from './AbstractGestureMapMessage';
export declare class r130 extends p72 {
    o178: number;
    p178: number;
    f177: number;
    private static readonly j26;
    static obtain(state: number, degree: number, m178: number, n178: number): r130;
    recycle(): void;
    static h177(): void;
    private g177;
    constructor(state: number, degree: number, n342: number, o342: number);
    getType(): number;
    y111(b178: x59): void;
}
