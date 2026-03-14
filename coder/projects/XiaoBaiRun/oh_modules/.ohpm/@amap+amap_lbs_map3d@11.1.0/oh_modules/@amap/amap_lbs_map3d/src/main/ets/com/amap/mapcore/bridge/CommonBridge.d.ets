// @keepTs
// @ts-nocheck
import { k60 } from '../gesture/AMapGestureBridge';
import { IAMap } from '../interface/IAMap';
import { o107 } from '../interface/bridge/ICommonBridge';
import { p107 } from '../widget/InfoWindowStateCallback';
export declare class e12 implements o107 {
    private context;
    private r107?;
    private o63?;
    private s107?;
    private t107?;
    constructor(context: Context);
    j89(): CustomBuilder | undefined;
    j14(customBuilder: CustomBuilder): void;
    getContext(): Context;
    q63(map: IAMap): void;
    r63(q107: k60): void;
    h14(callback: p107): void;
    k90(): p107 | undefined;
    onCreate(): void;
    onResume(): void;
    onPause(): void;
    onDestroy(): void;
    onTouch(event: TouchEvent): void;
    onSingleTap(event: GestureEvent): void;
    onDoubleTap(event: GestureEvent): void;
    onLongPress(event: GestureEvent): void;
    t14(state: number, event: GestureEvent): void;
    o14(state: number, event: GestureEvent): void;
    s14(state: number, event: GestureEvent): void;
}
