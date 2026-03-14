// @keepTs
// @ts-nocheck
/**
 * 为了云控提取出对外的IProjection接口，供 {@link com.amap.api.maps.Projection} 使用
 * @since 1.0.0
 */
import { AMapCameraInfo } from '../../api/model/AMapCameraInfo';
import { LatLng } from '../../api/model/LatLng';
import { LatLngBounds } from '../../api/model/LatLngBounds';
import { Point } from '../../api/model/Point';
import { TileProjection } from '../../api/model/TileProjection';
import { VisibleRegion } from '../../api/model/VisibleRegion';
import { z48 } from '../AMapCallback';
export interface a49 {
    /**
     * 将屏幕坐标转换成地理坐标。
     *
     * @param paramf 屏幕坐标 如果传入null 则返回null。
     * @param callback
     * @return 地理坐标。
     * @since V2.0
     * @throws RemoteException
     */
    fromScreenLocation(paramf: Point, callback?: z48<LatLng>): void;
    /**
     * 将地理坐标转换成屏幕坐标。
     *
     * @param paramLatLng 地理坐标 如果传入 null 则返回null。
     * @return 屏幕坐标。
     * @since V2.0
     * @throws RemoteException
     */
    toScreenLocation(paramLatLng: LatLng, callback?: z48<Point>): void;
    /**
     * 返回当前可视区域（包含MapView四个角点的经纬度坐标）坐标信息。
     *
     * @return VisibleRegion 可视区域坐标信息。
     * @since V2.0
     * @throws RemoteException
     */
    /**
     * 将屏幕坐标转换成地理坐标。
     *
     * @param paramf 屏幕坐标 如果传入null 则返回null。
     * @return 地理坐标。
     * @since V2.0
     * @throws RemoteException
     */
    fromScreenLocationSync(paramf: Point): LatLng;
    /**
     * 将地理坐标转换成屏幕坐标。
     *
     * @param paramLatLng 地理坐标 如果传入 null 则返回null。
     * @return 屏幕坐标。
     * @since V2.0
     * @throws RemoteException
     */
    toScreenLocationSync(paramLatLng: LatLng): Point;
    /**
     * 将地理坐标转换成openGL坐标，在{@link CustomRenderer#onDrawFrame(GL10)}中使用openGL坐标绘制。
     *
     * @param paramLatLng 地理坐标 如果传入 null 则返回null
     * @return opengl坐标
     * @since V2.0
     * @throws RemoteException
     */
    toMapLocation(paramLatLng: LatLng): Point;
    /**
     * 返回当前可视区域（包含MapView四个角点的经纬度坐标）坐标信息。
     *
     * @return VisibleRegion 可视区域坐标信息。
     * @since V2.0
     * @throws RemoteException
     */
    getVisibleRegion(): VisibleRegion;
    /**
     * 返回一个屏幕宽度转换来的openGL 需要的宽度。
     *
     * @param winWidth 屏幕的宽度（像素）。
     * @return openGL坐标宽度。
     * @since V2.1.4
     * @throws RemoteException
     */
    k49(winWidth: number): number;
    /**
     * 根据指定的经纬度范围及缩放级别，返回SDK适用的瓦片编号范围（按照指定的瓦片宽度切图）。
     *
     * @param lb    经纬度范围。
     * @param zoom  缩放级别。
     * @param width 瓦片宽度。要求为2 的 n次方。
     * @return 瓦片编号范围。
     * @since V2.0.0
     * @throws RemoteException
     */
    fromBoundsToTile(lb: LatLngBounds, zoom: number, width: number): TileProjection;
    /**
     * 根据中心点和zoom级别获取地图控件对应的目标区域
     *
     * @param center 坐标中心
     * @param zoom   zoom级别
     * @return 返回一个经纬度矩形局域
     * @since V2.0.0
     * @throws RemoteException
     */
    getMapBounds(center: LatLng, zoom: number): LatLngBounds;
    /**
     * 获取地图引擎Camera信息
     * @return AMapCameraInfo
     * @exclude javadoc中不显示
     */
    t167(): AMapCameraInfo;
    l49(target: LatLng, screenTopY: number): number;
}
