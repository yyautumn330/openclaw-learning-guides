// @keepTs
// @ts-nocheck
import { n18 } from "./GLAnimation";
import { u18 } from "./GLTransformation";
export declare class GLScaleAnimation extends n18 {
    private mFromX;
    private mToX;
    private mFromY;
    private mToY;
    private mPivotX;
    private mPivotY;
    constructor(fromX: number, toX: number, fromY: number, toY: number);
    protected applyTransformation(j21: number, k21: u18): void;
}
