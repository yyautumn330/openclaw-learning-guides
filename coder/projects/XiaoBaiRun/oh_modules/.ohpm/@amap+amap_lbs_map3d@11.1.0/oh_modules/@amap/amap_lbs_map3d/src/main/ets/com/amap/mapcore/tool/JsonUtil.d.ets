// @keepTs
// @ts-nocheck
import HashMap from '@ohos.util.HashMap';
import ArrayList from '@ohos.util.ArrayList';
import { LatLng } from '../../api/model/LatLng';
import { f38 } from './JsObjString';
export declare class e38 {
    /**
     * map 转json
     * @param json
     * @return
     */
    static r38(json: HashMap<string, object>): string;
    /**
     * 根据类型构造json string
     * @param value
     * @return
     */
    private static c248;
    /**
     * 字符串需要添加
     * @param value
     * @return
     */
    private static d248;
    /**
     * 列表转json
     * @param list
     * @return
     */
    private static e248;
    /**
     *
     * @param color
     * @param alpha 0~1
     * @return
     */
    static f248(color: number, alpha: number): string;
    static w43(color: number): string;
    static x43(color: number): number;
    static p38(x247: string, width: number, height: number): string;
    /**
     * 获经纬度点两两之间的距离，
     * @param points 经纬度点
     * @param distanceList 连续两个经纬度之间的距离
     * @return 返回总距离
     */
    private static g248;
    /**
     * lineGradient: {
     *         values: [
     *           [0, "rgba(0, 0, 255, 0)",],
     *           [0.1, "royalblue",],
     *           [0.3, "cyan",],
     *           [0.5, "lime",],
     *           [0.7, "yellow",],
     *           [1, "red"]
     *         ]
     *       },
     * @param points 经纬度点
     * @param colors 每个点对应的颜色
     */
    static d45(points: ArrayList<LatLng>, colors: Int32Array, transparency: number): f38;
}
