// @keepTs
// @ts-nocheck
import { p66 } from './interface/IAMapNativeDelegate';
import { e68 } from './interface/IGLMapRender';
export declare class f68 implements e68 {
    static readonly o68: number;
    static readonly p68: number;
    static readonly q68: number;
    static readonly r68: number;
    private static readonly s68;
    static readonly t68: number;
    static readonly u68: number;
    static readonly v68: number;
    static readonly w68: number;
    /**
     * 最小间隔，相当于最大刷新频率为100
     */
    protected static readonly x68: number;
    /**
     * 不卡后过几帧恢复，恢复耗时为 LAG_TICK_COUNT * （1000 / renderFps）
     */
    protected static readonly y68: number;
    /**
     * 卡顿(渲染时间长于当前帧率对应的时间)的标志
     */
    private z68;
    private a69;
    private b69;
    private c69;
    private d69;
    private e69;
    private f69;
    private g69;
    private h69;
    private i69;
    private j69;
    private k69;
    private l69;
    private m69;
    n69(): boolean;
    o69(): number;
    p69(): void;
    private q69;
    constructor(r342: p66);
    t69(flag: boolean): void;
    u69(count: number): void;
    setRenderFps(fps: number): void;
    private v69;
    w64(): void;
    b16(): void;
    w69(): boolean;
}
