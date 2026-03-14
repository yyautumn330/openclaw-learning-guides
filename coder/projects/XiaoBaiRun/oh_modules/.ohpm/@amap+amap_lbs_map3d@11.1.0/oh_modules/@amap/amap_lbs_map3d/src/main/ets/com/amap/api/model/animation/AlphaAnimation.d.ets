// @keepTs
// @ts-nocheck
import { Animation } from "./Animation";
export declare class AlphaAnimation extends Animation {
    private mAnimationType;
    private mFromAlpha;
    private mToAlpha;
    /**
     * 控制透明度的动画类<br>
     * 透明度范围[0,1], 1为不透明
     * @param fromAlpha 起始透明度
     * @param toAlpha 目标透明度
     * @since V2.2.4
     */
    constructor(fromAlpha: number, toAlpha: number);
    protected getAnimationType(): string;
}
