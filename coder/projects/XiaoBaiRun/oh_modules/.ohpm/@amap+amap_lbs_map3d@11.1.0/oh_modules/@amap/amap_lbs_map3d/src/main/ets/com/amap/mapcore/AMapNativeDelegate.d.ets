// @keepTs
// @ts-nocheck
import * as AMap from '../api/AMap';
import { OnCustomMapStyleFailListener } from '../api/AMap';
import { CameraUpdate } from '../api/CameraUpdate';
import { CircleOptions } from '../api/model/CircleOptions';
import { CustomMapStyleOptions } from '../api/model/CustomMapStyleOptions';
import { LatLngBounds } from '../api/model/LatLngBounds';
import { MarkerOptions } from '../api/model/MarkerOptions';
import { MyLocationStyle } from '../api/model/MyLocationStyle';
import { PolygonOptions } from '../api/model/PolygonOptions';
import { PolylineOptions } from '../api/model/PolylineOptions';
import { IAMap } from './interface/IAMap';
import ArrayList from '@ohos.util.ArrayList';
import { d12 } from './interface/bridge/IMapViewBridge';
import { s60 } from './interface/IGLMapEngine';
import geoLocationManager from "@ohos.geoLocationManager";
import { UiSettings } from '../api/UiSettings';
import { Projection } from '../api/Projection';
import { CameraPosition } from '../api/model/CameraPosition';
import { Marker } from '../api/model/Marker';
import { Polyline } from '../api/model/Polyline';
import { Polygon } from '../api/model/Polygon';
import { Circle } from '../api/model/Circle';
import { n60 } from './widget/IInfoWindow';
import * as d16 from './interface/IGLOverlayLayer';
import { Rect } from '../api/model/Rect';
import { b53 } from './MapConfig';
import { LatLng } from '../api/model/LatLng';
import { p66 } from './interface/IAMapNativeDelegate';
import { Point } from '../api/model/Point';
import { x59 } from './interface/IGLMapState';
import { n66 } from './interface/IAMapEngineCallback';
import { p72 } from './message/AbstractGestureMapMessage';
import { GL3DModelOptions } from '../api/model/GL3DModelOptions';
import { GL3DModel } from '../api/model/GL3DModel';
import { v72 } from './style/StyleItem';
import { o66 } from './MapPoi';
import { AMapAppRequestParamWrapper } from './AMapAppRequestParamWrapper';
import { BaseOverlay } from '../api/model/BaseOverlay';
import { LocationSource } from '../api/LocationSource';
import { g53 } from './AMapCustomStyleManager';
import { l39 } from '../api/model/MyTrafficStyle';
import { y72 } from './style/StyleParserResult';
import { a73 } from './style/CustomStyleTextureTask';
import { f16 } from '../api/model/amap3dmodeltile/AMap3DModelTileOverlayOptions';
import { g16 } from '../api/model/amap3dmodeltile/AMap3DModelTileOverlay';
import { TextOptions } from '../api/model/TextOptions';
import { Text } from '../api/model/Text';
import { GroundOverlayOptions } from '../api/model/GroundOverlayOptions';
import { GroundOverlay } from '../api/model/GroundOverlay';
import { TileOverlay } from '../api/model/TileOverlay';
import { TileOverlayOptions } from '../api/model/TileOverlayOptions';
import { BaseOptions } from '../../../../../../Index';
import { ArcOptions } from '../api/model/ArcOptions';
import { Arc } from '../api/model/Arc';
import { MultiPointOverlay } from '../api/model/MultiPointOverlay';
import { MultiPointOverlayOptions } from '../api/model/MultiPointOverlayOptions';
import { HeatMapLayerOptions } from '../api/model/HeatMapLayerOptions';
import { HeatMapLayer } from '../api/model/HeatMapLayer';
import { IndoorBuildingInfo } from '../api/model/IndoorBuildingInfo';
import { IndoorBuilding } from './indoor/IndoorBuilding';
import { IndoorFloorSwitchAdapter } from '../api/model/IndoorFloorSwitchAdapter';
import { h73 } from './GLTextureProperty';
import { BitmapDescriptor } from '../api/model/BitmapDescriptor';
import { i73 } from './GLOverlay';
import { j73 } from './BaseMapOverlay';
import { c1 } from '../api/model/CrossOverlayOptions';
import { b1 } from '../api/model/CrossOverlay';
export declare class k15 implements IAMap, p66, a73, g53 {
    private context;
    private mapViewBridge;
    private l85;
    private m85;
    private glOverlayLayer;
    private n37;
    private resourceManager;
    private e63;
    private m2;
    private n85;
    private n2;
    private o85;
    private g63;
    private i63;
    private j63;
    private k63;
    private p85;
    private q85;
    private r85;
    private s85;
    private t85;
    private u85;
    private v85;
    private w85;
    private x85;
    private y85;
    private n63;
    private z85;
    private a86;
    private b86;
    private x62;
    private c86;
    private d86;
    private e86;
    private f86;
    private g86;
    private h86;
    private i86;
    private j86?;
    private k86;
    private l86;
    private m86;
    private n86;
    private l63;
    private o86?;
    private m63;
    private p86?;
    private q86;
    private r86?;
    /**
     * 辅助判断CameraChangeFinish回调
     */
    private b63;
    private s86;
    /**矩阵信息*/
    private viewMatrix;
    private projectionMatrix;
    private t86;
    private u86;
    private v86;
    private w86;
    private x86?;
    private g59?;
    /**
     * 或者在线自定义样式
     */
    private j56?;
    /**
     * 获取在线自定义纹理
     */
    private y86?;
    private z86;
    private a87;
    private b87;
    private c87?;
    private static readonly d87;
    private e87;
    private f87;
    private g87;
    private h87;
    private i87;
    j87: IndoorFloorSwitchAdapter;
    mIndoorBuildingInfo: IndoorBuilding;
    private k87;
    /**
     * 会在设置中英文地图时修改状态
     * 设置为true 目的是为了默认不调用
     */
    private l87;
    private m87;
    private n87;
    private o87;
    private p87;
    private q87;
    private r87;
    private o63;
    private y87;
    private z87;
    private y88;
    private f89;
    constructor(m342: d12);
    setWorldVectorMapStyle(n84: string): void;
    getWorldVectorMapStyle(): string;
    /**
     * 需要在创建引擎之前调用
     * @param loadWorldVectorMap 是否使用海外地图，如果false则不会加载海外图
     */
    private p89;
    private q89;
    private o89;
    s57(data: Uint8Array): void;
    r89(savePath: string, j84: y72 | undefined): void;
    s89(i84: string): void;
    c3(g84: c1 | null): b1 | null;
    getViewMatrix(): Float64Array;
    getProjectionMatrix(): Float64Array;
    l3(): void;
    x89(r83: x59): void;
    getZoomToSpanLevel(n83: LatLng, o83: LatLng): number;
    calculateZoomToSpanLevel(e83: number, f83: number, g83: number, h83: number, i83: LatLng, j83: LatLng): [
        number,
        LatLng
    ] | undefined;
    setMapTextZIndex(x: number): void;
    getMapTextZIndex(): number;
    j90(): n60;
    setInfoWindowAdapter(adapter: CustomBuilder | undefined): void;
    getMapScreenShot(listener: AMap.OnMapScreenShotListener, d83: boolean): void;
    addOnPOIClickListener(listener: AMap.OnMapPOIClickListener): void;
    removeOnPOIClickListener(listener: AMap.OnMapPOIClickListener): void;
    addOnPolylineClickListener(listener: AMap.OnPolylineClickListener): void;
    removeOnPolylineClickListener(listener: AMap.OnPolylineClickListener): void;
    onMapPOIClick(poi: o66): void;
    onMapBlandClick(x: number, y: number): void;
    private v88;
    private u88;
    v90(): x59 | undefined;
    addInfoWindowListener(adapter: AMap.InfoWindowListener): void;
    removeInfoWindowListener(adapter: AMap.InfoWindowListener): void;
    setRenderFps(fps: number): void;
    setIndoorBuildingInfo(n82: IndoorBuildingInfo): void;
    addAMapAppResourceListener(listener: AMap.AMapAppResourceRequestListener): void;
    removeAMapAppResourceListener(listener: AMap.AMapAppResourceRequestListener): void;
    g3(x: number, y: number): void;
    setCustomRenderer(render: AMap.CustomRenderer): void;
    isTrafficEnabled(): boolean;
    setNaviLabelEnable(enabled: boolean, l82: number, m82: number): void;
    setTouchPoiEnable(k82: boolean): void;
    isTouchPoiEnable(): boolean;
    d91(location: geoLocationManager.Location): void;
    getNativeMapController(): bigint;
    a3(): number;
    private count;
    private e91;
    private j91;
    private m91;
    private q91;
    s69(): void;
    s91(): n66;
    t91(id: string): boolean;
    u91(): void;
    v91(zoom: number): number;
    w91(n81: number, o81: number, point: Point): void;
    x91(x: number, y: number, point: Point): void;
    y91(x: number, y: number, point: Point): void;
    z91(): number;
    showInfoWindow(marker: BaseOverlay): void;
    hideInfoWindow(): void;
    a92(l81: number, m81: number, point: Point): void;
    v37(i81: number, j81: number, result: Point): void;
    private c92;
    d92(a81: number, b81: number, result: Point): void;
    j92(x80: number, y80: number, z80: Point): void;
    private e92;
    redrawInfoWindow(): void;
    k92(u80: boolean): void;
    l92(t80: boolean): void;
    m92(s80: boolean): void;
    n92(r80: boolean): void;
    o92(q80: boolean): void;
    setZoomPosition(position: number): void;
    p92(): Rect;
    getMapBounds(center: LatLng, zoom: number, bearing: number, tilt: number): LatLngBounds;
    onResume(): void;
    onPause(): void;
    r92(x: number, y: number, point: Point): void;
    s92(x: number, y: number, point: Point): void;
    k49(j80: number): number;
    u92(f80: boolean): CameraPosition;
    /**
     * 当前中心点的经纬度坐标
     *
     * @return
     */
    private v92;
    w92(): boolean;
    x92(): Point;
    y92(): number;
    z92(): boolean;
    getLogoPosition(): number;
    setLogoPosition(position: number): void;
    setLogoBottomMargin(c80: number): void;
    setLogoLeftMargin(pixels: number): void;
    getLogoMarginRate(type: number): number;
    setLogoMarginRate(type: number, rate: number): void;
    a93(): number;
    b93(a80: number, b80: boolean): void;
    getContext(): Context;
    j57(): s60;
    t58(data: Uint8Array | undefined, style: l39 | undefined): void;
    g93(y79: number, z79: number): void;
    h93(x79: number): boolean;
    q88(w79: number): number;
    i93(v79: number, point: Point): void;
    j93(u79: number): number;
    k93(): boolean;
    o88(): number;
    /**
     * 以屏幕某个点放大地图
     */
    zoomIn(s79: number, x: number, y: number): boolean;
    zoomOut(r79: number): void;
    n93(): Float64Array;
    e8(type: string): string;
    p93(q79: boolean): void;
    q93(w: number, h: number): void;
    r93(p79: boolean): void;
    s93(path: string, enable: boolean, type: number): void;
    t93(): void;
    y37(): void;
    n58(flag?: boolean): void;
    b68(j79: number, inputArray: Uint8Array): void;
    o59(h79: f16): g16 | undefined;
    addTileOverlay(f79: TileOverlayOptions): TileOverlay | undefined;
    addHeatMapLayer(options: HeatMapLayerOptions): HeatMapLayer;
    z93(enable: boolean, c79: boolean): void;
    d94(): void;
    e94(id: string): boolean;
    f94(zoom: number): number;
    o67(): d16.d16;
    g94(enable: boolean): void;
    l57(): b53;
    h94(): boolean;
    i94(a79: j73<i73, object>): void;
    j94(y78: number, z78: h73): void;
    o94(x78: number, bitmap: BitmapDescriptor): number;
    onAMapAppResourceRequest(param: AMapAppRequestParamWrapper): void;
    p94(u78: boolean): void;
    q94(t78: boolean): void;
    r94(): boolean;
    init(): void;
    private s87;
    /**
     * 尝试启动主云控鉴权，并根据策略清理缓存
     */
    private v94;
    /**
     * 检查是否超过24小时，是则清理瓦片缓存
     */
    private z94;
    private getUserAgent;
    private t87;
    private b95;
    private r95;
    private s95;
    moveCamera(w77: CameraUpdate): void;
    /**
     * 初始化一下CameraUpdate的属性 是否使用anchor以及map宽高
     *
     * @param cameraUpdateDelegate
     */
    private z95;
    animateCamera(u77: CameraUpdate): void;
    v2(s77: CameraUpdate, t77: number): void;
    u2(q77: CameraUpdate, r77: AMap.CancelableCallback): void;
    t2(n77: CameraUpdate, o77: number, p77?: AMap.CancelableCallback): void;
    stopAnimation(): void;
    setOnCameraChangeListener(listener: AMap.OnCameraChangeListener): void;
    addOnCameraChangeListener(listener: AMap.OnCameraChangeListener): void;
    setOnInfoWindowClickListener(listener: AMap.OnInfoWindowClickListener): void;
    setOnMapClickListener(listener: AMap.OnMapClickListener): void;
    setOnMapLongClickListener(listener: AMap.OnMapLongClickListener): void;
    setOnMapTouchListener(listener: AMap.OnMapTouchListener): void;
    addOnMapTouchListener(listener: AMap.OnMapTouchListener): void;
    z2(listener: AMap.OnMapReadyListener): void;
    addOnMapReadyDelayListener(listener: AMap.OnMapReadyDelayListener): void;
    setAMapGestureListener(listener: AMap.AMapGestureListener): void;
    addPolyline(options: PolylineOptions): Polyline;
    addPolygon(options: PolygonOptions): Polygon;
    addGroundOverlay(options: GroundOverlayOptions): GroundOverlay;
    addCircle(options: CircleOptions): Circle;
    addArc(h77: ArcOptions): Arc;
    h96(overlay: BaseOverlay, options: BaseOptions): boolean;
    addMarker(options: MarkerOptions): Marker;
    addMarkers(options: ArrayList<MarkerOptions>, e77: boolean): ArrayList<Marker>;
    addMultiPointOverlay(options: MultiPointOverlayOptions): MultiPointOverlay;
    addText(textOptions: TextOptions): Text;
    w2(options: GL3DModelOptions): GL3DModel;
    clear(x76?: boolean): void;
    destroy(): void;
    private isAbroad;
    private m96;
    t64(visibility: number): void;
    u64(): void;
    v64(): void;
    getCameraPosition(): CameraPosition;
    getMapType(): AMap.MapType;
    getMyLocationStyle(): MyLocationStyle | undefined;
    getMyLocation(): geoLocationManager.Location | undefined;
    d65(flag: boolean): void;
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
    setMapType(type: AMap.MapType): void;
    /**
     * 根据MapType更新mapMode、mapTime。
     *
     * @param type 地图模式： MAP_TYPE_NORMAL：普通地图，值为1；<br>
     *             MAP_TYPE_SATELLITE：卫星地图，值为2；<br>
     *             MAP_TYPE_NIGHT 夜景图模式，值为3；<br>
     *             MAP_TYPE_NAVI 导航模式，值为4；<br>
     *             MAP_TYPE_BUS 公交模式，值为5；<br>
     *             MAP_TYPE_NAVI_NIGHT 导航夜间模式，值为6；
     * @since 1.0.0
     * @exclude javadoc中不显示
     */
    private o96;
    setMapLanguage(language: string): void;
    private a89;
    k95(p76: number, flag: boolean): void;
    private r96;
    setLocationSource(g76: LocationSource): void;
    isMyLocationEnabled(): boolean;
    setMyLocationEnabled(enabled: boolean): void;
    setMyLocationStyle(style: MyLocationStyle): void;
    setCustomMapStyle(options: CustomMapStyleOptions, listener?: OnCustomMapStyleFailListener): void;
    z63(enable: boolean, data: Uint8Array): void;
    /**
     * @param enable
     * @param data
     * @param isForceReload 如果为true，就算没有数据，也会触发地图重新下载样式
     */
    c94(enable: boolean, data: Uint8Array | undefined, b76: boolean): void;
    protected u89(y75: v72[] | undefined, z75: boolean): void;
    setMaxZoomLevel(x75: number): void;
    setMinZoomLevel(w75: number): void;
    getMaxZoomLevel(): number;
    getMinZoomLevel(): number;
    resetMinMaxZoomPreference(): void;
    setMapStatusLimits(v75: LatLngBounds): void;
    /**
     * 检查LatLngBounds是否有效，检查包含是否为空，内部经纬度是否为空
     *
     * @return true表示有效，false 无效
     */
    private b97;
    private a97;
    setTrafficEnabled(enabled: boolean): void;
    y63(): boolean;
    m3(enabled: boolean): void;
    e3(enabled: boolean): void;
    f3(enabled: boolean): void;
    setOnMyLocationChangeListener(listener: AMap.OnMyLocationChangeListener): void;
    setOnMarkerDragListener(listener: AMap.OnMarkerDragListener): void;
    setOnMarkerClickListener(listener: AMap.OnMarkerClickListener): void;
    setOnPolylineClickListener(listener: AMap.OnPolylineClickListener): void;
    h3(): UiSettings;
    i3(): Projection;
    getMapContentApprovalNumber(): string;
    getSatelliteImageApprovalNumber(): string;
    getTerrainApprovalNumber(): string;
    w65(): number;
    x65(): number;
    getScalePerPixel(): number;
    clearTileCache(): void;
    j3(i75: boolean): void;
    removeOverlay(id: string): void;
    onCreate(): void;
    j97(h75: p72): void;
    onLongPress(x74: number, e: GestureEvent): void;
    /**
     * 清除高亮地铁标注
     */
    l97(w74: number): void;
    private m93;
    /**
     * 双击地图操作
     */
    onDoubleTap(v74: number, e: GestureEvent): boolean;
    b16(): void;
    /**
     * 地图绘制唤起
     */
    w64(): void;
    /**
     * 异步清除所有的手势消息和动画
     */
    y64(): void;
    private u63;
    /**
     * 点击地图操作
     * 注意事项:调整点选顺序,显示overlay的点，然后是背景点，然后是线图层
     *
     * @param e
     * @return
     */
    private x87;
    /**
     * 底图Poi选中
     *
     * @param e
     */
    private r97;
    /**
     * InfoWindow点击事件<br>
     * 先判断点击,如果点到InfoWindow return true便于后续判断<br>
     * 否则返回false<br>
     * 比如infoWindow下面有一个Marker时,marker不会被点到
     *
     * @throws RemoteException
     */
    private o97;
    private p97;
    private q97;
    /**
     * 手势操作开始
     */
    private u87;
    /**
     * 手势操作结束
     */
    private v87;
    /**
     * Marker拖动
     *
     * @param event
     */
    private w87;
    getMapScreenMarkers(): ArrayList<Marker>;
    r69(): boolean;
    /**
     * 检查setCustomMapStyle 和 setWorldVectorMapStyle 是否同时调用,检查到同时调用时候，后调用的不生效，并添加日志提示
     * @param callFromCustomMapStyle setCustomMapStyle中发起检查
     * @param callFromVectorMapStyle setWorldVectorMapStyle中发起检查
     * @return 返回检查结果，true 表示有同时调用，false 表示没有同时调用
     */
    private n89;
    /**
     * 专业版功能鉴权
     */
    private t96;
    /**
     * 设置建筑是否进行纹理贴图
     */
    l95(v73: number, flag: boolean): void;
    setIndoorFloorSwitchAdapter(u73: IndoorFloorSwitchAdapter): void;
    v93(p73: IndoorBuilding): void;
}
export declare class o73 {
    e93: boolean;
    flag: boolean;
    mode: number;
    style: number;
    f93: number;
    value: number;
    a98: number;
    data?: Uint8Array;
    d93?: l39;
}
