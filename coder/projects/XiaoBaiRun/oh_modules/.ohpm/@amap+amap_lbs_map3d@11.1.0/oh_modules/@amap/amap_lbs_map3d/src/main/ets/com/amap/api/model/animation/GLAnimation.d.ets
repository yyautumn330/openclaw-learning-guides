// @keepTs
// @ts-nocheck
import { Rect } from "../../../../../../../../Index";
import { AnimationListener } from "./Animation";
import { u18 } from "./GLTransformation";
export declare class n18 {
    /**
     * Repeat the animation indefinitely.
     */
    static readonly INFINITE: number;
    /**
     * When the animation reaches the end and the repeat count is INFINTE_REPEAT
     * or a positive value, the animation restarts from the beginning.
     */
    static readonly RESTART: number;
    /**
     * When the animation reaches the end and the repeat count is INFINTE_REPEAT
     * or a positive value, the animation plays backward (and then forward
     * again).
     */
    static readonly REVERSE = 2;
    /**
     * Can be used as the start time to indicate the start time should be the
     * current time when {@link #getTransformation(long, Transformation)} is
     * invoked for the first animation frame. This can is useful for short
     * animations.
     */
    static readonly q19 = -1;
    /**
     * The specified dimension is an absolute number of pixels.
     */
    static readonly r19 = 0;
    /**
     * The specified dimension holds a float and should be multiplied by the
     * height or width of the object being animated.
     */
    static readonly s19 = 1;
    /**
     * The specified dimension holds a float and should be multiplied by the
     * height or width of the parent of the object being animated.
     */
    static readonly t19 = 2;
    /**
     * Requests that the content being animated be kept in its current Z order.
     */
    static readonly u19 = 0;
    /**
     * Requests that the content being animated be forced on top of all other
     * content for the duration of the animation.
     */
    static readonly v19 = 1;
    /**
     * Requests that the content being animated be forced under all other
     * content for the duration of the animation.
     */
    static readonly w19 = -1;
    /**
     * Set by {@link #getTransformation(long, Transformation)} when the
     * animation ends.
     */
    x19: boolean;
    /**
     * Set by {@link #getTransformation(long, Transformation)} when the
     * animation starts.
     */
    y19: boolean;
    /**
     * Set by {@link #getTransformation(long, Transformation)} when the
     * animation repeats in REVERSE mode.
     */
    z19: boolean;
    /**
     * This value must be set to true by {@link #initialize()}
     * . It indicates the animation was successfully initialized and can be
     * played.
     */
    a20: boolean;
    /**
     * Indicates whether the animation transformation should be applied before
     * the animation starts. The value of this variable is only relevant if
     * mFillEnabled is true; otherwise it is assumed to be true.
     */
    mFillBefore: boolean;
    /**
     * Indicates whether the animation transformation should be applied after
     * the animation ends.
     */
    mFillAfter: boolean;
    /**
     * Indicates whether fillBefore should be taken into account.
     */
    mFillEnabled: boolean;
    /**
     * The time in milliseconds at which the animation must start;
     */
    b20: number;
    /**
     * The delay in milliseconds after which the animation must start. When the
     * start offset is > 0, the start time of the animation is startTime +
     * startOffset.
     */
    c20: number;
    /**
     * The duration of one animation cycle in milliseconds.
     * default 500ms
     */
    d20: number;
    /**
     * The number of times the animation must repeat. By default, an animation
     * repeats indefinitely.
     */
    mRepeatCount: number;
    /**
     * Indicates how many times the animation was repeated.
     */
    e20: number;
    /**
     * The behavior of the animation when it repeats. The repeat mode is either
     * {@link #RESTART} or {@link #REVERSE}.
     *
     */
    mRepeatMode: number;
    /**
     * The interpolator used by the animation to smooth the movement.
     */
    f20?: ICurve;
    /**
     * The animation listener to be notified when the animation starts, ends or
     * repeats.
     */
    mListener?: AnimationListener;
    /**
     * Desired Z order mode during animation.
     */
    private g20;
    /**
     * Desired background color behind animation.
     */
    private h20;
    /**
     * scalefactor to apply to pivot points, etc. during animation. Subclasses
     * retrieve the value via getScaleFactor().
     */
    private i20;
    /**
     * Don't animate the wallpaper.
     */
    private j20;
    private k20;
    private l20;
    m20: Rect;
    n20: Rect;
    o20: u18;
    constructor();
    /**
     * Reset the initialization state of this animation.
     *
     * @see #initialize()
     */
    reset(): void;
    initialize(): void;
    /**
     * Sets the acceleration curve for this animation. Defaults to a linear
     * interpolation.
     *
     * @param i
     *            The interpolator which defines the acceleration curve
     * @attr ref android.R.styleable#Animation_interpolator
     */
    setInterpolator(p19: ICurve): void;
    /**
     * When this animation should start relative to the start time. This is most
     * useful when composing complex animations using an {@link AnimationSet }
     * where some of the animations components start at different times.
     *
     * @param startOffset
     *            When this Animation should start, in milliseconds from the
     *            start time of the root AnimationSet.
     * @attr ref android.R.styleable#Animation_startOffset
     */
    q20(o19: number): void;
    /**
     * How long this animation should last. The duration cannot be negative.
     *
     * @param durationMillis
     *            Duration in milliseconds
     *
     * @throws IllegalArgumentException
     *             if the duration is < 0
     *
     * @attr ref android.R.styleable#Animation_duration
     */
    setDuration(n19: number): void;
    /**
     * Ensure that the duration that this animation will run is not longer than
     * <var>durationMillis</var>. In addition to adjusting the duration itself,
     * this ensures that the repeat count also will not make it run longer than
     * the given time.
     *
     * @param durationMillis
     *            The maximum duration the animation is allowed to run.
     */
    r20(l19: number): void;
    /**
     * How much to scale the duration by.
     *
     * @param scale
     *            The amount to scale the duration.
     */
    s20(scale: number): void;
    /**
     * When this animation should start. When the start time is set to
     * {@link #START_ON_FIRST_FRAME}, the animation will start the first time
     * {@link #getTransformation(long, Transformation)} is invoked. The time
     * passed to this method should be obtained by calling
     * {@link AnimationUtils#currentAnimationTimeMillis()} instead of
     * {@link System#currentTimeMillis()}.
     *
     * @param startTimeMillis
     *            the start time in milliseconds
     */
    t20(k19: number): void;
    /**
     * Defines what this animation should do when it reaches the end. This
     * setting is applied only when the repeat count is either greater than 0 or
     * {@link #INFINITE}. Defaults to {@link #RESTART}.
     *
     * @param repeatMode
     *            {@link #RESTART} or {@link #REVERSE}
     * @attr ref android.R.styleable#Animation_repeatMode
     */
    setRepeatMode(repeatMode: number): void;
    /**
     * Sets how many times the animation should be repeated. If the repeat count
     * is 0, the animation is never repeated. If the repeat count is greater
     * than 0 or {@link #INFINITE}, the repeat mode will be taken into account.
     * The repeat count is 0 by default.
     *
     * @param repeatCount
     *            the number of times the animation should be repeated
     * @attr ref android.R.styleable#Animation_repeatCount
     */
    setRepeatCount(repeatCount: number): void;
    /**
     * If fillEnabled is true, the animation will apply the value of fillBefore.
     * Otherwise, fillBefore is ignored and the animation transformation is
     * always applied until the animation ends.
     *
     * @param fillEnabled
     *            true if the animation should take the value of fillBefore into
     *            account
     * @attr ref android.R.styleable#Animation_fillEnabled
     *
     * @see #setFillBefore(boolean)
     * @see #setFillAfter(boolean)
     */
    setFillEnabled(j19: boolean): void;
    /**
     * If fillBefore is true, this animation will apply its transformation
     * before the start time of the animation. Defaults to true if
     * {@link #setFillEnabled(boolean)} is not set to true. Note that this
     * applies when using an {@link AnimationSet
     * AnimationSet} to chain animations. The transformation is not applied
     * before the AnimationSet itself starts.
     *
     * @param fillBefore
     *            true if the animation should apply its transformation before
     *            it starts
     * @attr ref android.R.styleable#Animation_fillBefore
     *
     * @see #setFillEnabled(boolean)
     */
    setFillBefore(i19: boolean): void;
    /**
     * If fillAfter is true, the transformation that this animation performed
     * will persist when it is finished. Defaults to false if not set. Note that
     * this applies to individual animations and when using an
     * {@link AnimationSet AnimationSet} to chain
     * animations.
     *
     * @param fillAfter
     *            true if the animation should apply its transformation after it
     *            ends
     * @attr ref android.R.styleable#Animation_fillAfter
     *
     * @see #setFillEnabled(boolean)
     */
    setFillAfter(h19: boolean): void;
    /**
     * The scale factor is set by the call to <code>getTransformation</code>.
     * Overrides of {@link #getTransformation(long, Transformation, float)} will
     * get this value directly. Overrides of
     * {@link #applyTransformation(float, Transformation)} can call this method
     * to get the value.
     *
     * @return float The scale factor that should be applied to pre-scaled
     *         values in an Animation such as the pivot points in
     *         {@link ScaleAnimation} and {@link RotateAnimation}.
     */
    protected u20(): number;
    /**
     * When this animation should start. If the animation has not startet yet,
     * this method might return {@link #START_ON_FIRST_FRAME}.
     *
     * @return the time in milliseconds when the animation should start or
     *         {@link #START_ON_FIRST_FRAME}
     */
    getStartTime(): number;
    /**
     * How long this animation should last
     *
     * @return the duration in milliseconds of the animation
     * @attr ref android.R.styleable#Animation_duration
     */
    getDuration(): number;
    /**
     * When this animation should start, relative to StartTime
     *
     * @return the start offset in milliseconds
     * @attr ref android.R.styleable#Animation_startOffset
     */
    v20(): number;
    /**
     * Defines what this animation should do when it reaches the end.
     *
     * @return either one of {@link #REVERSE} or {@link #RESTART}
     * @attr ref android.R.styleable#Animation_repeatMode
     */
    getRepeatMode(): number;
    /**
     * Defines how many times the animation should repeat. The default value is
     * 0.
     *
     * @return the number of times the animation should repeat, or
     *         {@link #INFINITE}
     * @attr ref android.R.styleable#Animation_repeatCount
     */
    getRepeatCount(): number;
    w20(): boolean;
    x20(): boolean;
    /**
     * <p>
     * Binds an animation listener to this animation. The animation listener is
     * notified of animation events such as the end of the animation or the
     * repetition of the animation.
     * </p>
     *
     * @param listener
     *            the animation listener to be notified
     */
    setAnimationListener(listener: AnimationListener): void;
    /**
     * Gurantees that this animation has an interpolator. Will use a
     * AccelerateDecelerateInterpolator is nothing else was specified.
     */
    protected p20(): void;
    /**
     * Compute a hint at how long the entire animation may last, in
     * milliseconds. Animations can be written to cause themselves to run for a
     * different duration than what is computed here, but generally this should
     * be accurate.
     */
    y20(): number;
    /**
     * Gets the transformation to apply at a specified point in time.
     * Implementations of this method should always replace the specified
     * Transformation or document they are doing otherwise.
     *
     * @param currentTime
     *            Where we are in the animation. This is wall clock time.
     * @param outTransformation
     *            A transformation object that is provided by the caller and
     *            will be filled in by the animation.
     * @return True if the animation is still running
     */
    z20(currentTime: number, b19: u18): boolean;
    private a21;
    private b21;
    c21(currentTime: number, a19: u18, scale: number): boolean;
    protected d21(): boolean;
    e21(): boolean;
    /**
     * Helper for getTransformation. Subclasses should implement this to apply
     * their transforms given an interpolation value. Implementations of this
     * method should always replace the specified Transformation or document
     * they are doing otherwise.
     *
     * @param interpolatedTime
     *            The value of the normalized time (0.0 to 1.0) after it has
     *            been run through the interpolation function.
     * @param t
     *            The Transformation object to fill in with the current
     *            transforms.
     */
    protected applyTransformation(y18: number, z18: u18): void;
    /**
     * Return true if this animation changes the view's alpha property.
     *
     * @hide
     */
    f21(): boolean;
}
