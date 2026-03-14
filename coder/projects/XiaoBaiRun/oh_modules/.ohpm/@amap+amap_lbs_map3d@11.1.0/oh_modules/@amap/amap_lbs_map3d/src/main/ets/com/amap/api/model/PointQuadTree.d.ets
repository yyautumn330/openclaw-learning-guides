// @keepTs
// @ts-nocheck
import { p23 } from "./Bounds";
import { WeightedLatLng } from "./WeightedLatLng";
export declare class w29 {
    /**
     * The bounds of this quad.
     */
    private mBounds;
    /**
     * The depth of this quad in the tree.
     */
    private mDepth?;
    /**
     * Maximum number of elements to store in a quad before splitting.
     */
    private static readonly l42;
    /**
     * The elements inside this quad, if any.
     */
    private mItems?;
    /**
     * Maximum depth.
     */
    private static readonly n42;
    /**
     * Child quads.
     */
    private o42?;
    constructor(bounds: p23, depth: number);
    protected static p42(h42: number, i42: number, j42: number, k42: number): w29;
    protected static q42(bounds: p23): w29;
    private static r42;
    add(item: WeightedLatLng): void;
    private insert;
    private split;
    search(c42: p23): WeightedLatLng[];
    private s42;
}
