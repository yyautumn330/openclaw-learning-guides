// @keepTs
// @ts-nocheck
/**
 * 矩形信息描述
 */
export declare class Rect {
    left: number;
    top: number;
    width: number;
    height: number;
    constructor(left: number, top: number, width: number, height: number);
    /**
     * 判断点是否在矩形内部
     *
     * @param x x左边
     * @param y y坐标
     * @returns
     */
    contains(x: number, y: number): boolean;
    /**
     * Set the rectangle to (0,0,0,0)
     */
    setEmpty(): void;
    get bottom(): number;
    get right(): number;
    get centerX(): number;
    get centerY(): number;
}
