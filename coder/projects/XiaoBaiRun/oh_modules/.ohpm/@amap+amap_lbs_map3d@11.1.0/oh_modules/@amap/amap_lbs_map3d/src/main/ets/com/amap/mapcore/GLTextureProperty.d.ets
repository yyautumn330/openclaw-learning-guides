// @keepTs
// @ts-nocheck
import { BitmapDescriptor } from "../api/model/BitmapDescriptor";
export declare class h73 {
    /** 资源ID */
    mId: number;
    /** 纹理图片 */
    mBitmap?: BitmapDescriptor;
    /** png图片的buffer*/
    g165: Int8Array;
    /** 纹理锚点 */
    l94: number;
    /** 主要是针对不规则的锚点：锚点所在X像素坐标相对于X像素坐标的比例值 */
    m94: number;
    /** 主要是针对不规则的锚点：锚点所在Y像素坐标相对于Y像素坐标的比例值 */
    n94: number;
    /** 是否生成纹理映射 mipmap*/
    j121: boolean;
    /** 是否纹理重复贴 */
    isRepeat: boolean;
}
