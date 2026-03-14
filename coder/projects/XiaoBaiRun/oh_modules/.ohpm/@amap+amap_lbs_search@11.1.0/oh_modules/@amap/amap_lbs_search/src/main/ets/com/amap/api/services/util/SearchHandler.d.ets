// @keepTs
// @ts-nocheck
import HashMap from "@ohos.util.HashMap";
export declare class k39 {
    e43: number;
    o42?: number;
    q43?: number;
    obj?: object;
    n95?: j39;
    bundle?: HashMap<string, ESObject>;
    constructor(m95: number, obj?: object, bundle?: HashMap<string, ESObject>);
    o95: () => string;
}
export declare class l89 extends k39 {
    o95: () => string;
}
declare class b95 {
    p95: HashMap<string, number[]>;
    q95: (message: k39) => void;
    constructor(l95: (message: k39) => void);
    sendMessage(message: k39, k95?: number): void;
    r95(i95: number, j95?: number): void;
    s95(h95: number): void;
    t95(): void;
}
export declare class j39 {
    u95: b95;
    constructor(g95?: (message: k39) => void);
    n42: (message: k39) => void;
    sendMessage(message: k39, f95?: number): void;
    r95(d95: number, e95?: number): void;
    s95(c95: number): void;
    t95(): void;
}
export {};
