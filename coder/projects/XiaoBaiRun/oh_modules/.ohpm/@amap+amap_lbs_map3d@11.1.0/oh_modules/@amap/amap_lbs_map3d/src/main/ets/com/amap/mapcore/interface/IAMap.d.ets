// @keepTs
// @ts-nocheck
import geoLocationManager from '@ohos.geoLocationManager';
import * as AMap from '../../api/AMap';
import { CameraUpdate } from '../../api/CameraUpdate';
import { PolylineOptions } from '../../api/model/PolylineOptions';
import { Polyline } from '../../api/model/Polyline';
import { PolygonOptions } from '../../api/model/PolygonOptions';
import { Polygon } from '../../api/model/Polygon';
import { Circle } from '../../api/model/Circle';
import { CircleOptions } from '../../api/model/CircleOptions';
import { Marker } from '../../api/model/Marker';
import { MarkerOptions } from '../../api/model/MarkerOptions';
import { CameraPosition } from '../../api/model/CameraPosition';
import { MyLocationStyle } from '../../api/model/MyLocationStyle';
import { LocationSource } from '../../api/LocationSource';
import { CustomMapStyleOptions } from '../../api/model/CustomMapStyleOptions';
import { LatLngBounds } from '../../api/model/LatLngBounds';
import { Projection } from '../../api/Projection';
import { UiSettings } from '../../api/UiSettings';
import ArrayList from '@ohos.util.ArrayList';
import { GL3DModelOptions } from '../../api/model/GL3DModelOptions';
import { GL3DModel } from '../../api/model/GL3DModel';
import { LatLng } from '../../api/model/LatLng';
import { b53 } from '../MapConfig';
import { s60 } from './IGLMapEngine';
import { l39 } from '../../api/model/MyTrafficStyle';
import { f16 } from '../../api/model/amap3dmodeltile/AMap3DModelTileOverlayOptions';
import { g16 } from '../../api/model/amap3dmodeltile/AMap3DModelTileOverlay';
import { OnCustomMapStyleFailListener } from '../../api/AMap';
import { TextOptions } from '../../api/model/TextOptions';
import { Text } from '../../api/model/Text';
import { GroundOverlayOptions } from '../../api/model/GroundOverlayOptions';
import { GroundOverlay } from '../../api/model/GroundOverlay';
import { TileOverlay } from '../../api/model/TileOverlay';
import { TileOverlayOptions } from '../../api/model/TileOverlayOptions';
import { ArcOptions } from '../../api/model/ArcOptions';
import { Arc } from '../../api/model/Arc';
import { MultiPointOverlay } from '../../api/model/MultiPointOverlay';
import { MultiPointOverlayOptions } from '../../api/model/MultiPointOverlayOptions';
import { HeatMapLayerOptions } from '../../api/model/HeatMapLayerOptions';
import { HeatMapLayer } from '../../api/model/HeatMapLayer';
import { IndoorBuildingInfo } from '../../api/model/IndoorBuildingInfo';
import { IndoorFloorSwitchAdapter } from '../../api/model/IndoorFloorSwitchAdapter';
import { c1 } from '../../api/model/CrossOverlayOptions';
import { b1 } from '../../api/model/CrossOverlay';
/**
 * 对外提供接口
 */
