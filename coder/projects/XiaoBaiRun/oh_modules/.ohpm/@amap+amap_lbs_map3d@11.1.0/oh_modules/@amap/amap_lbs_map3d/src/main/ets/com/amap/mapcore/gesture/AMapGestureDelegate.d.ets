// @keepTs
// @ts-nocheck
import { a60 } from '../AmapDelegateListenerManager';
import { IAMap } from '../interface/IAMap';
import { e60 } from '../interface/IAMapGesture';
import { d16 } from '../interface/IGLOverlayLayer';
export declare class f60 implements e60 {
    private readonly f130;
    private readonly g130;
    private readonly glOverlayLayer;
    private readonly r107;
    private h130;
    private i130;
    /**
     * 辅助判断CameraChangeFinish回调
     */
    private b63;
    constructor(map: IAMap, context: Context, d130: a60, e130: d16);
    onTouchEvent(event: TouchEvent): boolean;
    /**
     * 手势监听绑定
     */
    private k130;
    /**
     * 手势操作开始
     */
    private u87;
    /**
     * 手势操作结束
     */
    private v87;
    onSingleTap(e: GestureEvent): void;
    onLongPress(e: GestureEvent): void;
    onDoubleTap(e: GestureEvent): boolean;
    t14(state: number, event: GestureEvent): void;
    o14(state: number, event: GestureEvent): void;
    s14(state: number, event: GestureEvent): void;
}
