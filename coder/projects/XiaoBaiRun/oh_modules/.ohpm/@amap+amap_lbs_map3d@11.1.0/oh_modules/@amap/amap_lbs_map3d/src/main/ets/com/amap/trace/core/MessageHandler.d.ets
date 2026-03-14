// @keepTs
// @ts-nocheck
import { TraceListener } from "../TraceListener";
import { y200, c102 } from "./TraceHandler";
export declare class MessageHandler extends y200 {
    private d286?;
    protected static readonly v286: string;
    protected static readonly w286: number;
    protected static readonly x286: number;
    protected static readonly y286: number;
    e286(u286: TraceListener): void;
    z286: (message: c102) => void;
}