export interface IAMap {
    /**
     * 地图组件ready时执行部分初始化逻辑
     */
    init(): void;
    /**
     * 按照传入的CameraUpdate参数改变地图状态。（直接改变状态，没有动画效果）<br>
     * 可以通过{@link CameraUpdateFactory#zoomIn()}等方法来生成对应的CameraUpdate对象。
     *
     * @param cameraUpdate 地图状态将要发生的变化。
     * @since 1.0.0
     */
    moveCamera(cameraUpdate: CameraUpdate): void;
    /**
     * 以动画方式按照传入的CameraUpdate参数更新地图状态，默认动画耗时250毫秒。<br>
     * 可以通过{@link CameraUpdateFactory#zoomIn()}等方法来生成对应的CameraUpdate对象。
     *
     * @param cameraUpdate 地图状态将要发生的变化。
     * @since 1.0.0
     */
    animateCamera(cameraUpdate: CameraUpdate): void;
    /**
     * 以动画方式按照传入的CameraUpdate参数更新地图状态。<br>
     * 可以通过{@link CameraUpdateFactory#zoomIn()}等方法来生成对应的CameraUpdate对象。
     *
     * @param cameraUpdate       地图状态将要发生的变化。
     * @param durationMs         动画时长
     * @throws RemoteException 参考RemoteException
     * @since V2.0.0
     */
    v2(cameraUpdate: CameraUpdate, durationMs: number): void;
    /**
     * 以动画方式按照传入的CameraUpdate参数更新地图状态，默认动画耗时250毫秒，同时设置一个cancelableCallback来监听动画执行的结果。<br>
     * 可以通过{@link CameraUpdateFactory#zoomIn()}等方法来生成对应的CameraUpdate对象。
     *
     * @param cameraUpdate       地图状态将要发生的变化。
     * @param cancelableCallback 如果动画正常完成，则会回调onFinish()方法，被中断时回调onCancel()。
     * @throws RemoteException 参考RemoteException
     * @since V2.0.0
     */
    u2(cameraUpdate: CameraUpdate, cancelableCallback: AMap.CancelableCallback): void;
    /**
     * 以动画方式按照传入的CameraUpdate参数更新地图状态，默认动画耗时250毫秒，同时设置一个cancelableCallback来监听动画执行的结果。<br>
     * 可以通过{@link CameraUpdateFactory#zoomIn()}等方法来生成对应的CameraUpdate对象。
     *
     * @param cameraUpdate       地图状态将要发生的变化。
     * @param durationMs         动画时长
     * @param cancelableCallback 如果动画正常完成，则会回调onFinish()方法，被中断时回调onCancel()。
     * @throws RemoteException 参考RemoteException
     * @since V2.0.0
     */
    t2(cameraUpdate: CameraUpdate, durationMs: number, cancelableCallback: AMap.CancelableCallback): void;
    /**
     * 停止动画
     *
     * @since 1.0.0
     */
    stopAnimation(): void;
    /**
     * 设置地图状态的监听接口。
     *
     * @param listener 地图状态的监听接口。
     * @since 1.0.0
     */
    setOnCameraChangeListener(listener: AMap.OnCameraChangeListener): void;
    /**
     * 添加地图状态的监听接口
     *
     * @param listener 监听
     */
    addOnCameraChangeListener(listener: AMap.OnCameraChangeListener): void;
    /**
     * 设置marker的信息窗口点击事件监听接口。
     *
     * @param listener 监听
     * @throws RemoteException
     */
    setOnInfoWindowClickListener(listener: AMap.OnInfoWindowClickListener): void;
    /**
     * 设置marker的信息窗口定制接口。
     *
     * @param adapter 定制实现类，有种多类型，这里是一个基类
     * @throws RemoteException
     */
    setInfoWindowAdapter(adapter: CustomBuilder | undefined): void;
    /**
     * 设置地图点击监听
     *
     * @param listener 监听
     * @since 1.0.0
     */
    setOnMapClickListener(listener: AMap.OnMapClickListener): void;
    /**
     * 设置地图长按监听
     *
     * @param listener 监听
     * @since 1.0.0
     */
    setOnMapLongClickListener(listener: AMap.OnMapLongClickListener): void;
    /**
     * 设置地图touch监听
     *
     * @param listener 监听
     * @since 1.0.0
     */
    setOnMapTouchListener(listener: AMap.OnMapTouchListener): void;
    /**
     * 添加地图touch监听
     *
     * @param listener 监听
     */
    addOnMapTouchListener(listener: AMap.OnMapTouchListener): void;
    /**
     * 设置地图加载完成监听，会在地图绘制第一帧完成的时候回调
     *
     * @param listener 监听
     * @since 1.0.0
     */
    z2(listener: AMap.OnMapReadyListener): void;
    /**
     * 添加地图加载完成监听接口
     *
     * @param listener 添加加载完成监听接口。   相比于OnMapReadyListener延迟启动，防止卡在第一帧白屏
     * @since 2.0.0
     */
    addOnMapReadyDelayListener(listener: AMap.OnMapReadyDelayListener): void;
    /**
     * 设置手势监听
     *
     * @param listener 监听
     * @since 1.0.0
     */
    setAMapGestureListener(listener: AMap.AMapGestureListener): void;
    /**
     * 添加路线overlay
     *
     * @param polylineOptions 路线属性
     * @return 路线对象
     */
    addPolyline(polylineOptions: PolylineOptions): Polyline;
    /**
     * 添加多边形
     *
     * @param polygonOptions 属性
     * @return 对象
     * @since 1.0.0
     */
    addPolygon(polygonOptions: PolygonOptions): Polygon;
    /**
     * 添加圆
     *
     * @since 1.0.0
     */
    addCircle(options: CircleOptions): Circle;
    /**
     * 添加弧线overlay
     *
     ** @since 1.0.0
     */
    addArc(options: ArcOptions): Arc;
    /**
     * 添加Marker
     *
     * @param markerOptions 默认属性
     * @return 对象
     */
    addMarker(markerOptions: MarkerOptions): Marker;
    /**
     * 添加多个Marker
     *
     * @param options        属性
     * @param isChangeCamera 是否将地图移动到正好显示所有marker
     * @since 1.0.0
     */
    addMarkers(options: ArrayList<MarkerOptions>, isChangeCamera: boolean): ArrayList<Marker>;
    /**
     * 添加文字覆盖物，和marker同级，会以图片形式在地图上展示
     *
     * @param textOptions 属性
     * @return 对象
     */
    addText(textOptions: TextOptions): Text;
    /**
     * 添加GroundOverlay覆盖物
     *
     * @param GroundOverlayOptions 属性
     * @return 对象
     * @since 1.0.0
     */
    addGroundOverlay(groundOverlayOptions: GroundOverlayOptions): GroundOverlay;
    /**
     * 添加3d模型
     *
     * @param options 参数配置信息
     * @return gl模型对象
     * @since 2.0.0
     */
    w2(options: GL3DModelOptions): GL3DModel;
    /**
     * 清除地图上所有覆盖物
     *
     * @param isKeepMyLocationOverlay true 则不会删除内置定位小蓝点
     * @since 1.0.0
     */
    clear(isKeepMyLocationOverlay?: boolean): void;
    /**
     * 销毁地图，生命周期中正常调用
     *
     * @since 1.0.0
     */
    destroy(): void;
    /**
     * 设置地图 view是否展示
     *
     * @param visibility 参考View的属性
     */
    t64(visibility: number): void;
    /**
     * 生命周期中正常调用
     */
    u64(): void;
    /**
     * 生命周期中正常调用
     */
    v64(): void;
    /**
     * 获取展示地图的view
     *
     * @return view
     * @throws RemoteException
     */
    /**
     * 获取地图的当前状态。
     *
     * @return 一个cameraPosition对象，表示地图的当前状态。
     * @since 1.0.0
     */
    getCameraPosition(): CameraPosition;
    /**
     * 获取地图类型 卫星或者黑夜等
     *
     * @return 类型
     * @since 1.0.0
     */
    getMapType(): AMap.MapType;
    /**
     * 获取定位图层（myLocationOverlay）的样式。
     *
     * @return myLocationStyle 定位图层（myLocationOverlay）样式。
     */
    getMyLocationStyle(): MyLocationStyle | undefined;
    /**
     * 如果开启了内置小蓝点，可以获取定位点
     *
     * @return 定位点
     */
    getMyLocation(): geoLocationManager.Location | undefined;
    /**
     * 是否显示海外
     * @param flag
     */
    d65(flag: boolean): void;
    /**
     * 设置地图类型
     *
     * @param type
     * @since 1.0.0
     */
    setMapType(type: AMap.MapType): void;
    /**
     * 设置定位来源，可以设置为外部gps定位
     *
     * @param locationSource 定位来源
     * @since 1.0.0
     */
    setLocationSource(locationSource: LocationSource): void;
    /**
     * 返回是否打开定位图层（myLocationOverlay）。
     *
     * @return 是否打开定位图层。
     * @since 2.0.0
     */
    isMyLocationEnabled(): boolean;
    /**
     * 设置是否打开定位图层（myLocationOverlay）。
     *
     * @param enabled 是否打开定位图层（myLocationOverlay）。
     * @since 1.0.0
     */
    setMyLocationEnabled(enabled: boolean): void;
    /**
     * 设置内置定位小蓝点 样式
     *
     * @param style 样式
     * @since 1.0.0
     */
    setMyLocationStyle(style: MyLocationStyle): void;
    /**
     * 设置自定义样式
     * @param options
     * @since 1.0.0
     */
    setCustomMapStyle(options: CustomMapStyleOptions, listener?: OnCustomMapStyleFailListener): void;
    /**
     * 设置自定义地图样式, 如果传入二进制则直接设置，否则从mapConfig中获取
     * 注意：仅在线拉去样式使用
     *
     * @param enable true表示齐
     * @param data   web样式内容
     */
    z63(enable: boolean, data: Uint8Array): void;
    /**
     * 设置地图最大缩放级别 缩放级别范围为[3, 20],超出范围将按最大级别计算 。
     * 注：只有在有室内地图显示的情况下最大级别为20，否则最大级别为19。
     *
     * @param zoomLevel 最大缩放等级
     * @since 1.0.0
     */
    setMaxZoomLevel(zoomLevel: number): void;
    /**
     * 设置最小缩放级别 缩放级别范围为[3, 20],超出范围将按最小级别计算
     *
     * @param zoomLevel 最小缩放等级
     * @since 1.0.0
     */
    setMinZoomLevel(zoomLevel: number): void;
    /**
     * 返回地图可显示最大缩放级别。
     *
     * @return 最大缩放级别。
     * @since 1.0.0
     */
    getMaxZoomLevel(): number;
    /**
     * 返回地图可显示最小缩放级别。
     *
     * @return 最小缩放级别。
     * @since 1.0.0
     */
    getMinZoomLevel(): number;
    /**
     * 重置最小及最大缩放级别 将恢复最小级别为3，最大级别为20 。
     * 注：只有在有室内地图显示的情况下最大级别为20，否则最大级别为19。
     * @since 2.0.0
     */
    resetMinMaxZoomPreference(): void;
    /**
     * 设置地图显示范围，无论如何操作地图，显示区域都不能超过该矩形区域。
     *
     * @param latLngBounds 通过指定的两个经纬度坐标（左下、右上）构建的一个矩形区域，详情参见{@link LatLngBounds}
     * @since 1.0.0
     */
    setMapStatusLimits(latLngBounds: LatLngBounds): void;
    /**
     * 设置是否打开交通图层。
     *
     * @param enabled 是否打开交通图层。
     * @since 1.0.0
     */
    setTrafficEnabled(enabled: boolean): void;
    /**
     * 是否打开交通图层。
     *
     * @return 是否打开交通图层。
     * @throws RemoteException
     */
    isTrafficEnabled(): boolean;
    /**
     * 是否显示3D建筑物，默认显示。<br>
     *
     * @return 是否显示3D建筑物，默认显示。<br>
     * @throws RemoteException
     */
    y63(): boolean;
    /**
     * 设置是否显示3D建筑物，默认显示。<br>
     *
     * @param enabled 是否显示3D建筑物，默认显示。<br>
     * @throws RemoteException
     */
    m3(enabled: boolean): void;
    /**
     * 设置是否显示底图文字标注，默认显示。
     *
     * @param enabled true： 表示显示，为默认值； false： 不显示
     * @since 1.0.0
     */
    e3(enabled: boolean): void;
    /**
     * 是否显示建筑物
     *
     * @param enabled true 表示显示
     * @since 1.0.0
     */
    f3(enabled: boolean): void;
    /**
     * 设置室内地图状态监听接口
     *
     * @param listener 室内地图状态监听接口。
     * @since V2.2.4
     */
    setIndoorFloorSwitchAdapter(listener: IndoorFloorSwitchAdapter): void;
    /**
     * 设置用户定位信息监听接口。
     *
     * @param listener 用户定位信息监听接口。
     * @since 1.0.0
     */
    setOnMyLocationChangeListener(listener: AMap.OnMyLocationChangeListener): void;
    /**
     * 设置地图marker拖拽监听
     *
     * @param dragStartListen 监听
     * @param dragListener 监听
     * @param dragEndListen 监听
     */
    setOnMarkerDragListener(listener: AMap.OnMarkerDragListener): void;
    /**
     * 设置地图Marker点击监听
     *
     * @param listener
     * @since 1.0.0
     */
    setOnMarkerClickListener(listener: AMap.OnMarkerClickListener): void;
    /**
     * 设置先线点击监听
     *
     * @param listener
     * @since 1.0.0
     */
    setOnPolylineClickListener(listener: AMap.OnPolylineClickListener): void;
    /**
     * 设置地图底图语言，目前支持中文底图和英文底图
     *
     * @param language AMap.CHINESE 表示中文，即"zh_cn", AMap.ENGLISH 表示英文，即"en"
     */
    setMapLanguage(language: string): void;
    /**
     * 获取地图ui控制器，可以控制内置ui（缩放按钮、指北针等）是否显示及部分手势（滑动、双指缩放等）是否可用。
     *
     * @return ui控制器
     */
    h3(): UiSettings;
    /**
     * 获取地图投影坐标转换器, 当地图初始化完成之前返回 null。<br>
     *
     * @return 地图投影坐标转换器。
     * @throws RemoteException
     */
    i3(): Projection;
    /**
     * 获取地图审图号（普通地图）<br>
     * <font color="red">任何使用高德地图API调用地图服务的应用必须在其应用中对外透出审图号</font><br>
     * 如高德地图在"关于"中体现
     *
     * @return 普通矢量地图审图号
     */
    getMapContentApprovalNumber(): string;
    /**
     * 获取地图审图号（卫星地图）<br>
     * <font color="red">任何使用高德地图API调用地图服务的应用必须在其应用中对外透出审图号</font><br>
     * 如高德地图在"关于"中体现
     *
     * @return 卫星地图审图号
     */
    getSatelliteImageApprovalNumber(): string;
    /**
     * 获取地图审图号 （地形图）<br>
     * <font color="red">任何使用高德地图API调用地图服务的应用必须在其应用中对外透出审图号</font><br>
     * 如高德地图在"关于"中体现
     *
     * @return 地形图地图审图号
     */
    getTerrainApprovalNumber(): string;
    /**
     * 获取地图宽度
     *
     * @returns
     * @since 1.0.0
     */
    w65(): number;
    /**
     * 获取地图高度
     *
     * @returns
     * @since 1.0.0
     */
    x65(): number;
    /**
     * 获取当前缩放级别下，地图上1像素点对应的长度，单位米。
     *
     * @return 当前缩放级别下，地图上1像素点对应的长度，单位米。
     * @since 1.0.0
     */
    getScalePerPixel(): number;
    /**
     * 清楚瓦片缓存
     * @since 1.0.0
     */
    clearTileCache(): void;
    /**
     *  低帧率运行
     *
     * @param isLow
     * @since 1.0.0
     */
    j3(isLow: boolean): void;
    /**
     * 移除覆盖物
     *
     * @param id
     * @since 1.0.0
     */
    removeOverlay(id: string): void;
    onCreate(): void;
    getNativeMapController(): bigint;
    a3(): number;
    /**
     * 设置导航模式label是否显示。
     *
     * @param enabled 是否显示label。
     * @param flushInterval 刷新标注的间隔帧数阈值。
     * @param flushMode 1时，实现强制刷新效果
     * @throws RemoteException
     */
    setNaviLabelEnable(enabled: boolean, flushInterval: number, flushMode: number): void;
    /**
     * 设置Poi是否可以点击
     * @param touchPoiEnable
     */
    setTouchPoiEnable(touchPoiEnable: boolean): void;
    /**
     * 是否允许单击poi
     * @return 默认为true
     */
    isTouchPoiEnable(): boolean;
    /**
     * 设置地图在初始化及每一帧绘制时的回调接口，该接口在OpenGL线程中调用。
     *
     * @param render opengl renderer
     * @throws RemoteException
     */
    setCustomRenderer(render: AMap.CustomRenderer): void;
    /**
     * 设置屏幕上的某个像素点为地图中心点。
     * <p>使用该方法设置后，地图将以所设置的屏幕坐标点为中心进行旋转、倾斜。同时， {@link #moveCamera(CameraUpdate) } 方法也将会以此坐标点为中心进行设置。
     *
     * @param x 屏幕像素点x轴坐标。
     * @param y 屏幕像素点y轴坐标。
     * @throws RemoteException
     */
    g3(x: number, y: number): void;
    addAMapAppResourceListener(listener: AMap.AMapAppResourceRequestListener): void;
    removeAMapAppResourceListener(listener: AMap.AMapAppResourceRequestListener): void;
    /**
     * 设置帧数
     *
     * @param fps 10~40
     */
    setRenderFps(fps: number): void;
    setIndoorBuildingInfo(indoorBuildingInfo: IndoorBuildingInfo): void;
    addInfoWindowListener(adapter: AMap.InfoWindowListener): void;
    removeInfoWindowListener(adapter: AMap.InfoWindowListener): void;
    addOnPOIClickListener(listener: AMap.OnMapPOIClickListener): void;
    removeOnPOIClickListener(listener: AMap.OnMapPOIClickListener): void;
    /**
     * 添加地图上polyline点击监听
     *
     * @param listener 监听
     */
    addOnPolylineClickListener(listener: AMap.OnPolylineClickListener): void;
    /**
     * 移除地图上polyline点击监听
     *
     * @param listener 监听
     */
    removeOnPolylineClickListener(listener: AMap.OnPolylineClickListener): void;
    /**
     * 设置地图底图文字标注的层级指数，默认为0，用来比较覆盖物（polyline、polygon、circle等）的zIndex。
     * 如果覆盖物的zIndex大于底图文字标注的zIndex，则覆盖物会在文字标注上层绘制，否则，覆盖物在文字标注下面绘制。
     *
     * @param x 为地图底图文字标注的层级指数，默认为0。
     */
    setMapTextZIndex(x: number): void;
    /**
     * 得到地图底图文字标注的层级指数。
     *
     * @return 地图底图文字标注的层级指数。
     */
    getMapTextZIndex(): number;
    /**
     * 获取当前屏幕内的所有marker
     *
     * @return marker结合
     */
    getMapScreenMarkers(): ArrayList<Marker>;
    /**
     * 通过指定的两个经纬度坐标（左下、右上）计算出合适的缩放级别。
     *
     * @param leftDown 左下角 (经纬度)
     * @param rightUp  右上角 (经纬度)
     * @return 缩放级别
     */
    getZoomToSpanLevel(leftDown: LatLng, rightUp: LatLng): number;
    /**
     * 通过指定的两个经纬度坐标（左下、右上）及屏幕边距计算出合适的缩放级别及中心点。
     *
     * @param paddingLeft   屏幕左内边距
     * @param paddingRight  屏幕右内边距
     * @param paddingTop    屏幕顶部内边距
     * @param paddingBottom 屏幕底部内边距
     * @param leftDown      左下角 (经纬度)
     * @param rightUp       右上角 (经纬度)
     * @return Pair对象, first:缩放级别,second:中心的(经纬度)
     */
    calculateZoomToSpanLevel(paddingLeft: number, paddingRight: number, paddingTop: number, paddingBottom: number, leftDown: LatLng, rightUp: LatLng): [
        number,
        LatLng
    ] | undefined;
    /**
     * 添加引擎路况放大图
     *
     * @param overlayOptions 属性
     * @return 覆盖物
     */
    c3(overlayOptions: c1 | null): b1 | null;
    /**
     * 获取view矩阵
     *
     * @return 矩阵
     */
    getViewMatrix(): Float64Array;
    /**
     * 获取projection矩阵
     *
     * @return 矩阵
     */
    getProjectionMatrix(): Float64Array;
    /**
     * 获取地图config 其中包含 绘制所需要的必要信息
     *
     * @return config
     */
    l57(): b53;
    /**
     * 获取引擎对象
     *
     * @return 引擎
     */
    j57(): s60;
    /**
     * 设置路况样式
     *
     * @param style
     */
    t58(data: Uint8Array | undefined, style: l39 | undefined): void;
    /**
     * 请求绘制
     */
    l3(): void;
    /**
     * 重新设置地图正常绘制帧率
     */
    n58(flag?: boolean): void;
    /**
     * 添加3DModelTileOverlay
     *
     * @param options 默认属性
     * @return 对象
     * @throws RemoteException
     */
    o59(options: f16): g16 | undefined;
    /**
     * TileOverlay图层，可以覆盖整个地图，添加第三方地图数据是可以使用
     *
     * @param tileOverlayOptions 属性
     * @return 对象
     * @throws RemoteException
     */
    addTileOverlay(tileOverlayOptions: TileOverlayOptions): TileOverlay | undefined;
    /**
     * HeatMap图层，可以覆盖整个地图，添加热力数据是可以使用
     *
     * @param options 属性
     * @return 对象
     * @throws RemoteException
     */
    addHeatMapLayer(options: HeatMapLayerOptions): HeatMapLayer | undefined;
    /**
     * 发起地图截屏请求。
     *
     * @param listener 地图截屏监听接口。
     * @param showLogo 是否带logo水印
     */
    getMapScreenShot(listener: AMap.OnMapScreenShotListener, showLogo: boolean): void;
    /**
     * 设置海外矢量地图样式,其中包括地图选用策略、地图样式（含语言）、抠边区域和重新绘制边界
     *
     * @param style 支持有AMap.CHINESE 表示中文，即"zh_cn", AMap.ENGLISH 表示英文，即"en" AMap.LOCAL 表示本地语言 及 "local" 及 LAZADA
     */
    setWorldVectorMapStyle(style: string): void;
    /**
     * 获取外部设置的海外矢量地图样式,其中包括地图选用策略、地图样式（含语言）、抠边区域和重新绘制边界，支持有AMap.CHINESE 表示中文，即"zh_cn", AMap.ENGLISH 表示英文，即"en" AMap.LOCAL 表示本地语言 及 "local" 及 LAZADA
     */
    getWorldVectorMapStyle(): string;
    /**
     * 实现海量点
     *
     *
     *
     *
     */
    addMultiPointOverlay(options: MultiPointOverlayOptions): MultiPointOverlay;
}
