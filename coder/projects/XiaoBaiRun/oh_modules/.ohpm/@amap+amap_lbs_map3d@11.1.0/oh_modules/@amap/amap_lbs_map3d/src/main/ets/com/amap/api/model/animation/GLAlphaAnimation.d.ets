// @keepTs
// @ts-nocheck
import { n18 } from "./GLAnimation";
import { u18 } from "./GLTransformation";
export declare class m18 extends n18 {
    mFromAlpha: number;
    mToAlpha: number;
    x18: number;
    constructor(fromAlpha: number, toAlpha: number);
    protected applyTransformation(v18: number, w18: u18): void;
}
