// @keepTs
// @ts-nocheck
import { z48 } from '../mapcore/AMapCallback';
import { a49 } from '../mapcore/interface/IProjection';
import { LatLng } from './model/LatLng';
import { Point } from './model/Point';
import { VisibleRegion } from './model/VisibleRegion';
import { LatLngBounds } from './model/LatLngBounds';
import { TileProjection } from './model/TileProjection';
/**
 * Projection接口用于屏幕像素点坐标系统和地球表面经纬度点坐标系统之间的变换。
 *
 * @since 1.0.0
 */
export declare class Projection {
    private readonly projectionDelegate;
    /**
     * @exclude javadoc中不显示
     */
    constructor(j49: a49);
    /**
     * 将屏幕坐标转换成地理坐标。
     *
     * @param paramPoint 屏幕坐标 如果传入null 则返回null。
     * @return 地理坐标。
     * @since 1.0.0
     */
    fromScreenLocation(i49: Point, callback: z48<LatLng>): void;
    /**
     * 将地理坐标转换成屏幕坐标。
     *
     * @param paramLatLng 地理坐标 如果传入 null 则返回null。
     * @return 屏幕坐标。
     * @since 1.0.0
     */
    toScreenLocation(h49: LatLng, callback: z48<Point>): void;
    /**
     * 将屏幕坐标转换成地理坐标。
     *
     * @param paramPoint 屏幕坐标 如果传入null 则返回null。
     * @return 地理坐标。
     * @since V2.0
     */
    fromScreenLocationSync(g49: Point): LatLng;
    /**
     * 将地理坐标转换成屏幕坐标。
     *
     * @param paramLatLng 地理坐标 如果传入 null 则返回null。
     * @return 屏幕坐标。
     * @since V2.0
     */
    toScreenLocationSync(f49: LatLng): Point;
    /**
     * 将地理坐标转换成openGL坐标，在{@link CustomRenderer#onDrawFrame(GL10)}中使用openGL坐标绘制。
     *
     * @param paramLatLng 地理坐标 如果传入 null 则返回null
     * @return opengl坐标
     * @since V2.0
     */
    toMapLocation(e49: LatLng): Point;
    /**
     * 将地理坐标转换成openGL坐标，在{@link CustomRenderer#onDrawFrame(GL10)}中使用openGL坐标绘制。
     *
     * @param paramLatLng 地理坐标 如果传入 null 则返回null
     * @return opengl坐标
     * @since V2.0.0
     */
    toOpenGLLocation(d49: LatLng): Point;
    /**
     * 返回一个屏幕宽度转换来的openGL 需要的宽度。
     *
     * @param screenWidth 屏幕的宽度（像素）。
     * @return openGL坐标宽度。
     * @since V2.0.0
     */
    toOpenGLWidth(screenWidth: number): number;
    /**
     * 返回当前可视区域（包含MapView四个角点的经纬度坐标）坐标信息。
     *
     * @param
     * @return VisibleRegion 可视区域坐标信息。
     * @since V2.0
     */
    getVisibleRegion(): VisibleRegion | undefined;
    /**
     * 根据指定的经纬度范围及缩放级别，返回SDK适用的瓦片编号范围（按照指定的瓦片宽度切图）。
     *
     * @param lb    经纬度范围。
     * @param zoom  缩放级别。
     * @param width 瓦片宽度。要求为2 的 n次方。
     * @return 瓦片编号范围。
     * @since V2.0.0
     */
    fromBoundsToTile(c49: LatLngBounds, zoom: number, width: number): TileProjection;
    /**
     * 根据中心点和zoom级别获取地图控件对应的目标区域
     *
     * @param center 坐标中心
     * @param zoom   zoom级别
     * @return 返回一个经纬度矩形局域
     * @since V2.0.0
     */
    getMapBounds(center: LatLng, zoom: number): LatLngBounds;
    /**
     * 获取地图引擎Camera信息
     * @return
     * @exclude javadoc中不显示
     */
    /**
     * 屏幕纵向，将指定经纬度显示在屏幕内需要的缩放级别
     * 支持带仰角和旋转角度的情况，用于导航锁车过程中自动缩放计算
     * @param target 目标经纬度
     * @param screenTopY 目标经纬度距离屏幕顶部像素距离
     * @exclude javadoc中不显示
     */
    calZoomByTargetPos(target: LatLng, b49: number): number;
}
