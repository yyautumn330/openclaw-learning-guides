// @keepTs
// @ts-nocheck
import { IAMap } from "./interface/IAMap";
import { s11 } from "./interface/IMapFragmentDelegate";
export declare class t11 implements s11 {
    private j172;
    private static readonly k172;
    private static readonly l172;
    private static LINE;
    static readonly z11 = 0;
    private l2?;
    private options?;
    static readonly m172: string;
    private f172;
    x11(): IAMap;
    onCreate(): void;
    onResume(): void;
    onPause(): void;
    onDestroy(): void;
    d65(flag: boolean): void;
    constructor(i172: number);
    o172(outState: Map<string, [
    ]>): void;
    private n172;
}
