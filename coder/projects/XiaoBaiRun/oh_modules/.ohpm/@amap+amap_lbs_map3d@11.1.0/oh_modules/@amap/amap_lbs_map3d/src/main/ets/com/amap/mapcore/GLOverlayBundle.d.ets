// @keepTs
// @ts-nocheck
import { j73 } from "./BaseMapOverlay";
import { h157 } from "./GLOverlayTexture";
import { i73 } from "./GLOverlay";
import { p66 } from "./interface/IAMapNativeDelegate";
export declare class k73<A extends i73, E extends j73<A, object>> {
    static q158(p158: number[], color: number): void;
    private r158;
    private m146;
    private s158;
    private f93;
    constructor(n158: number, o158: p66);
    t158(): number;
    u158(overlay: E): boolean;
    v158(index: number): E | null;
    private w158;
    k64(overlay: E): void;
    a157(): void;
    removeOverlay(overlay: E): void;
    g107(j158: boolean): void;
    clearFocus(): void;
    onSingleTap(d158: number, e158: number, f158: number, flag: number): boolean;
    private x158;
    private y158;
    z158(u157: number, v157: number): number;
    a159(r157: number, s157: number): number;
    b159(q157: number): h157 | undefined;
    c159(o157: number, anchor: number, width: number, height: number): boolean;
    k94(k157: number, anchor: number, l157: number, m157: number, width: number, height: number): boolean;
    d159(): void;
    e159(j157: p66): void;
}
export declare class i157 {
    f159: number;
    g159: number;
    h159: number;
}
