// @keepTs
// @ts-nocheck
/**
 * 点信息描述
 */
export declare class Point {
    x: number;
    y: number;
    constructor(x?: number, y?: number);
    toString(): string;
    equals(point: Point): boolean;
}
