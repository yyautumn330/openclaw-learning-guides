// @keepTs
// @ts-nocheck
import common from "@ohos.app.ability.common";
import { p66 } from './interface/IAMapNativeDelegate';
export declare class e73 {
    private static g101;
    private static readonly TAG;
    private context;
    private h101;
    private i101;
    protected j101?: p66;
    static c89: number;
    static k101: number;
    static s94: number;
    private l101;
    constructor(context: common.Context);
    e89(reference: p66): void;
    u63(delay: number): void;
    /**
     * 获取鉴权状态
     *
     * @return
     */
    b89(): number;
    destroy(): void;
    private m101;
    private n101;
    private q101;
    private p101;
}
export declare class t100 {
    info: string;
    z101: string;
    status: string;
    o101: boolean;
}
