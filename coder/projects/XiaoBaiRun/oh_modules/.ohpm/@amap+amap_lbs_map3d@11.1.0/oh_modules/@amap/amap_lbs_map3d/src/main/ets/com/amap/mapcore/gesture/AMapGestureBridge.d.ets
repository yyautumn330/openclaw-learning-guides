// @keepTs
// @ts-nocheck
/**
 * touch事件
 */
type a129 = (event: TouchEvent) => void;
/**
 * 单击事件
 */
type b129 = (event: GestureEvent) => void;
/**
 * 长按事件
 */
type c129 = (event: GestureEvent) => void;
/**
 * 双击事件
 */
type d129 = (event: GestureEvent) => void;
/**
 * 拖动事件
 */
type e129 = (state: number, event: GestureEvent) => void;
/**
 * 捏合事件
 */
type f129 = (state: number, event: GestureEvent) => void;
/**
 * 旋转事件
 */
type g129 = (state: number, event: GestureEvent) => void;
/**
 * arkui手势连接桥
 */
export declare class k60 {
    private m129;
    private aOnSingleTap;
    private aOnLongPress;
    private aOnDoubleTap;
    private n129?;
    private o129?;
    private p129?;
    constructor(onTouch: a129, h129: b129, onLongPress: c129, i129: d129, j129?: e129, k129?: f129, l129?: g129);
    get onTouch(): a129;
    get onSingleTap(): b129;
    get onLongPress(): c129;
    get onDoubleTap(): d129;
    get t14(): e129 | undefined;
    get o14(): f129 | undefined;
    get s14(): g129 | undefined;
}
export {};
