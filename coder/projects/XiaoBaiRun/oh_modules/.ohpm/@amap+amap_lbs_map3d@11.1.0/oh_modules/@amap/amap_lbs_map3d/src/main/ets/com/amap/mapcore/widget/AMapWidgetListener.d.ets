// @keepTs
// @ts-nocheck
/**
 * 更新比例尺
 */
export type t90 = () => void;
/**
 * 更新指南针
 */
export type s90 = () => void;
/**
 * 更新zoomview
 * @param zoomLevel 更新zoomview
 */
export type p90 = (zoomLevel: number) => void;
/**
 * 更新地图前后台切换防止黑屏的前视图
 * @param visiable 是否可见
 */
export type x273 = (visiable: boolean) => void;
/**
 * 地图比例尺、指南针、地图前后台切换防止黑屏的前视图
 *
 */
export declare class a66 {
    private c274;
    get t90(): t90;
    private d274;
    get s90(): s90;
    private e274;
    get p90(): p90;
    private f274;
    get x273(): x273;
    constructor(y273: t90, z273: s90, a274: p90, b274: x273);
}
