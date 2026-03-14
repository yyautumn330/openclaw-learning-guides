// @keepTs
// @ts-nocheck
import geoLocationManager from '@ohos.geoLocationManager';
import { IAMap } from '../mapcore/interface/IAMap';
import { CameraPosition } from './model/CameraPosition';
import { CameraUpdate } from './CameraUpdate';
import { LatLng } from './model/LatLng';
import { Marker } from './model/Marker';
import { PolygonOptions } from './model/PolygonOptions';
import { Polygon } from './model/Polygon';
import { CircleOptions } from './model/CircleOptions';
import { Circle } from './model/Circle';
import { Polyline } from './model/Polyline';
import { PolylineOptions } from './model/PolylineOptions';
import { Projection } from './Projection';
import { UiSettings } from './UiSettings';
import { MarkerOptions } from './model/MarkerOptions';
import ArrayList from '@ohos.util.ArrayList';
import { MyLocationStyle } from './model/MyLocationStyle';
import { LocationSource } from './LocationSource';
import { LatLngBounds } from './model/LatLngBounds';
import { GL3DModelOptions } from './model/GL3DModelOptions';
import { GL3DModel } from './model/GL3DModel';
import { BasePointOverlay } from './model/BasePointOverlay';
import { Poi } from './model/Poi';
import { AMapAppRequestParamWrapper } from '../mapcore/AMapAppRequestParamWrapper';
import { CustomMapStyleOptions } from './model/CustomMapStyleOptions';
import { TextOptions } from './model/TextOptions';
import { Text } from './model/Text';
import { GroundOverlayOptions } from './model/GroundOverlayOptions';
import { GroundOverlay } from './model/GroundOverlay';
import { TileOverlayOptions } from './model/TileOverlayOptions';
import { TileOverlay } from './model/TileOverlay';
import { ArcOptions } from './model/ArcOptions';
import { Arc } from './model/Arc';
import { MultiPointOverlay } from './model/MultiPointOverlay';
import { MultiPointOverlayOptions } from './model/MultiPointOverlayOptions';
import { HeatMapLayerOptions } from './model/HeatMapLayerOptions';
import { IndoorBuildingInfo } from './model/IndoorBuildingInfo';
import { IndoorFloorSwitchAdapter } from './model/IndoorFloorSwitchAdapter';
import { b1 } from './model/CrossOverlay';
import { c1 } from './model/CrossOverlayOptions';
/**
 * 定义AMap 地图对象的操作方法与接口。
 *
 * @since 1.0.0
 */
