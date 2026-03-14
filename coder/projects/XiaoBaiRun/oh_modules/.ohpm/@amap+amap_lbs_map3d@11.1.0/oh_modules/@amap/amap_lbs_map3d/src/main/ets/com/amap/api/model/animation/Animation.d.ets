// @keepTs
// @ts-nocheck
import { n18 } from "./GLAnimation";
import { BaseUpdateFlags } from "../BaseOptions";
/**
 * 动画,可用于支持动画的覆盖物<br>
 * 使用方法如同Android系统自带的{@link android.view.animation.Animation}
 * @since V2.2.4
 */
export declare abstract class Animation {
    /**
     * 动画执行后保持在最后一帧
     * @since 2.2.4
     */
    static readonly FILL_MODE_FORWARDS: number;
    /**
     * 动画执行后保持在第一帧
     * @since2.2.4
     */
    static readonly FILL_MODE_BACKWARDS: number;
    /**
     * 无限期地重复动画.
     * @since 2.2.4
     */
    static readonly INFINITE: number;
    /**
     * 动画结束后从头播放，最大重复次数受{@link #setRepeatCount(int)} 限制
     * @since 2.2.4
     */
    static readonly RESTART: number;
    /**
     * 动画结束后从尾倒放，最大重复次数受{@link #setRepeatCount(int)} 限制
     * @since 2.2.4
     */
    static readonly REVERSE: number;
    /**
     * 动画执行完成后的状态，默认是保留在最后一帧，scale动画默认保留在第一帧
     */
    private fillMode;
    /**
     * jni使用， 默认值500
     */
    private duration;
    /**
     * jni使用
     */
    private interpolator?;
    /**
     * jni使用
     */
    protected animationType: string;
    /**
     * jni使用
     */
    private mFillBefore;
    /**
     * jni使用
     */
    private mFillAfter;
    /**
     * jni使用
     */
    private mFillEnabled;
    /**
     * jni使用
     */
    mRepeatCount: number;
    /**
     * jni使用
     */
    private mRepeatMode;
    /**
     * jni使用
     */
    private mListener?;
    /**
     * @exclude javadoc中不显示
     */
    glAnimation?: n18;
    /**
     * @exclude javadoc中不显示
     */
    constructor();
    /**
     * @exclude javadoc中不显示
     */
    protected abstract getAnimationType(): string;
    /**
     * 设置动画监听器
     *
     * @param listener 动画监听
     * @since V2.2.4
     */
    setAnimationListener(listener: AnimationListener): void;
    /**
     * 设置动画持续时间,如果设置为负数,会修正为0
     *
     * @param duration 按毫秒计算时间
     * @since V2.2.4
     */
    setDuration(duration: number): void;
    /**
     * 设置插值器,默认是线性插值器
     *
     * @param interpolator 插值器
     * @since V2.2.4
     */
    setInterpolator(s18: ICurve): void;
    /**
     * 设置动画执行完成后的状态
     * @param fillMode 默认为保持最后一帧 {@link #FILL_MODE_FORWARDS}，缩放动画默认保持第一帧
     * @since V2.2.4
     */
    setFillMode(fillMode: number): void;
    /**
     * 获取动画执行完成后的状态
     * @return 默认为保持最后一帧 {@link #FILL_MODE_FORWARDS}，缩放动画默认保持第一帧
     * @since 2.2.4
     */
    getFillMode(): number;
    /**
     * 如果值为true时，{@link #setFillBefore(boolean)} (boolean)} 的值才会生效，否则不会生效
     *
     * 保持和系统动画一致，{@link #setFillAfter(boolean)} 不受改值的影响
     *
     * @param fillEnable 默认为 false
     * @since 2.2.4
     */
    private setFillEnabled;
    /**
     * 设置动画停止时是否显示最后一帧动画（即停止时是否在终点位置显示）
     *
     *
     * @param fillAfter 默认为 true，Scale动画默认是false，会恢复在第一帧
     * @since 2.2.4
     */
    private setFillAfter;
    /**
     * 设置动画停止时是否显示第一帧动画（即停止时是否在原始位置显示）
     * 只有在{@link #setFillEnabled(boolean)} 为true是才会生效
     * @param fillBefore 默认是 true
     * @since 2.2.4
     */
    private setFillBefore;
    /**
     * 设置动画重复执行的次数,默认为0
     * @param repeatCount 动画重复执行的次数，默认不会重复执行
     * @since 2.2.4
     */
    setRepeatCount(repeatCount: number): void;
    /**
     * 重复执行的模式，默认从前往后执行
     * @param repeatMode {@link #RESTART} or {@link #REVERSE}
     * @since 2.2.4
     */
    setRepeatMode(repeatMode: number): void;
    /**
     * 重复执行的模式.
     *
     * @return 可以是 {@link #REVERSE} 或者 {@link #RESTART}
     * @since 2.2.4
     */
    getRepeatMode(): number;
    /**
     * 获取动画重复执行的次数,默认为0。
     *
     * @return 动画重复执行的次数, 或者
     *         {@link #INFINITE}
     * @since 2.2.4
     */
    getRepeatCount(): number;
    private updateFlags;
    /**
     * 用于Native判断当前有哪些数据有更新
     * @exclude javadoc中不显示。
     */
    resetUpdateFlags(): void;
    /**
     * 用于Native判断当前有哪些数据有更新
     * @exclude javadoc中不显示。
     */
    getUpdateFlags(): AnimationUpdateFlags;
}
/**
 *动画监听，包含动画开始和结束时的回调
 * @since V2.2.4
 */
export interface AnimationListener {
    /**
     * 动画开始回调
     * @since V2.2.4
     */
    onAnimationStart: () => void;
    /**
     * 动画结束回调
     * @since V2.2.4
     */
    onAnimationEnd: () => void;
}
/**
 * 用于Native判断当前有哪些数据有更新
 * @exclude javadoc中不显示。
 */
declare class AnimationUpdateFlags extends BaseUpdateFlags {
    mListenerUpdate: boolean;
    durationUpdate: boolean;
    interpolatorUpdate: boolean;
    fillModeUpdate: boolean;
    mFillEnabledUpdate: boolean;
    mFillAfterUpdate: boolean;
    mFillBeforeUpdate: boolean;
    mRepeatCountUpdate: boolean;
    mRepeatModeUpdate: boolean;
    reset(): void;
}
/**
 * 避免c++回调java后，动画回调中出现崩溃，使用这个类增加try-catch
 */
export declare class o18 implements AnimationListener {
    constructor(listener: AnimationListener);
    onAnimationStart: () => void;
    onAnimationEnd: () => void;
}
export {};
