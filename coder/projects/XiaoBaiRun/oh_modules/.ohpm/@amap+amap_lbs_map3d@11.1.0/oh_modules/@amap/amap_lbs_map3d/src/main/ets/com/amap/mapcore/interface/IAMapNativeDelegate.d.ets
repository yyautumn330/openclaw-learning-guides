// @keepTs
// @ts-nocheck
/**
 * 内部AMap接口方法
 *
 */
import { CameraPosition } from '../../api/model/CameraPosition';
import { LatLng } from '../../api/model/LatLng';
import { Rect } from '../../api/model/Rect';
import { LatLngBounds } from '../../api/model/LatLngBounds';
import { Point } from '../../api/model/Point';
import { AMapAppRequestParamWrapper } from '../AMapAppRequestParamWrapper';
import { b53 } from '../MapConfig';
import { s60 } from './IGLMapEngine';
import { d16 } from './IGLOverlayLayer';
import { n66 } from './IAMapEngineCallback';
import geoLocationManager from "@ohos.geoLocationManager";
import { x59 } from './IGLMapState';
import { o66 } from '../MapPoi';
import { p72 } from '../message/AbstractGestureMapMessage';
import { BaseOverlay } from '../../api/model/BaseOverlay';
import { n60 } from '../widget/IInfoWindow';
import { TileOverlayOptions } from '../../api/model/TileOverlayOptions';
import { TileOverlay } from '../../api/model/TileOverlay';
import { h73 } from '../GLTextureProperty';
import { BitmapDescriptor } from '../../api/model/BitmapDescriptor';
import { j73 } from '../BaseMapOverlay';
import { i73 } from '../GLOverlay';
import { IAMap } from './IAMap';
export interface p66 extends IAMap {
    addTileOverlay(tileOverlayOptions: TileOverlayOptions): TileOverlay | undefined;
    /**
     * 清除Tile缓存
     */
    clearTileCache(): void;
    /**
     * 获取地图状态操作对象
     *
     * @return 地图状态操作对象
     */
    v90(): x59 | undefined;
    /**
     * 显示定位小蓝点
     *
     * @param location 定位点
     * @throws RemoteException remote异常
     */
    d91(location: geoLocationManager.Location): void;
    /**
     * 删除绘制的线面
     *
     * @param id 覆盖物id
     * @return true 表示删除成功
     * @throws RemoteException remote异常
     */
    t91(id: string): boolean;
    /**
     * 重新调整覆盖物的index，添加覆盖物时调用
     */
    u91(): void;
    /**
     * 检测zoom超出部分返回 最大 或最小值
     *
     * @param zoom 缩放级别
     * @return 检查后的级别
     * @throws RemoteException
     */
    v91(zoom: number): number;
    /**
     * 经纬度转20级坐标
     *
     * @param lat   纬度
     * @param lng   经度
     * @param point 20级坐标
     */
    w91(lat: number, lng: number, point: Point): void;
    /**
     * 20级转map坐标
     *
     * @param lat   x
     * @param lng   y
     * @param point map坐标
     */
    x91(x: number, y: number, point: Point): void;
    /**
     * 20级转经纬度坐标
     *
     * @param x     x
     * @param y     y
     * @param point 经纬度
     */
    y91(x: number, y: number, point: Point): void;
    /**
     * 获取当前缩放级别
     *
     * @return 缩放级别
     */
    z91(): number;
    /**
     * 获取当前地图的最大缩放级别
     *
     * @return 缩放级别
     */
    getMaxZoomLevel(): number;
    /**
     * 获取当前地图的最大缩放级别
     *
     * @return 缩放级别
     */
    getMinZoomLevel(): number;
    /**
     * 获取UiSettings
     *
     * @return uisettings
     */
    /**
     * 获取Projection
     *
     * @return projection
     * @throws RemoteException
     */
    /**
     * 获取位置改变监听事件
     *
     * @return 监听事件
     * @throws RemoteException
     */
    /**
     * 长按地图
     *
     * @param engineID 引擎id 引擎id
     * @param e        手势事件
     */
    /**
     * 手势单击确定
     *
     * @param engineID 引擎id 引擎id
     * @param e        手势事件
     * @return true 表示消费不继续传递
     */
    /**
     * 双击手势
     *
     * @param engineID 引擎id 引擎id
     * @param e        手势事件
     * @return true 表示消费掉
     */
    /**
     * 显示infowindiw
     *
     * @param marker 需要显示infowindow的Marker
     * @throws RemoteException
     */
    showInfoWindow(marker: BaseOverlay): void;
    /**
     * 隐藏InfoWindow，InfoWindow只有一个所有不存在隐藏某个指定Marker的InfoWindow的问题
     */
    hideInfoWindow(): void;
    /**
     * 经纬度转map坐标
     *
     * @param lat   x
     * @param lng   y
     * @param point 坐标
     */
    a92(lat: number, lng: number, point: Point): void;
    /**
     * 像素转经纬度
     *
     * @param xPixel x
     * @param yPixel y
     * @param reslut 坐标
     */
    v37(xPixel: number, yPixel: number, reslut: Point): void;
    /**
     * 经纬度转像素
     *
     * @param lat   x
     * @param lng   y
     * @param point 坐标
     */
    d92(lat: number, lng: number, point: Point): void;
    /**
     * 像素转20级
     *
     * @param xPixel x
     * @param yPixel y
     * @param reslut 坐标
     */
    j92(xPixel: number, yPixel: number, reslut: Point): void;
    /**
     * 刷新InfoWindow
     */
    redrawInfoWindow(): void;
    j90(): n60;
    /**
     * 是否显示缩放按钮控件
     *
     * @param isZoomEnabled true 表示显示
     */
    k92(isZoomEnabled: boolean): void;
    /**
     * 是否显示室内地图滑块
     *
     * @param isIndoorSwitchEnabled true 显示
     */
    l92(isIndoorSwitchEnabled: boolean): void;
    /**
     * 是否显示定位控件
     *
     * @param isMyLocationButtonEnabled true 显示
     */
    m92(isMyLocationButtonEnabled: boolean): void;
    /**
     * 是否显示指南针控件
     *
     * @param isCompassEnabled true 显示
     */
    n92(isCompassEnabled: boolean): void;
    /**
     * 是否显示比例尺控件
     *
     * @param isScaleEnabled true 显示
     */
    o92(isScaleEnabled: boolean): void;
    /**
     * 设置缩放按钮位置
     *
     * @param position 位置常量
     */
    setZoomPosition(position: number): void;
    /**
     * 获取MapView的大小
     *
     * @return MapView大小
     */
    p92(): Rect;
    /**
     * 指定参数生成bounds，正好显示这些属性的bounds
     *
     * @param center  中心点
     * @param zoom    缩放级别
     * @param bearing 旋转角度
     * @param tilt    仰角
     * @return bounds
     */
    getMapBounds(center: LatLng, zoom: number, bearing: number, tilt: number): LatLngBounds;
    /**
     * 生命周期
     */
    onResume(): void;
    /**
     * 生命周期
     */
    onPause(): void;
    /**
     * 像素转地图坐标
     *
     * @param x     x
     * @param y     y
     * @param point 坐标
     */
    r92(x: number, y: number, point: Point): void;
    /**
     * 地图坐标转20级坐标
     *
     * @param x     x
     * @param y     y
     * @param point 坐标
     */
    s92(x: number, y: number, point: Point): void;
    /**
     * 屏幕长度对应地图坐标系统长度
     *
     * @param winWidth 屏幕长度
     * @return 地图长度
     */
    k49(winWidth: number): number;
    /**
     * 获取地图状态
     *
     * @param isUseAnchor 是否使用anchor
     * @return 地图状态
     */
    u92(isUseAnchor: boolean): CameraPosition;
    /**
     * 是否使用anchor，即是否修改过投影中心
     *
     * @return true 表示是
     */
    w92(): boolean;
    /**
     * 获取logo位置
     *
     * @return 屏幕坐标
     */
    x92(): Point;
    /**
     * 获取缩放比例，和分辨率有关，创建地图时设置
     *
     * @return 比例
     */
    y92(): number;
    /**
     * 获取是否可以展示室内地图楼层控件，展示室内地图时才可以显示
     *
     * @return true 表示可以
     */
    z92(): boolean;
    /**
     * 获取logo的位置，分为左 中 右 不是具体点
     *
     * @return 位置常量
     */
    getLogoPosition(): number;
    /**
     * 设置Logo位置 分为左 中 右 不是具体点
     *
     * @param position 位置常量
     */
    setLogoPosition(position: number): void;
    /**
     * 设置logo下边距
     *
     * @param iPixels 像素
     */
    setLogoBottomMargin(iPixels: number): void;
    /**
     * 设置logo左边距
     *
     * @param pixels 像素
     */
    setLogoLeftMargin(pixels: number): void;
    /**
     * 获取指定类型的比例
     *
     * @param type 类型
     * @return 比例
     */
    getLogoMarginRate(type: number): number;
    /**
     * 通过比例设置logo位置
     *
     * @param type 类型 左右等
     * @param rate 比例
     */
    setLogoMarginRate(type: number, rate: number): void;
    /**
     * 获取蒙层类型
     *
     * @return 类型
     */
    a93(): number;
    /**
     * opengl线程执行任务
     *
     * @param runnable 任务
     */
    /**
     * 修改地图位置
     *
     * @param cameraUpdate 地图位置属性
     * @throws RemoteException
     */
    /**
     * 动画修改地图位置
     *
     * @param cameraUpdateDelegate 地图位置属性
     * @throws RemoteException
     */
    /**
     * 动画修改地图位置，带回调
     *
     * @param cameraUpdateDelegate 地图位置属性
     * @param durationMs           动画时间
     * @param cancelableCallback   动画回调
     */
    /**
     * 改变logo样式，卫星模式下需要修改
     *
     * @param engineID 引擎id 引擎id
     * @param isStiFlag 是否是卫星模式
     */
    b93(engineID: number, isStiFlag: boolean): void;
    /**
     * Surface大小发生改变 可能会调用多次
     *
     * @param anEngineIdMain 引擎id
     * @param gl             gl
     * @param width          宽
     * @param height         高
     */
    /**
     * 创建Surface 调用一次
     *
     * @param anEngineIdMain 引擎id
     * @param gl             gl
     * @param config         gl配置
     */
    /**
     * 获取上下文
     *
     * @return 上线文
     */
    getContext(): Context;
    /**
     * 根据手势获取engineid 鹰眼时需要
     *
     * @param mGestureInfo 手势信息
     * @return 引擎id
     */
    /**
     * 获取引擎对象
     *
     * @return 引擎
     */
    j57(): s60;
    /**
     * 获取引擎回调
     *
     * @returns
     */
    s91(): n66;
    /**
     * 添加手势修改地图消息
     *
     * @param scaleAbstractGestureMapMessage 手势消息
     */
    j97(scaleAbstractGestureMapMessage: p72): void;
    /**
     * 设置手势状态
     *
     * @param engineID               引擎id
     * @param gestureSingleTapZoomin 手势状态
     */
    g93(engineID: number, gestureSingleTapZoomin: number): void;
    /**
     * 是否锁定地图角度
     *
     * @param engineID 引擎id
     * @return true 是
     */
    h93(engineID: number): boolean;
    /**
     * 获取地图旋转角度
     *
     * @param engineID 引擎id
     * @return 角度
     */
    q88(engineID: number): number;
    /**
     * 获取地图中心点 20级坐标
     *
     * @param engineID 引擎id
     * @param point    中心点
     */
    i93(engineID: number, point: Point): void;
    /**
     * 获取缩放级别
     *
     * @param engineID 引擎id
     * @return 缩放级别
     */
    j93(engineID: number): number;
    /**
     * 是否锁定仰角
     *
     * @return true锁定
     */
    k93(): boolean;
    /**
     * 获取仰角
     *
     * @param engineID 引擎id
     * @return 角度
     */
    o88(): number;
    /**
     * 缩小一级
     *
     * @param engineID 引擎id
     */
    zoomOut(engineID: number): void;
    /**
     * 室内展示回调
     *
     * @param engineID 引擎id
     * @param buffer   室内信息
     */
    b68(engineId: number, buffer: Uint8Array): void;
    /**
     * 设置 地图比例尺、指南针、地图前后台切换防止黑屏的前视图 监听
     *
     * @param listener 监听
     */
    /**
     * 获取view和Projection 相乘后的矩阵
     *
     * @return 矩阵
     */
    n93(): Float64Array;
    /**
     * 覆盖物overlay id创建
     *
     * @param type 类型
     * @return id
     */
    e8(type: string): string;
    /**
     * 是否显示logo
     *
     * @param isLogoEnabled true 显示
     */
    p93(isLogoEnabled: boolean): void;
    /**
     * 修改地图大小
     *
     * @param w w
     * @param h h
     */
    q93(w: number, h: number): void;
    /**
     * 设置开启定义地图时是否隐藏Logo
     *
     * @param isHideLogo true 隐藏
     */
    r93(isHideLogo: boolean): void;
    /**
     * 修改logo样式
     * @param path 图片路径
     * @param enable 是否开启
     * @param type 白天还是黑夜
     */
    s93(path: string, enable: boolean, type: number): void;
    /**
     * 主线程刷新logo,触发view的onDraw
     */
    t93(): void;
    /**
     * 重新设置地图更长的绘制帧率
     */
    y37(): void;
    /**
     * 设置自定义地图样式, 如果传入二进制则直接设置，否则从mapConfig中获取
     * 注意：仅在线拉去样式使用
     *
     * @param enable true表示齐
     * @param data   web样式内容
     */
    /**
     * 设置自定义样式
     *
     * @param enable        true 表示使用
     * @param isForceUpdate 是否强制刷新样式
     */
    z93(enable: boolean, isForceUpdate: boolean): void;
    /**
     * 重新加载自定义样式
     */
    d94(): void;
    /**
     * 删除3d模型
     *
     * @param id 模型id
     * @return boolan类型
     */
    e94(id: string): boolean;
    /**
     * 获取指定缩放级别的单位像素长度
     *
     * @param zoom 缩放级别
     * @return 像素大小
     */
    f94(zoom: number): number;
    o67(): d16;
    /**
     * 设置地图是否显示
     * @param enable
     */
    g94(enable: boolean): void;
    /**
     * 获取地图config 其中包含 绘制所需要的必要信息
     *
     * @return config
     */
    l57(): b53;
    /**
     * 地图是否加载完成
     *
     * @return true表示加载完成
     */
    h94(): boolean;
    /**
     * 移除引擎覆盖物
     *
     * @param glOverlay 覆盖物
     */
    i94(glOverlay: j73<i73, object>): void;
    /**
     * 添加引擎覆盖物纹理
     *
     * @param engineID        引擎id
     * @param textureProperty 纹理
     */
    j94(engineID: number, textureProperty: h73): void;
    o94(engineID: number, bitmap: BitmapDescriptor): number;
    onAMapAppResourceRequest(param: AMapAppRequestParamWrapper): void;
    /**
     * 地图poi点击
     *
     * @param poi
     */
    onMapPOIClick(poi: o66): void;
    /**
     * 地图空白点击
     *
     * @param x
     * @param y
     */
    onMapBlandClick(x: number, y: number): void;
    /**
     * 设置地形图鉴权
     *
     * @param isAuth
     */
    p94(isAuth: boolean): void;
    /**
     * 国际图鉴权
     *
     * @param isAuth
     */
    q94(isAuth: boolean): void;
    r94(): boolean;
    s69(): void;
    /**
     * 地图宽高 像素
     *
     * @return 单位像素
     */
    w65(): number;
    /**
     * 地图宽高 像素
     *
     * @return 单位像素
     */
    x65(): number;
    /**
     * 请求绘制
     */
    l3(): void;
    /**
     * 重新设置地图正常绘制帧率
     */
    n58(flag?: boolean): void;
    /**
     * 检查地图状态，设置限制区域时使用
     *
     * @param proj 目标状态
     */
    x89(proj: x59): void;
    /**
     * 获取地图加载情况
     * @return true:已加载 ，false:未加载
     */
    r69(): boolean;
}