export declare class AMap {
    private l2;
    private m2?;
    private n2?;
    static readonly o2: string;
    static readonly q2: string;
    constructor(k2: IAMap);
    /**
     * 按照传入的CameraUpdate参数改变地图状态。（直接改变状态，没有动画效果）<br>
     * 可以通过{@link CameraUpdateFactory#zoomIn()}等方法来生成对应的CameraUpdate对象。
     *
     * @param update 地图状态将要发生的变化。
     * @since 1.0.0
     */
    moveCamera(update: CameraUpdate): void;
    /**
     * 在地图上添加一个瓦片图层覆盖物（tileOverlay）对象。
     *
     * @param options 一个tileOverlayOptions 对象，它定义了tileOverlay的属性信息。
     * @return 返回被添加的tileOverlay对象。
     * @since V2.2.0
     */
    addTileOverlay(options: TileOverlayOptions): TileOverlay | undefined;
    /**
     * 在地图上添加一个热力图对象。
     *
     * @param options 一个HeatMapLayerOptions对象，它定义了heatMapLayer的属性信息。
     * @return 返回被添加的HeatMapLayer对象。
     * @since 2.2.5
     */
    addHeatMapLayer(options: HeatMapLayerOptions): import("./model/HeatMapLayer").HeatMapLayer;
    /**
     * 按照指定的动画时长及传入的CameraUpdate参数更新地图状态，，同时设置一个cancelableCallback来监听动画执行的结果。<br>
     * 可以通过{@link CameraUpdateFactory#zoomIn()}等方法来生成对应的CameraUpdate对象。
     *
     * @param update             地图状态将要发生的变化。
     * @param cancelableCallback 如果动画正常完成，则会回调onFinish()方法，被中断时回调onCancel()。
     * @param durationMs         动画的持续时间，单位毫秒。 默认动画耗时250毫秒
     * @since V2.0.0
     */
    animateCamera(update: CameraUpdate, i2?: CancelableCallback, j2?: number): void;
    /**
     * 在地图上添加一个折线对象（polyline）对象。
     *
     * @param options 一个polylineOptions对象，它定义polyline的属性信息。
     * @return 返回被添加的 polyline 对象。
     * @since 1.0.0
     */
    addPolyline(options: PolylineOptions): Polyline | undefined;
    /**
     * 在地图上添加一个多边形（polygon）对象。
     *
     * @param options 一个polygonOptions 对象，它定义了polygon的属性信息。
     * @return 返回被添加的polygon对象。
     * @since 1.0.0
     */
    addPolygon(options: PolygonOptions): Polygon | undefined;
    /**
     * 在地图上添加一个圆（circle）对象。
     *
     * @param options 一个circleOptions对象，它定义circle的属性信息。
     * @return 返回被添加的circle 对象。
     * @since 1.0.0
     */
    addCircle(options: CircleOptions): Circle | undefined;
    /**
     * 在地图上添加一个圆弧（arc）对象。
     *
     * @param options 一个arcOptions对象，它定义arc的属性信息。
     * @return 返回被添加的arc对象。
     * @since V2.0
     */
    addArc(options: ArcOptions): Arc | undefined;
    /**
     * 在地图上添一个图片标记（marker）对象。
     *
     * @param options 一个markerOptions 对象，它定义了marker 的属性信息。
     * @return 返回被添加的marker对象。
     * @since 1.0.0
     */
    addMarker(options: MarkerOptions): Marker | undefined;
    /**
     * 在地图上添加一个自定义图层（GroundOverlay）对象。
     *
     * @param options 一个 GroundOverlayOptions 对象，它定义了 GroundOverlay 的属性信息。
     * @return 返回被添加的GroundOverlay对象。
     * @since 1.0.0
     */
    addGroundOverlay(options: GroundOverlayOptions): GroundOverlay | undefined;
    /**
     * 在地图上添一组图片标记（marker）对象，并设置是否改变地图状态以至于所有的marker对象都在当前地图可视区域范围内显示。<br>
     *
     * @param options      多个markerOptions对象，它们分别定义了对应marker的属性信息。
     * @param moveToCenter 是否改变地图状态，默认为false。
     * @return 返回一组被添加的marker对象。
     * @since 1.0.0
     */
    addMarkers(options: ArrayList<MarkerOptions>, h2?: boolean): ArrayList<Marker>;
    /**
     * 在地图上添一个文字标记（text）对象。
     *
     * @param options 一个textOptions 对象，它定义了text 的属性信息。
     * @return 返回被添加的text对象。
     * @since V2.7.0
     */
    addText(textOptions: TextOptions): Text;
    /**
     * 获取当前地图可视区域范围所有marker对象。
     *
     * @return 当前地图可视区域范围的所有marker对象。
     * @since V2.0.0
     */
    getMapScreenMarkers(): ArrayList<Marker>;
    /**
     * 在地图上添一个3d模型。
     *
     * @param options GL3DModelOptions 对象，它定义了模型的属性信息。
     * @return 返回被添加的GL3DModel对象。
     * @since 2.0.0
     */
    addGL3DModel(options: GL3DModelOptions): GL3DModel | undefined;
    /**
     * 从地图上删除所有的覆盖物（marker，circle，polyline 等对象），但myLocationOverlay（内置定位覆盖物）除外。
     *
     * @param isKeepMyLocationOverlay 是否保留myLocationOverlay。
     * @since 1.0.0
     */
    clear(g2?: boolean): void;
    /**
     * 设置地图底图文字标注的层级指数，默认为0，用来比较覆盖物（polyline、polygon、circle等）的zIndex。
     * 如果覆盖物的zIndex大于底图文字标注的zIndex，则覆盖物会在文字标注上层绘制，否则，覆盖物在文字标注下面绘制。
     *
     * @param x 为地图底图文字标注的层级指数，默认为0。
     * @since v2.0.0
     */
    setMapTextZIndex(x: number): void;
    /**
     * 得到地图底图文字标注的层级指数。
     *
     * @return 地图底图文字标注的层级指数。
     * @since v2.0.0
     */
    getMapTextZIndex(): number;
    /**
     * 设置用户定位信息监听接口。
     *
     * @param listener 用户定位信息监听接口。
     * @since 1.0.0
     */
    setOnMyLocationChangeListener(listener: OnMyLocationChangeListener): void;
    /**
     * marker拖动事件监听接口
     *
     * @param listener marker拖动事件监听接口。
     * @since 1.0.0
     */
    setOnMarkerDragListener(listener: OnMarkerDragListener): void;
    /**
     * 设置marker的信息窗口点击事件监听接口。
     *
     * @param listener marker的信息窗口点击事件监听接口。
     * @since 1.0.0
     */
    setOnInfoWindowClickListener(listener: OnInfoWindowClickListener): void;
    /**
     * 设置marker点击事件监听接口。
     *
     * @param listener marker点击事件监听接口。
     * @since 1.0.0
     */
    setOnMarkerClickListener(listener: OnMarkerClickListener): void;
    /**
     * 设置polyline点击事件监听接口。
     *
     * @param listener polyline点击事件监听接口。
     * @since 1.0.0
     */
    setOnPolylineClickListener(listener: OnPolylineClickListener): void;
    /**
     * 设置地图状态的监听接口。
     *
     * @param listener 地图状态的监听接口。
     * @since 1.0.0
     */
    setOnCameraChangeListener(listener: OnCameraChangeListener): void;
    /**
     * 添加地图状态的监听接口。
     * @param listener 地图状态的监听接口。
     * @exclude doc中不显示
     */
    addOnCameraChangeListener(listener: OnCameraChangeListener): void;
    /**
     * 设置地图点击事件监听接口。
     *
     * @param listener 地图单击事件监听接口。
     * @since 1.0.0
     */
    setOnMapClickListener(listener: OnMapClickListener): void;
    /**
     * 设置地图长按事件监听接口。
     *
     * @param listener 地图长按事件监听接口。
     * @since 1.0.0
     */
    setOnMapLongClickListener(listener: OnMapLongClickListener): void;
    /**
     * 设置地图触摸事件监听接口。
     *
     * @param listener 地图触摸事件监听接口。
     * @since 1.0.0
     */
    setOnMapTouchListener(listener: OnMapTouchListener): void;
    /**
     * 添加地图触摸事件监听接口。
     *
     * @param listener 地图触摸事件监听接口。
     * @exclude javadoc中不显示
     */
    addOnMapTouchListener(listener: OnMapTouchListener): void;
    /**
     * 设置地图加载完成监听接口
     *
     * @param listener 地图加载完成监听接口。
     * @since 2.0.0
     */
    setOnMapLoadedListener(listener: OnMapReadyListener): void;
    /**
     * 添加地图加载完成监听接口
     *
     * @param listener 添加加载完成监听接口。   相比于OnMapReadyListener延迟启动，防止卡在第一帧白屏
     * @since 2.0.0
     */
    addOnMapReadyDelayListener(listener: OnMapReadyDelayListener): void;
    /**
     * 设置手势监听接口
     *
     * @param listener 设置手势监听接口。
     * @since 2.0.0
     */
    setAMapGestureListener(listener: AMapGestureListener): void;
    /**
     * 设置marker的信息窗口定制接口。
     *
     * @param adapter marker的信息窗口定制接口。
     * @since 2.0.0
     */
    setInfoWindowAdapter(adapter: CustomBuilder | undefined): void;
    /**
     * 设置地图模式。
     *
     * @param type 地图模式： MAP_TYPE_NORMAL：普通地图，值为1；<br>
     *             MAP_TYPE_SATELLITE：卫星地图，值为2；<br>
     *             MAP_TYPE_NIGHT 夜景图模式，值为3；<br>
     *             MAP_TYPE_NAVI 导航模式，值为4；<br>
     *             MAP_TYPE_BUS 公交模式，值为5；<br>
     *             MAP_TYPE_NAVI_NIGHT 导航夜间模式，值为6；
     * @since 1.0.0
     */
    setMapType(type: MapType): void;
    /**
     * 获取地图当前的模式。可以参考{@link #MAP_TYPE_NORMAL}、{@link #MAP_TYPE_SATELLITE} 等。
     *
     * @return 地图当前的模式。
     * @since 1.0.0
     */
    getMapType(): MapType;
    /**
     * 获取定位图层（myLocationOverlay）的样式。
     *
     * @return myLocationStyle 定位图层（myLocationOverlay）样式。
     * @since 1.0.0
     */
    getMyLocationStyle(): MyLocationStyle | undefined;
    /**
     * 获取底层地图控制对象，仅供导航使用
     * 需要在onMapLoaded之后调用
     *
     * @exclude javadoc中不显示
     * @since V2.0.0
     */
    getNativeMapController(): bigint;
    /**
     * 获取底层地图引擎ID，仅供导航使用
     * 需要在onMapLoaded之后调用
     *
     * @exclude javadoc中不显示
     * @since V2.0.0
     */
    getNativeMapEngineID(): number;
    /**
     * 返回当前定位源（locationSource）提供的定位信息。如果未设置定位源（locationSource） 则返回null。
     *
     * @return 当前定位源（locationSource）提供的定位信息。
     * @since 1.0.0
     */
    getMyLocation(): geoLocationManager.Location | undefined;
    /**
     * 获取地图的当前状态。
     *
     * @return 一个cameraPosition对象，表示地图的当前状态。
     * @since 1.0.0
     */
    getCameraPosition(): CameraPosition | undefined;
    /**
     * 设置定位源（locationSource）。
     *
     * @param locationSource 定位源（locationSource）。
     * @since 1.0.0
     */
    setLocationSource(f2: LocationSource): void;
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
     * @param enabled 是否打开定位图层。
     * @since 1.0.0
     */
    setMyLocationEnabled(enabled: boolean): void;
    /**
     * 设置定位图层（myLocationOverlay）的样式。
     *
     * @param style myLocationStyle 定位图层（myLocationOverlay）样式。
     * @since 1.0.0
     */
    setMyLocationStyle(style: MyLocationStyle): void;
    /**
     * 设置地图最大缩放级别 缩放级别范围为[3, 20],超出范围将按最大级别计算 。
     * 注：只有在有室内地图显示的情况下最大级别为20，否则最大级别为19。
     *
     * @param zoomLevel 最大缩放等级
     * @since 1.0.0
     */
    setMaxZoomLevel(e2: number): void;
    /**
     * 设置最小缩放级别 缩放级别范围为[3, 20],超出范围将按最小级别计算
     *
     * @param zoomLevel 最小缩放等级
     * @since 1.0.0
     */
    setMinZoomLevel(d2: number): void;
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
    setMapStatusLimits(c2: LatLngBounds): void;
    /**
     * @exclude javadoc中不显示 导航使用
     *          <br/>Not shown in javadoc, used for navigation
     */
    b3(options: c1): b1 | null;
    /**
     * 设置是否打开交通路况图层。
     *
     * @param enabled 是否打开交通路况图层。
     * @since 1.0.0
     */
    setTrafficEnabled(enabled: boolean): void;
    /**
     * 获取是否打开交通路况图层。
     *
     * @return 是否打开交通路况图层。
     * @since V2.0.0
     */
    isTrafficEnabled(): boolean;
    /**
     * 设置是否显示底图文字标注，默认显示。
     *
     * @param enabled true： 表示显示，为默认值； false： 不显示
     * @since 1.0.0
     */
    showMapText(enabled: boolean): void;
    /**
     * 设置是否显示3D建筑物，默认显示。<br>
     * 注：<br>
     * 1. 开启显示3D建筑物后，地图需要被放大至Zoomlevel 17级以上且地图仰角>0（在地图上双指下滑可以调为仰视视角）时，才能可以看到3D建筑物的效果。<br>
     * 2. 夜间模式的地图无3D建筑物效果。<br>
     *
     * @param enabled true：显示3D建筑物；false：不显示；
     * @since 1.0.0
     */
    showBuildings(enabled: boolean): void;
    /**
     * 设置导航模式是否显示label，默认不显示。
     *
     * @param enabled true： 表示显示，为默认值； false： 不显示
     * @param flushInterval 刷新标注的间隔帧数阈值。
     * @param flushMode 1时，实现强制刷新效果
     * @exclude javadoc中不显示
     * @since V2.0.0
     */
    setNaviLabelEnable(enabled: boolean, a2: number, b2: number): void;
    /**
     * 设置地图在初始化及每一帧绘制时的回调接口，该接口在OpenGL线程中调用。
     *
     * @param render 地图在初始化及每一帧绘制时的回调接口。
     * @since V2.0.0
     */
    setCustomRenderer(render: CustomRenderer): void;
    /**
     * 设置底图自定义样式对应配置文件路径。
     * 可以支持分级样式配置，如控制不同级别显示不同的颜色
     *
     * 自6.6.0开始使用新版样式，旧版样式无法在新版接口{@link #setCustomMapStyle(CustomMapStyleOptions)}中使用，请到官网(lbs.amap.com)更新新版样式文件
     *
     * @param options 底图自定义样式对应配置,包含样式文件、纹理路径等。
     * @since V2.2.2
     */
    setCustomMapStyle(options: CustomMapStyleOptions, listener?: OnCustomMapStyleFailListener): void;
    /**
     * 设置屏幕上的某个像素点为地图中心点。
     * <p>使用该方法设置后，地图将以所设置的屏幕坐标点为中心进行旋转、倾斜。同时， {@link #moveCamera(CameraUpdate) } 方法也将会以此坐标点为中心进行设置。
     *
     * @param x 屏幕像素点x轴坐标。
     * @param y 屏幕像素点y轴坐标。
     * @since v2.2.0
     */
    setPointToCenter(x: number, y: number): void;
    /**
     * 获取地图ui控制器，可以控制内置ui（缩放按钮、指北针等）是否显示及部分手势（滑动、双指缩放等）是否可用。
     *
     * @return 地图ui控制器。
     * @since 1.0.0
     */
    getUiSettings(): UiSettings | undefined;
    /**
     * 获取地图投影坐标转换器, 当地图初始化完成之前返回 null。<br>
     *
     * @return 地图投影坐标转换器。
     * @since 1.0.0
     */
    getProjection(): Projection | undefined;
    /**
     * 获取地图审图号（普通地图）<br>
     * <font color="red">任何使用高德地图API调用地图服务的应用必须在其应用中对外透出审图号</font><br>
     * 如高德地图在"关于"中体现
     *
     * @return 普通矢量地图审图号
     * @since 1.0.0
     */
    getMapContentApprovalNumber(): string;
    /**
     * 获取地图审图号（卫星地图）<br>
     * <font color="red">任何使用高德地图API调用地图服务的应用必须在其应用中对外透出审图号</font><br>
     * 如高德地图在"关于"中体现
     *
     * @return 卫星地图审图号
     * @since 1.0.0
     */
    getSatelliteImageApprovalNumber(): string;
    /**
     * 获取地图审图号 （地形图）<br>
     * <font color="red">任何使用高德地图API调用地图服务的应用必须在其应用中对外透出审图号</font><br>
     * 如高德地图在"关于"中体现
     *
     * @return 地形图审图号
     * @since 9.1.0
     */
    getTerrainApprovalNumber(): string;
    /**
     * 获取地图宽度
     *
     * @returns
     * @since 1.0.0
     */
    /**
     * 获取地图高度
     *
     * @returns
     * @since 1.0.0
     */
    /**
     * 清楚瓦片缓存
     * @since 1.0.0
     */
    /**
     *  低帧率运行
     *
     * @param isLow
     * @since 1.0.0
     */
    /**
     * 移除覆盖物
     *
     * @param id
     * @since 1.0.0
     */
    removeOverlay(id: string): void;
    addAMapAppResourceListener(listener: AMapAppResourceRequestListener): void;
    removeAMapAppResourceListener(listener: AMapAppResourceRequestListener): void;
    /**
     * 设置地图每秒渲染的帧数
     *
     * @param fps 帧率
     * @exclude javadoc中不显示
     * @since 2.0.0
     */
    setRenderFps(fps: number): void;
    /**
     * 室内地图楼层控制接口，通过此接口可以控制某个室内地图显示的楼层。
     *
     * @param indoorBuildingInfo indoorBuildingInfo 对象，它定义了室内地图属性,详情{@link IndoorBuildingInfo}。
     */
    setIndoorBuildingInfo(z1: IndoorBuildingInfo): void;
    /**
         * 获取当前缩放级别下，地图上1像素点对应的长度，单位米。
         *
         * @return 当前缩放级别下，地图上1像素点对应的长度，单位米。
         * @since V2.0.0
         */
    getScalePerPixel(): number;
    /**
     * 添加海量点图层
     * @param overlay 海量点图层对象
     * @since 5.1.0
     */
    addMultiPointOverlay(options: MultiPointOverlayOptions): MultiPointOverlay | undefined;
    /**
     * 触发地图立即刷新。
     *
     * @since V2.0
     */
    runOnDrawFrame(): void;
    /**
     * 请求绘制
     */
    l3(): void;
    /**
     * 添加infowindow的监听
     * @param adapter
     * @since V2.0.0
     */
    addInfoWindowListener(adapter: InfoWindowListener): void;
    /**
     * 移除infowindow的监听
     * @param adapter
     * @since V2.0.0
     */
    removeInfoWindowListener(adapter: InfoWindowListener): void;
    /**
     * 添加地图上Poi点击监听
     *
     * @param listener 监听
     * @since 2.0.0
     */
    addOnPOIClickListener(listener: OnMapPOIClickListener): void;
    /**
     * 删除地图上Poi点击监听
     *
     * @param listener 监听
     * @since 2.0.0
     */
    removeOnPOIClickListener(listener: OnMapPOIClickListener): void;
    /**
     * 设置地图POI是否允许点击。
     * 默认情况下单击地铁站，地铁路线会高亮，如果关闭了poi单击，则地铁站不会被单击，地铁路线也不会高亮
     *
     * @param touchPoiEnable true： 表示允许点击，为默认值； false： 不允许点击
     * @since 2.0.0
     */
    setTouchPoiEnable(w1: boolean): void;
    /**
     * 获取地图POI是否允许点击。
     *
     * @return true： 表示允许点击，为默认值； false： 不允许点击
     * @since 2.0.0
     */
    isTouchPoiEnable(): boolean;
    /**
     * 添加polyline点击事件监听接口。
     *
     * @param listener polyline点击事件监听接口。
     * @exclude javadoc中不显示
     * @since 2.2.6
     */
    addOnPolylineClickListener(listener: OnPolylineClickListener): void;
    /**
     * 删除polyline点击事件监听接口。
     *
     * @param listener polyline点击事件监听接口。
     * @exclude javadoc中不显示
     * @since 2.2.6
     */
    removeOnPolylineClickListener(listener: OnPolylineClickListener): void;
    getZoomToSpanLevel(u1: LatLng, v1: LatLng): number;
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
     * @since 2.0.0
     */
    calculateZoomToSpanLevel(n1: number, o1: number, p1: number, q1: number, s1: LatLng, t1: LatLng): [
        number,
        LatLng
    ] | undefined;
    /**
     * 获取地图当前视图矩阵
     *
     * @exclude javadoc中不显示 暂时不显示，游戏使用
     */
    getViewMatrix(): Float64Array;
    /**
     * 获取地图当前投影矩阵
     *
     * @exclude javadoc中不显示 暂时不显示，游戏使用
     */
    getProjectionMatrix(): Float64Array;
    /**
     * 发起地图截屏请求。
     *
     * @param listener 地图截屏监听接口。
     * @since V2.2.3
     */
    getMapScreenShot(listener: OnMapScreenShotListener): void;
    /**
     * 设置地图底图语言，目前支持中文底图和英文底图
     *
     * @param language AMap.CHINESE 表示中文，即"zh_cn", AMap.ENGLISH 表示英文，即"en"
     */
    setMapLanguage(language: string): void;
    /**
     * 设置是否显示室内地图，默认不显示。<br>
     * <p>
     * 注：如果打开了室内地图，会显示3D建筑物，即如果之前有设置不显示3D建筑物，3D建筑物也会被显示出来。
     *
     * @param enabled true：显示室内地图；false：不显示；
     */
    showIndoorMap(enabled: boolean): void;
    /**
     * 设置室内地图状态监听接口
     *
     * @param listener 室内地图状态监听接口。
     * @since V2.2.4
     */
    setIndoorFloorSwitchAdapter(listener: IndoorFloorSwitchAdapter): void;
}
/**
 * 地图截屏监听接口.
 *
 * @since V2.2.3
 */
