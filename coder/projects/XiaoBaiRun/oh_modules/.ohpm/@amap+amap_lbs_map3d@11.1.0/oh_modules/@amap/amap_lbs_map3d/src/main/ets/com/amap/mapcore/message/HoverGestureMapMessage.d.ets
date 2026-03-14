// @keepTs
// @ts-nocheck
import { x59 } from '../interface/IGLMapState';
import { p72 } from './AbstractGestureMapMessage';
/**
 * 仰角手势事件
 */
export declare class p130 extends p72 {
    f177: number;
    private static readonly j26;
    static obtain(state: number, degree: number): p130;
    recycle(): void;
    static h177(): void;
    private g177;
    constructor(state: number, degree: number);
    getType(): number;
    y111(e177: x59): void;
}
