// @keepTs
// @ts-nocheck
/**
 * 地图手势识别的回调，包含单双击、滑动等以及地图操作地图后稳定下来的回调
 * @since 1.0.0
 */
export declare class AMapGestureListener {
    aOnDoubleTap: onDoubleTap;
    aOnSingleTap: onSingleTap;
    aOnFling: onFling;
    aOnScroll: onScroll;
    aOnLongPress: onLongPress;
    aOnDown: onDown;
    aOnUp: onUp;
    aOnMapStable: onMapStable;
    constructor(v4: onDoubleTap, w4: onSingleTap, x4: onFling, y4: onScroll, z4: onLongPress, a5: onDown, b5: onUp, c5: onMapStable);
    get onDoubleTap(): onDoubleTap;
    get onSingleTap(): onSingleTap;
    get onFling(): onFling;
    get onScroll(): onScroll;
    get onLongPress(): onLongPress;
    get onDown(): onDown;
    get onUp(): onUp;
    get onMapStable(): onMapStable;
}
/**
 * 双击
 * @param x 像素 x坐标
 * @param y 像素 y坐标
 * @since 1.0.0
 */
export type onDoubleTap = (x: number, y: number) => void;
/**
 * 单击
 * @param x 像素 x坐标
 * @param y 像素 y坐标
 * @since 1.0.0
 */
type onSingleTap = (x: number, y: number) => void;
/**
 * 惯性滑动
 * @param velocityX 惯性滑动的水平速度
 * @param velocityY 惯性滑动的垂直速度
 * @since 1.0.0
 */
type onFling = (velocityX: number, velocityY: number) => void;
/**
 * 滑动
 * @param distanceX 滑动的水平距离
 * @param distanceY 滑动的垂直距离
 * @since 1.0.0
 */
type onScroll = (distanceX: number, distanceY: number) => void;
/**
 * 长按
 * @param x 像素 x坐标
 * @param y 像素 y坐标
 * @since 1.0.0
 */
type onLongPress = (x: number, y: number) => void;
/**
 * 按下
 * @param x 像素 x坐标
 * @param y 像素 y坐标
 * @since 1.0.0
 */
type onDown = (x: number, y: number) => void;
/**
 * 抬起
 * @param x 像素 x坐标
 * @param y 像素 y坐标
 * @since 1.0.0
 */
type onUp = (x: number, y: number) => void;
/**
 * 地图稳定下来会回到此接口
 * @since 1.0.0
 */
type onMapStable = () => void;
export {};