export interface OnMapScreenShotListener {
    /**
     * 地图截屏回调此方法,并返回截屏一瞬间地图是否渲染完成。<br>
     *
     * @param bitmap 截屏返回的bitmap对象。
     * @param status 地图渲染状态， 1：地图渲染完成，0：未渲染完成
     * @since V2.2.3
     */
    onMapScreenShot: (bitmap: PixelMap | undefined, status: number) => void;
}
/**
 * InfoWindow展示
 * @since V2.0.0
 */
export type d1 = (marker: BasePointOverlay) => void;
/**
 *
 */
export type e1 = (marker: BasePointOverlay) => void;
/**
 * InfoWindow的监听接口
 * @since V2.0.0
 */
export declare class InfoWindowListener {
    private n3;
    private q3;
    constructor(l1: d1, m1: e1);
    get onInfoWindowShown(): d1;
    get onInfoWindowHidden(): e1;
}
export type AMapAppResourceRequestListener = (param: AMapAppRequestParamWrapper) => void;
/**
 * 定义了一个地图在初始化及每一帧绘制时的回调接口。
 *
 * @since V2.0.0
 */
export type onCustomRendererDrawFrame = () => void;
export declare class CustomRenderer {
    private r3;
    constructor(k1: onCustomRendererDrawFrame);
    get onCustomRendererDrawFrame(): onCustomRendererDrawFrame;
}
/**
 * 地图状态发生变化的监听接口。<br>
 * 当调用{@link #animateCamera(CameraUpdate)}、{@link #moveCamera(CameraUpdate)}及手势操作地图时会触发该回调。
 *
 * @since 1.0.0
 */
