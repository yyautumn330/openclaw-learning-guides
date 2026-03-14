// @keepTs
// @ts-nocheck
import { Context as Context } from "@ohos.abilityAccessCtrl";
import { p66 } from '../interface/IAMapNativeDelegate';
import { u107 } from '../interface/bridge/ICompassViewBridge';
export declare class w166 {
    private g102;
    private context;
    private imageSource?;
    private m274?;
    private u109;
    private viewWidth;
    private viewHeight;
    private k57;
    h177(): void;
    private initResource;
    constructor(context: Context, map: p66, x342: u107);
    n274(): void;
    g91(enable: boolean): void;
}
