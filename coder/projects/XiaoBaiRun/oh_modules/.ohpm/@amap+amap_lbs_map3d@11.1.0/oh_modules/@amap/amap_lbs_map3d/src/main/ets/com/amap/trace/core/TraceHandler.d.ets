// @keepTs
// @ts-nocheck
import HashMap from "@ohos.util.HashMap";
export declare class c102 {
    p102: number;
    a287?: number;
    b287?: number;
    obj?: object | string;
    o287?: y200;
    bundle?: HashMap<string, ESObject>;
    constructor(n287: number, obj?: object, bundle?: HashMap<string, ESObject>);
    p287: () => string;
}
declare class c287 {
    k229: HashMap<string, number[]>;
    m234: (message: c102) => void;
    constructor(m287: (message: c102) => void);
    sendMessage(message: c102, l287?: number): void;
    t102(j287: number, k287?: number): void;
    k234(i287: number): void;
    l234(): void;
}
export declare class y200 {
    j234: c287;
    constructor(h287?: (message: c102) => void);
    z286: (message: c102) => void;
    sendMessage(message: c102, g287?: number): void;
    t102(e287: number, f287?: number): void;
    k234(d287: number): void;
    l234(): void;
}
export {};