export declare class OnCameraChangeListener {
    private s3;
    private t3;
    constructor(i1: onCameraChange, j1: onCameraChangeFinish);
    get onCameraChange(): onCameraChange;
    get onCameraChangeFinish(): onCameraChangeFinish;
}
export declare class CancelableCallback {
    private u3;
    private v3;
    constructor(cancel: OnCancel, finish: OnFinish);
    get onCancel(): OnCancel;
    get onFinish(): OnFinish;
}
/**
 * 当CameraUpdate任务完成时回调此方法。
 *
 * @since V2.0.0
 */
export type OnFinish = () => void;
/**
 * 当CameraUpdate任务被中断时回调此方法。
 *
 * @since V2.0.
 */
export type OnCancel = () => void;
/**
 * 地图状态发生变化的监听接口。<br>
 * 当调用{@link #animateCamera(CameraUpdate)}、{@link #moveCamera(CameraUpdate)}及手势操作地图时会触发该回调。
 *
 * @since 1.0.0
 */
/**
 * 在地图状态改变过程中回调此方法。
 *
 * @param position 一个cameraPosition对象，表示地图的当前状态。
 * @since 1.0.0
 */
export type onCameraChange = (position: CameraPosition) => void;
/**
 * 在地图状态改变完成时回调此方法。
 *
 * @param position 一个cameraPosition对象，表示地图的当前状态。
 * @since 1.0.0
 */
