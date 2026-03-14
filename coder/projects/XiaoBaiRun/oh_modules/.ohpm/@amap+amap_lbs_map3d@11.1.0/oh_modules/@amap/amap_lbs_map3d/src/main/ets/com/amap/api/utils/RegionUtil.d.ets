// @keepTs
// @ts-nocheck
/**
 * 工具类
 *
 * @version 1.0.0
 */
import ArrayList from "@ohos.util.ArrayList";
import { IPoint } from './overlay/IPoint';
export declare class RegionUtil {
    private static readonly i52;
    private static readonly j52;
    private static readonly k52;
    private static readonly WIDTH;
    private static readonly HEIGHT;
    /** 切片尺寸*/
    private static readonly l52;
    /** 0级切图每像素代表的距离*/
    private static readonly m52;
    /** 切图的最大边界值*/
    private static readonly n52;
    /**
     * 给定经纬度是不是在中国的判断
     *
     * @param lat
     * @param lng
     * @return
     */
    static isChinaLocation(g52: number, h52: number): boolean;
    /**
     * 判断切片是不是在国内
     *
     * @param x
     * @param y
     * @param zoom
     * @return
     */
    static isChina(x: number, y: number, zoom: number): boolean;
    static p52(clipRect: ArrayList<IPoint>): boolean;
    private static o52;
    static readonly q52: number;
    static readonly r52: number;
    static readonly s52: number;
}
