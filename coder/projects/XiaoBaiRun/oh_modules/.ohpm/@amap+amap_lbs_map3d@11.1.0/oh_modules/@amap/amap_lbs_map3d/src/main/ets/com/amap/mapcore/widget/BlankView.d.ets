// @keepTs
// @ts-nocheck
import { Context as Context } from "@ohos.abilityAccessCtrl";
import { p66 } from '../interface/IAMapNativeDelegate';
import { j107 } from '../interface/bridge/IBlankViewBridge';
/**
 * 空白的view，规避地图在切换到后台再次回来的时候，出现黑屏的问题。
 */
export declare class v166 {
    private context;
    private map;
    private s109;
    private visible;
    private color;
    h177(): void;
    constructor(context: Context, map: p66, g274: j107);
    setColor(color: string): void;
    g91(enable: boolean): void;
    isVisible(): boolean;
}