export type onCameraChangeFinish = (position: CameraPosition) => void;
/**
 * 地图点击事件监听接口。
 *
 * @since 1.0.0
 */
/**
 * 当用户点击地图时回调此方法，如果点击在某个覆盖物（如marker、polyline）上，且处理了该点击事件，则不会回调此方法。<br>
 *
 * @param point 用户所点击的地理坐标
 * @since 1.0.0
 */
export type OnMapClickListener = (point: LatLng) => void;
/**
 * 地图底图poi点击事件监听接口。
 *
 * @since V2.0.0
 */
export type OnMapPOIClickListener = (poi: Poi) => void;
/**
 * 地图长按事件监听接口。
 *
 * @since 1.0.0
 */
/**
 * 当用户长按地图时回调此方法，如果长按时触发某一个marker对象的拖动事件，则不会回调此方法。<br>
 *
 * @param point 用户长按的地理坐标。
 * @since 1.0.0
 */
export type OnMapLongClickListener = (point: LatLng) => void;
/**
 * 地图触摸事件监听接口。
 *
 * @since 1.0.0
 */
/**
 * 当用户触摸地图时回调此方法
 *
 * @param event 触摸事件
 * @since 1.0.0
 */
export type OnMapTouchListener = (event: TouchEvent) => void;
/**
 * 地图加载完成监听接口
 *
 * @since 1.0.0
 */
