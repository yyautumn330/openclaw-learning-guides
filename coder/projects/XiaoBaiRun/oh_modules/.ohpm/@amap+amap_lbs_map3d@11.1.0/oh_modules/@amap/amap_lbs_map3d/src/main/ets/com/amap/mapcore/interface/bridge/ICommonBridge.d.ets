// @keepTs
// @ts-nocheck
import { k60 } from '../../gesture/AMapGestureBridge';
import { p107 } from '../../widget/InfoWindowStateCallback';
import { IAMap } from '../IAMap';
export interface o107 {
    getContext(): Context;
    q63(map: IAMap): void;
    r63(gestureBridge: k60): void;
    j14(customBuilder: CustomBuilder): void;
    j89(): CustomBuilder | undefined;
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
