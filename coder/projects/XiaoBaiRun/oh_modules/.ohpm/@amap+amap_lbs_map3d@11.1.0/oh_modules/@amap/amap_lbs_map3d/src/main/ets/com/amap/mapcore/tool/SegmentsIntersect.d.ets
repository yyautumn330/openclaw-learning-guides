// @keepTs
// @ts-nocheck
/**
 * 类说明：判断两条线段 是否 相交
 */
import { LatLng } from '../../api/model/LatLng';
export declare class g249 {
    /**
     * 计算叉积
     * @param pi
     * @param pj
     * @return
     */
    private static f250;
    /**
     * 構造向量
     * @param pi
     * @param pj
     * @return
     */
    private static g250;
    private static direction;
    /**
     * 大於零表示順時針，即右轉，小於零表示逆時針，即左轉，等於零，表示共綫。
     * @param pi
     * @param pj
     * @param pk
     * @return
     */
    private static h250;
    /**
     * 判断两条线段是否相交
     * @param latLng1   线段1 第一个点
     * @param latLng2   线段1 第二个点
     * @param latLng3   线段1 第一个点
     * @param latLng4   线段2 第二个点
     * @return
     */
    static i250(h249: LatLng, i249: LatLng, j249: LatLng, k249: LatLng): boolean;
}