export type OnMapReadyListener = (map: AMap) => void;
/**
 * 地图加载完成延迟启动监听接口  相比于OnMapReadyListener延迟启动，防止卡在第一帧白屏
 *
 * @since 1.0.0
 */
export type OnMapReadyDelayListener = (map: AMap) => void;
/**
 * 设置手势监听接口
 *
 * @since 1.0.0
 */
export type AMapGestureListener = (event: GestureEvent) => void;
/**
 * marker点击事件监听接口。
 *
 * @since 1.0.0
 * @param marker 被点击的marker对象。
 * @return true 返回true表示该点击事件已被处理，不再往下传递（如底图点击不会被触发），返回false则继续往下传递。
 */
export type OnMarkerClickListener = (marker: Marker) => boolean;
/**
 * marker拖动事件监听接口。
 *
 * @since 1.0.0
 */
export declare class OnMarkerDragListener {
    private w3;
    private x3;
    private y3;
    constructor(f1: onMarkerDragStart, g1: onMarkerDrag, h1: onMarkerDragEnd);
    get onMarkerDragStart(): onMarkerDragStart;
    get onMarkerDrag(): onMarkerDrag;
    get onMarkerDragEnd(): onMarkerDragEnd;
}
/**
 * marker拖动事件监听接口。
 * 当marker开始被拖动时回调此方法
 * @param marker 被拖动的marker对象
 * @since 1.0.0
 */
