// @keepTs
// @ts-nocheck
import { j73 } from './BaseMapOverlay';
import { t120 } from './GLCrossVector';
import { y24, z24 } from '../api/model/CrossOverlay';
import { w24 } from './AVectorCrossAttr';
import { x24 } from './interface/ICrossVectorOverlay';
import { IAMap } from './interface/IAMap';
import { BitmapDescriptor } from '../api/model/BitmapDescriptor';
export declare class CrossVectorOverlay extends j73<t120, Object> implements x24 {
    static hashCode: number;
    private d121;
    private e121?;
    private f121?;
    private attr;
    constructor(b121: number, context: Context, c121: IAMap);
    e107(): void;
    addItem(item: Object): void;
    w89(bitmap: BitmapDescriptor | null): void;
    j94(bitmap: BitmapDescriptor, resId: number, anchor: number): void;
    o94(bitmap: BitmapDescriptor): number;
    setAttribute(attr: w24 | null): void;
    setVisible(visible: boolean): void;
    private argb;
    setData(data: Int8Array): number;
    private k121;
    /**
     * 初始化图片模式
     */
    private l121;
    remove(): void;
    /**
     * 设置了之后地图上将不会展示矢量路口放大图
     * @param isImageMode
     */
    f25(u120: boolean): void;
    g25(listener: y24): void;
    h25(listener: z24): void;
    /**
     * native 回调
     */
    imageContentResult(data: Int32Array, width: number, height: number): void;
}
