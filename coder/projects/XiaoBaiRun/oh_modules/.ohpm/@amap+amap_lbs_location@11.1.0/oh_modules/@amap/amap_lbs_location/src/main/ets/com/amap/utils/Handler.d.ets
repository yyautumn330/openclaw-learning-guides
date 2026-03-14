// @keepTs
// @ts-nocheck
import HashMap from "@ohos.util.HashMap";
export declare class Message {
    what: number;
    private data?;
    private bundle?;
    constructor(o33: number, data?: object, bundle?: HashMap<string, ESObject>);
    setData(data: object): void;
    setBundle(bundle: HashMap<string, ESObject>): void;
    getData(): object | undefined;
    getBundle(): HashMap<string, ESObject> | undefined;
}
export declare class Handler {
    p33: d33;
    constructor(n33: (message: Message) => void);
    sendMessage(message: Message, m33?: number): void;
    sendEmptyMessage(k33: number, l33?: number): void;
    removeMessage(j33: number): void;
    removeAllMessage(): void;
}
declare class d33 {
    q33: HashMap<number, number[]>;
    r33: (message: Message) => void;
    constructor(i33: (message: Message) => void);
    sendMessage(message: Message, h33?: number): void;
    sendEmptyMessage(f33: number, g33?: number): void;
    removeMessage(e33: number): void;
    removeAllMessage(): void;
}
export {};
