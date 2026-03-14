// @keepTs
// @ts-nocheck
import HashMap from "@ohos.util.HashMap";
export declare class c102 {
    p102: number;
    private data?;
    private bundle?;
    constructor(o245: number, data?: object, bundle?: HashMap<string, ESObject>);
    setData(data: object): void;
    p245(bundle: HashMap<string, ESObject>): void;
    getData(): object | undefined;
    q245(): HashMap<string, ESObject> | undefined;
}
export declare class y200 {
    j234: x233;
    constructor(n245: (message: c102) => void);
    sendMessage(message: c102, m245?: number): void;
    t102(k245: number, l245?: number): void;
    k234(j245: number): void;
    l234(): void;
}
declare class x233 {
    k229: HashMap<number, number[]>;
    m234: (message: c102) => void;
    constructor(i245: (message: c102) => void);
    sendMessage(message: c102, h245?: number): void;
    t102(f245: number, g245?: number): void;
    k234(e245: number): void;
    l234(): void;
}
export {};
