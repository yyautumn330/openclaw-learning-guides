// @keepTs
// @ts-nocheck
export declare class DPoint {
    x: number;
    y: number;
    private static j26;
    private static readonly k26;
    constructor();
    static obtain(h26?: number, i26?: number): DPoint;
    recycle(): void;
    equals(other: DPoint): boolean;
}
