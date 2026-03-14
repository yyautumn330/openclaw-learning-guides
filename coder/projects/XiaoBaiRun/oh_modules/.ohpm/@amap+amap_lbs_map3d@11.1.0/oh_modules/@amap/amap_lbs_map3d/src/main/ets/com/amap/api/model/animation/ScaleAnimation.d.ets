// @keepTs
// @ts-nocheck
import { Animation } from "./Animation";
export declare class ScaleAnimation extends Animation {
    private mAnimationType;
    private mFromX;
    private mToX;
    private mFromY;
    private mToY;
    private mPivotX;
    private mPivotY;
    /**
     * 控制缩放的动画类<br>
     * 比如要实现一个Marker生长动画,可以使用 (0,1,0,1)
     * @param fromX 动画开始时横坐标位置
     * @param toX   动画结束时横坐标位置
     * @param fromY 动画开始时纵坐标位置
     * @param toY   动画结束时纵坐标位置
     * @since V4.0.0
     */
    constructor(fromX: number, toX: number, fromY: number, toY: number);
    protected getAnimationType(): string;
}
