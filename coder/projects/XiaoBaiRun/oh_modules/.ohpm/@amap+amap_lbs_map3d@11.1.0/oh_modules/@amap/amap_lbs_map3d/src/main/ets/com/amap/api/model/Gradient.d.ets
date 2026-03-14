// @keepTs
// @ts-nocheck
/**
 * 热力图渐变颜色定义类
 *
 * @author qsh
 * @since 2.2.3
 */
export declare class Gradient {
    private static readonly e28;
    private mColorMapSize?;
    private mColors?;
    private mStartPoints?;
    private isAvailable;
    constructor(colors: number[], d28: number[]);
    private f28;
    /**
     * 获取颜色数组
     * @return
     * @internal
     */
    getColors(): Int32Array | undefined;
    /**
     * 获取颜色对应的起始点数组
     * @return
     * @internal
     */
    getStartPoints(): Float64Array | undefined;
    static argb(alpha: number, red: number, green: number, blue: number): number;
    /**
     * @internal
     * @param color
     * @returns
     */
    static red(color: number): number;
    /**
     * @internal
     * @param color
     * @returns
     */
    static green(color: number): number;
    /**
     * @internal
     * @param color
     * @returns
     */
    static blue(color: number): number;
    /**
     * @internal
     * @param color
     * @returns
     */
    static alpha(color: number): number;
    /**
     * @internal
     * @returns
     */
    private g28;
    /**
     * @since 2.2.3
     * @param opacity
     * @returns
     */
    h28(opacity: number): Float64Array;
    /**
     * RGB 转 HSV
     * @param r 红色通道 (0-255)
     * @param g 绿色通道 (0-255)
     * @param b 蓝色通道 (0-255)
     * @returns HSV 对象 { h: 0-360, s: 0-1, v: 0-1 }
     * @internal
     */
    static l28(r: number, g: number, b: number): number[];
    /**
     * @internal
     * @param value
     * @param min
     * @param max
     * @returns
     */
    private static clamp;
    /**
     * @internal
     * @param alpha
     * @param hsv
     * @returns
     */
    private static m28;
    /**
     * @internal
     * @param color1
     * @param color2
     * @param ratio
     * @returns
     */
    static k28(d27: number, e27: number, ratio: number): number;
    /**
     * @since 2.2.3
     * @returns
     */
    n28(): boolean;
}
