// @keepTs
// @ts-nocheck
import { LatLng } from '../LatLng';
import { Animation } from './Animation';
export declare class TranslateAnimation extends Animation {
    private mAnimationType;
    x: number;
    y: number;
    /**
     * 控制移动的动画类
     * @param target 需要移动的目标位置(位置类型为经纬度)
     * @since V4.0.0
     */
    constructor(target: LatLng);
    protected getAnimationType(): string;
}
