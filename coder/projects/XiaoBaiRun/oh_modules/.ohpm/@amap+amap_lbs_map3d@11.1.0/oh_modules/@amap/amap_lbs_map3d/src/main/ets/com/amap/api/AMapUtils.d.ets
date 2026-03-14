// @keepTs
// @ts-nocheck
import { LatLng } from './model/LatLng';
import ArrayList from '@ohos.util.ArrayList';
/**
 * AMap辅助工具类，包含计算距离、面积、调起高德地图APP进行导航等系列功能。
 */
export declare class AMapUtils {
    private static readonly TAG;
    private static readonly x5;
    private static readonly y5;
    private static readonly z5;
    private static readonly a6;
    private static readonly b6;
    /**
     * 驾车路径规划策略：（速度优先 : 0）
     * @since 1.0.0
     */
    static readonly c6: number;
    /**
     * 驾车路径规划策略：（费用优先 : 1）
     * @since 1.0.0
     */
    static readonly d6: number;
    /**
     * 驾车路径规划策略：（距离优先 : 2）
     * @since 1.0.0
     */
    static readonly e6: number;
    /**
     * 驾车路径规划策略：（不走高速 : 3）
     * @since 1.0.0
     */
    static readonly f6: number;
    /**
     * 驾车路径规划策略：（避免拥堵 : 4）
     * @since 1.0.0
     */
    static readonly g6: number;
    /**
     * 驾车路径规划策略：（不走高速且避免收费 : 5）
     * @since 1.0.0
     */
    static readonly h6: number;
    /**
     * 驾车路径规划策略：（不走高速且躲避拥堵 : 6）
     * @since 1.0.0
     */
    static readonly i6: number;
    /**
     * 驾车路径规划策略：（躲避收费和拥堵 : 7）
     * @since 1.0.0
     */
    static readonly j6: number;
    /**
     * 驾车路径规划策略：（不走高速躲避收费和拥堵 : 8）
     * @since 1.0.0
     */
    static readonly k6: number;
    /**
     * 公交路径规划策略：（最快捷 : 0）
     * @since 1.0.0
     */
    static readonly l6: number;
    /**
     * 公交路径规划策略：（费用优先 : 1）
     * @since 1.0.0
     */
    static readonly m6: number;
    /**
     * 公交路径规划策略：（最少换乘 : 2）
     * @since 1.0.0
     */
    static readonly n6: number;
    /**
     * 公交路径规划策略：（最少步行 : 3）
     * @since 1.0.0
     */
    static readonly o6: number;
    /**
     * 公交路径规划策略：（最舒适 : 4）
     * @since 1.0.0
     */
    static readonly p6: number;
    /**
     * 公交路径规划策略：（不乘地铁 : 5）
     * @since 1.0.0
     */
    static readonly q6: number;
    private static readonly r6;
    private static readonly s6;
    /** 弧度 PI/180 **/
    private static readonly R;
    private static readonly t6;
    /**
     * 根据用户的起点和终点经纬度计算两点间距离，单位米。
     *
     * @param startLatlng 起点的坐标。
     * @param endLatlng   终点的坐标。
     * @return 返回两点间的距离，单位米。
     * @since 1.0.0
     */
    static calculateLineDistance(k5: LatLng, l5: LatLng): number;
    /**
     * 计算多边形的面积，单位平方米。
     *
     * @param points     多边形顶点坐标。
     * @return 返回多边形的面积，单位平方米。
     * @since 1.0.0
     */
    static calculatePolygonArea(points: ArrayList<LatLng>): number;
    /**
     * 计算地图上矩形区域的面积，单位平方米。
     *
     * @param leftTopLatlng     矩形区域左上角坐标。
     * @param rightBottomLatlng 矩形区域右下角坐标。
     * @return 返回地图上矩形区域的面积，单位平方米。
     * @since 1.0.0
     */
    static calculateRectangleArea(e5: LatLng, f5: LatLng): number;
    /**
     * 跳转到高德地图APP最新版本下载页面
     *
     * @param context 上下文
     * @since 1.0.0
     */
    static getLatestAMapApp(context: Context | null): void;
    /**
     * 判断高德地图app是否已经安装
     *
     * @param context
     * @return true：已安装 false 未安装
     * @throws AMapException
     */
    private static u6;
}
