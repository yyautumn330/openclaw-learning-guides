// @keepTs
// @ts-nocheck
import { w24 } from "../../mapcore/AVectorCrossAttr";
import { BitmapDescriptor } from "./BitmapDescriptor";
export declare class c1 {
    attr: w24 | null;
    private bitmapDescriptor;
    getAttribute(): w24 | null;
    setAttribute(attr: w24): c1;
    l25(k25: BitmapDescriptor | null): c1;
    m25(): BitmapDescriptor | null;
}
