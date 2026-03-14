// @keepTs
// @ts-nocheck
/**
 * @author zxy
 * @data 2020/8/20
 */
import { BitmapDescriptor } from "../../api/model/BitmapDescriptor";
import { MarkerOptions } from "../../api/model/MarkerOptions";
import { TextOptions } from "../../api/model/TextOptions";
export declare class e45 {
    private static rect;
    static r64(textOptions: TextOptions): MarkerOptions | null;
    static g211(align: number, e211: boolean): number;
    /**
     * 根据textOptions 生成图片
     */
    static n45(textOptions: TextOptions): BitmapDescriptor | undefined;
}
