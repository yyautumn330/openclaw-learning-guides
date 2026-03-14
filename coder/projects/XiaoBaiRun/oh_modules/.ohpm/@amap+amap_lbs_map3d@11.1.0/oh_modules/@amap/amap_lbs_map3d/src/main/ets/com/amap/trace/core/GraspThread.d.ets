// @keepTs
// @ts-nocheck
import { TraceLocation } from "../TraceLocation";
import ArrayList from "@ohos.util.ArrayList";
import { TraceListener } from "../TraceListener";
import { MessageHandler } from "./MessageHandler";
import { CoordinateConverter } from "../../api/CoordinateConverter";
export declare class e285 {
    private a286;
    private mType;
    private b286;
    private c286;
    private mKey;
    private d286;
    static readonly a251: number;
    constructor(x285: number, y285: ArrayList<TraceLocation>, type: number, z285: TraceListener);
    d203(n285: MessageHandler, o285: CoordinateConverter, p285: Context): Promise<void>;
    d199(l285: number): Promise<void>;
    private f286;
    private j286;
}
