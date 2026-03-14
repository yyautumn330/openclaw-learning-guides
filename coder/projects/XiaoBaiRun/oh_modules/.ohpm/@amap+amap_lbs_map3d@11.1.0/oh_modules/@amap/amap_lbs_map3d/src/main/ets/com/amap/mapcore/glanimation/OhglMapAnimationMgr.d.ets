// @keepTs
// @ts-nocheck
import { i137 } from './AbstractOhglAnimation';
import { CancelableCallback } from '../../api/AMap';
import { x59 } from '../interface/IGLMapState';
export declare class r140 {
    private list;
    private z140?;
    private a141?;
    constructor();
    b141(): void;
    a65(): void;
    c141(): number;
    d141(x140: x59): void;
    addAnimation(u140: i137, v140: CancelableCallback | undefined): void;
    h141(): CancelableCallback | undefined;
    i141(t140: s140): void;
}
/**
 * 动画监听
 */
export interface s140 {
    /**
     * 动画完成回调
     * @param cancelableCallback 取消监听，取消中有finish 如果是取消的也需要调用取消的finish
     */
    e141(cancelableCallback: CancelableCallback | undefined): void;
}
