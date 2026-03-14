// @keepTs
// @ts-nocheck
import { j109 } from '../interface/bridge/IScaleViewBridge';
import { p66 } from '../interface/IAMapNativeDelegate';
export declare class y166 {
    static readonly b38: number;
    static readonly k266: number;
    static readonly p266: number;
    static readonly u266: number;
    private context;
    private v280;
    private v109;
    private w280;
    private x280;
    private y280;
    private geoCenter;
    private z280?;
    private viewWidth;
    private viewHeight;
    private readonly a281;
    h177(): void;
    constructor(context: Context, s280: p66, t280: j109);
    private draw;
    b281(text: string): void;
    c281(length: number): void;
    g91(enable: boolean): void;
    w279(): void;
}
