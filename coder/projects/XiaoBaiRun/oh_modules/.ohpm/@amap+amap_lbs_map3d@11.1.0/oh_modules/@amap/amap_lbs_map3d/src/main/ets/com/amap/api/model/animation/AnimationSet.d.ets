// @keepTs
// @ts-nocheck
import { Animation } from "./Animation";
export declare class AnimationSet extends Animation {
    private mAnimationType;
    mAnimations: Animation[];
    private shareInterpolator;
    constructor(shareInterpolator: boolean);
    /**
     * 添加动画
     * @param animation
     * @since V2.2.4
     */
    addAnimation(animation: Animation): void;
    /**
     * 清除动画
     * @since V2.2.4
     */
    cleanAnimation(): void;
    protected getAnimationType(): string;
}