export type onMarkerDragStart = (marker: Marker) => void;
/**
 * 在marker拖动过程当中回调此方法。
 *
 * @param marker 被拖动的marker对象。
 * @since 1.0.0
 */
export type onMarkerDrag = (marker: Marker) => void;
/**
 * 在marker拖动停止时回调此方法。
 *
 * @param marker 被拖动的marker对象。
 * @since 1.0.0
 */
export type onMarkerDragEnd = (marker: Marker) => void;
/**
 * marker的信息窗口点击事件监听接口。
 *
 * @since 1.0.0
 */
/**
 * 当marker的信息窗口被点击时，回调此方法。
 *
 * @param marker 与该信息窗口关联的marker对象。
 * @since 1.0.0
 */
export type OnInfoWindowClickListener = (marker: Marker) => void;
/**
 * polyline点击事件监听接口。当一个polyline对象被点击时调用此方法
 * @param polyline 被点击的polyline 对象。
 * @since 1.0.0
 */
export type OnPolylineClickListener = (polyline: Polyline) => void;
/**
 * 用户定位信息监听接口。当用户定位信息改变时回调此方法。
 * @param location 用户当前的定位信息。
 * @since 1.0.0
 */
export type OnMyLocationChangeListener = (location: geoLocationManager.Location) => void;
/**
 * 自定义地图加载失败回调
 */
export type OnCustomMapStyleFailListener = (errorCode: number, errorMsg: string) => void;
/**
 * 地图类型
 *
 * @since 1.0.0
 */
export declare enum MapType {
    /**
     * 普通地图模式常量，值为1。
     *
     * @since 1.0.0
     */
    MAP_TYPE_NORMAL = 1,
    /**
     * 卫星图模式常量，值为2。
     *
     * @since 1.0.0
     */
    MAP_TYPE_SATELLITE = 2,
    /**
     * 夜景图模式常量，值为3。
     *
     * @since 1.0.0
     */
    MAP_TYPE_NIGHT = 3,
    /**
     * 导航模式常量，值为4。
     *
     * @since V2.2.0
     */
    MAP_TYPE_NAVI = 4,
    /**
     * 公交模式常量，值为5。
     *
     * @since V2.0.0
     */
    MAP_TYPE_BUS = 5,
    /**
     * 导航夜间模式常量，值为6。
     *
     * @since V2.0.0
     */
    MAP_TYPE_NAVI_NIGHT = 6
}
