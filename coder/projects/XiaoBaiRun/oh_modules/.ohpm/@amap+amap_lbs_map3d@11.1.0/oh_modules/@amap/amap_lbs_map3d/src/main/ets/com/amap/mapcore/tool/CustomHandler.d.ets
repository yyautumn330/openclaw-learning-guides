// @keepTs
// @ts-nocheck
import HashMap from "@ohos.util.HashMap";
export declare class c102 {
    p102: number;
    data?: object;
    bundle?: HashMap<string, ESObject>;
    constructor(i234: number, data?: object, bundle?: HashMap<string, ESObject>);
}
export declare class b102 {
    j234: x233;
    constructor(h234: (message: c102) => void);
    sendMessage(message: c102, g234?: number): void;
    t102(e234: number, f234?: number): void;
    k234(d234: number): void;
    l234(): void;
}
declare class x233 {
    k229: HashMap<number, number[]>;
    m234: (message: c102) => void;
    constructor(c234: (message: c102) => void);
    sendMessage(message: c102, b234?: number): void;
    t102(z233: number, a234?: number): void;
    k234(y233: number): void;
    l234(): void;
}
export {};
