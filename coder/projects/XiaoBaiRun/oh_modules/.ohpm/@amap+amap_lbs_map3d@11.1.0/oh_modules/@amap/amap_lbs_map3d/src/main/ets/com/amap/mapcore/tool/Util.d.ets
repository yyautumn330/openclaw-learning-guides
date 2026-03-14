// @keepTs
// @ts-nocheck
/**
 */
import { SDKInfo } from '@amap/amap_lbs_common';
import HashMap from '@ohos.util.HashMap';
import { PolylineOptions } from '../../api/model/PolylineOptions';
import { LatLng } from '../../api/model/LatLng';
import { PolygonOptions } from '../../api/model/PolygonOptions';
import { BaseHoleOptions } from '../../api/model/BaseHoleOptions';
import { Point } from '../../api/model/Point';
import { Rect } from '../../api/model/Rect';
import ArrayList from '@ohos.util.ArrayList';
import { v6 } from '../camera/AbstractCameraUpdateMessage';
import { x59 } from '../interface/IGLMapState';
import { LatLngBounds } from '../../api/model/LatLngBounds';
import { PolygonHoleOptions } from '../../api/model/PolygonHoleOptions';
import { CircleHoleOptions } from '../../api/model/CircleHoleOptions';
import { b53 } from '../MapConfig';
export declare class Util {
    static h47: number;
    static f24: number;
    /** / 弧度 PI/180*/
    static t6: number;
    static n261: number;
    static o261: number;
    static p261: number;
    static q261: number;
    static r261: number;
    static s261: number;
    static t261: number;
    static u261: number;
    static v261: number;
    static w261: number;
    static x261: number;
    static y261: number;
    static z261: number;
    static a262: number;
    static b262: number;
    static a251: number;
    static c262: number;
    static d262: number;
    private static e262;
    private static f262;
    private static ICON_ID_PREFIX;
    static g262(distance: number): string;
    static a16(): void;
    static p63(info: string): void;
    private static h262;
    /**
     * 根据key记录一个起始时间
     * @param key
     */
    static i262(key: string): void;
    /**
     * 根据key，获取当前时间到上一次记录的时间差
     * @param key
     * @return
     */
    static j262(key: string): number;
    static q58(l261: Error): void;
    /**
     * 获取离线地图存放目录 amap/data/ 或者 MapsInitializer.sdcardDir/data/ <br>
     * 如果目录不能存在，会自动重建
     *
     * @param context
     * @return 离线地图存放目录，返回null表示存放路径有误
     */
    static a185(context: Context): string;
    /**
     * 获取旧版 缓存目录，如AE8 V4
     * @param mContext
     * @return
     */
    static h205(j261: Context): string;
    /**
     * 离线地图存放临时文件目录
     *
     * @param context
     * @return
     */
    static l199(context: Context): string | undefined;
    /**
     * 值拼串
     *
     * @return
     */
    static w35(...str: string[]): string;
    /**
     * 键值对拼串
     *
     * @param key
     * @param value
     * @return
     */
    static x35(key: string, value: string): string;
    static r11(): SDKInfo;
    static getNearestLatLng(options: PolylineOptions, latLng: LatLng): LatLng;
    static d24(options: PolygonOptions, latLng: LatLng): boolean;
    /**
     * 判断点是否被hole包含
     * @param holeOption
     * @param point
     * @return
     */
    static contains(y260: BaseHoleOptions, point: LatLng, latLng: LatLng, radius?: number): boolean;
    /**
     * 判断点是否在多边形中
     * @return
     */
    static l262(v260: ArrayList<LatLng>, w260: ArrayList<BaseHoleOptions>, point: LatLng): boolean;
    /**
     * 判断面是否在圆内
     * @return
     */
    static s24(radius: number, point: LatLng, r260: ArrayList<BaseHoleOptions>, s260: PolygonHoleOptions): boolean;
    /**
     * 判断圆是否在当前圆内
     * @return
     */
    static u24(radius: number, point: LatLng, p260: CircleHoleOptions): boolean;
    /**
     * 判断点是否在圆内
     * @return
     */
    static m262(radius: number, point: LatLng, n260: ArrayList<BaseHoleOptions>, latLng: LatLng): boolean;
    /**
     * 判断点是否被hole包含
     * @param holeOption
     * @param point
     * @return
     */
    static n262(i260: BaseHoleOptions, point: LatLng): boolean;
    private static k262;
    static a205(file: string): string;
    static e119(q259: LatLng, r259: ArrayList<LatLng>): boolean;
    static isIntersect(i259: number, j259: number, k259: number, l259: number, m259: number, n259: number, o259: number, p259: number): boolean;
    static multiply(c259: number, d259: number, e259: number, f259: number, g259: number, h259: number): number;
    static o262(w258: number, x258: number, y258: number, z258: number, a259: number, b259: number): boolean;
    /**
     * 根据半径和中心点创建圆
     * @param points 结果经纬度
     * @param centerpoint 中心点
     * @param radius 单位米
     */
    static g24(points: ArrayList<LatLng>, q258: LatLng, radius: number): void;
    private static readonly p262;
    private static readonly q262;
    /**
     * 获取指定纬度内，一米有多长
     * @param latitude
     * @return
     */
    static r262(latitude: number): number;
    static hitTest(rect: Rect, x: number, y: number): boolean;
    /**
     * 根据经纬度计算需要偏转的角度
     *
     * @param curPos
     * @param nextPos
     * @return
     */
    static getRotate(n258: Point, o258: Point): number;
    /**
     * 判断小面是否在大面内
     * @return
     */
    static t43(j258: ArrayList<LatLng>, k258: PolygonHoleOptions): boolean;
    /**
     * 判断圆在面内
     * @return
     */
    static u43(g258: ArrayList<LatLng>, h258: ArrayList<BaseHoleOptions>, i258: CircleHoleOptions): boolean;
    /**
     * 比较APP版本号的大小
     * <p>
     * 1、前者大则返回一个正数
     * 2、后者大返回一个负数
     * 3、相等则返回0
     *
     * @param version1 app版本号
     * @param version2 app版本号
     * @return number
     */
    static t128(e258: string, f258: string): number;
    static q126(c258: string): string;
    /**
     * 判断number相等
     *
     * @param n1
     * @param n2
     * @param tolerance
     * @returns
     */
    static e24(z257: number, a258: number, b258: number): boolean;
    /**
     * 由string产生hash code
     *
     * @param value
     * @returns
     */
    static hashCode(value: string): number;
    static e58(path: String): Uint8Array;
    static t262(context: Context, x257: string): Uint8Array;
    /**
     *
     * @param src
     * @param color
     * @param lineColor 网格线颜色,横竖的第一像素是网格线的颜色
     * @param isKeepLineColor 是否需要修改网格线，如果为false 则lineColor无效
     * @return
     */
    static r67(src: Uint8Array, color: number, lineColor?: number, t257?: boolean): Uint8Array;
    /**
     *
     * @param src
     * @param color
     * @param lineColor 网格线颜色,横竖的第一像素是网格线的颜色
     * @param isKeepLineColor 是否需要修改网格线，如果为false 则lineColor无效
     * @return
     */
    static q59(src: Uint8Array, color: number, lineColor?: number, f257?: boolean): Promise<Uint8Array | undefined>;
    private static nextId;
    static o23(): number;
    static o175(str: string): HashMap<string, string>;
    static r181(str: string): ArrayList<string>;
    static a113(b257: b53 | undefined, tilt: number, zoom: number): number;
    static v91(a257: b53 | undefined, zoom: number): number;
    static newLatLngBoundsWithSize(t256: v6, u256: x59, v256: b53): [
        number,
        Point
    ] | undefined;
    static g90(z255: b53, a256: number, b256: number, c256: number, d256: number, bounds: LatLngBounds | undefined, width: number, height: number): [
        number,
        Point
    ] | undefined;
    /**
     * 通过Geo两点坐标，屏幕指定的宽度，屏幕指定的高度获取地图缩放级别
     *
     * @param x1         Geo坐标X1
     * @param y1         Geo坐标y1
     * @param x2         Geo坐标X2
     * @param y2         Geo坐标y2
     * @param targetWinW 屏幕指定的宽度
     * @param targetWinH 屏幕指定的高度
     */
    static m88(s255: b53, x1: number, y1: number, x2: number, y2: number, t255: number, u255: number): [
        number,
        boolean
    ];
    /**
     * 检测中心点是否满足限制区域
     * @param roundRight 右边界
     * @param roundTop 上边界
     * @param roundLeft 左边界
     * @param roundBottom 下边界
     * @param mapConfig
     * @param proj
     * @param centerX
     * @param centerY
     * @return
     */
    static e90(z254: number, a255: number, b255: number, c255: number, d255: b53, e255: x59, centerX: number, centerY: number): number[];
    /**
     * 通过Geo两点坐标，屏幕指定的宽度，屏幕指定的高度获取地图缩放级别
     *
     * @param x1         Geo坐标X1
     * @param y1         Geo坐标y1
     * @param x2         Geo坐标X2
     * @param y2         Geo坐标y2
     * @param targetWinW 屏幕指定的宽度
     * @param targetWinH 屏幕指定的高度
     */
    static b90(t254: b53, x1: number, y1: number, x2: number, y2: number, u254: number, v254: number): number;
    static z91(p254: number, q254: number, r254: number): number;
    private static w262;
    private static x262;
    /**
     * 判断多边形 与已添加面是否相交
     * @param options
     * @return
     */
    static t24(g254: ArrayList<BaseHoleOptions>, options: PolygonHoleOptions): boolean;
    /**
     * 判断圆 与已添加面是否相交
     * @param options
     * @return
     */
    static v24(b254: ArrayList<BaseHoleOptions>, options: CircleHoleOptions): boolean;
    /**
     * 判断两个圆是否相交
     * @param options
     * @param circleHoleOptions
     * @return
     */
    static z262(options: CircleHoleOptions, a254: CircleHoleOptions): boolean;
    /**
     * 判断面与圆是否相交
     * @param points
     * @param circleHoleOptions
     * @return
     */
    static s262(points: ArrayList<LatLng>, u253: CircleHoleOptions): boolean;
    /**
     * 判断面与面相交
     * @param polygonPoints
     * @param polygon2Points
     * @return
     */
    static y262(q253: ArrayList<LatLng>, r253: ArrayList<LatLng>): boolean;
    /**
     * 根据每两个线段判断是否相交
     * @param polygonPoints
     * @param polygon2Points
     * @return
     */
    private static a263;
    static t214(h253: x59, centerX: number, centerY: number, i253: number, j253: number, screenY: number): number;
    static b263(e253: x59, centerX: number, centerY: number, f253: number, g253: number, screenY: number): number;
    /**
     * 检测地图是否初始化完成
     *
     * @param width
     * @param height
     * @return
     */
    static v97(width: number, height: number): boolean;
    /**
     * rgba 的像素数据，bitmap为 argb
     * @param isNeedFlipY 是否需要在y方向上翻转，opengl的图片y轴向下，会有需要翻转的场景
     * @return
     */
    static o121(colors: Int32Array, width: number, height: number, v252: boolean): PixelMap | undefined;
    static h10(context: Context): boolean;
}
