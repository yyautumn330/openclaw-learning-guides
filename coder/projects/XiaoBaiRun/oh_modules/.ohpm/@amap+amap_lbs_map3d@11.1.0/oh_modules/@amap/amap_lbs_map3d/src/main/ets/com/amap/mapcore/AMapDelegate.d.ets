// @keepTs
// @ts-nocheck
import ArrayList from '@ohos.util.ArrayList';
import geoLocationManager from '@ohos.geoLocationManager';
import { CameraUpdate } from '../api/CameraUpdate';
import { Marker } from '../api/model/Marker';
import { MarkerOptions } from '../api/model/MarkerOptions';
import { MyLocationStyle } from '../api/model/MyLocationStyle';
import { IAMap } from './interface/IAMap';
import { LatLngBounds } from '../api/model/LatLngBounds';
import * as AMap from '../api/AMap';
import { PolylineOptions } from '../api/model/PolylineOptions';
import { Polyline } from '../api/model/Polyline';
import { PolygonOptions } from '../api/model/PolygonOptions';
import { Polygon } from '../api/model/Polygon';
import { Circle } from '../api/model/Circle';
import { CameraPosition } from '../api/model/CameraPosition';
import { LocationSource } from '../api/LocationSource';
import { CustomMapStyleOptions } from '../api/model/CustomMapStyleOptions';
import { UiSettings } from '../api/UiSettings';
import { Projection } from '../api/Projection';
import { d12 } from './interface/bridge/IMapViewBridge';
import { CircleOptions } from '../../amap/api/model/CircleOptions';
import { b53 } from './MapConfig';
import { r60 } from './interface/IAMapLiteDelegate';
import { GL3DModelOptions } from '../api/model/GL3DModelOptions';
import { GL3DModel } from '../api/model/GL3DModel';
import { LatLng } from '../api/model/LatLng';
import { s60 } from './interface/IGLMapEngine';
import { l39 } from '../api/model/MyTrafficStyle';
import { f16 } from '../api/model/amap3dmodeltile/AMap3DModelTileOverlayOptions';
import { g16 } from '../api/model/amap3dmodeltile/AMap3DModelTileOverlay';
import { OnCustomMapStyleFailListener } from '../api/AMap';
import { TextOptions } from '../api/model/TextOptions';
import { Text } from '../api/model/Text';
import { GroundOverlayOptions } from '../api/model/GroundOverlayOptions';
import { GroundOverlay } from '../api/model/GroundOverlay';
import { TileOverlay } from '../api/model/TileOverlay';
import { TileOverlayOptions } from '../api/model/TileOverlayOptions';
import { u60 } from './GLMapEngine';
import { ArcOptions } from '../api/model/ArcOptions';
import { Arc } from '../api/model/Arc';
import { MultiPointOverlay } from '../api/model/MultiPointOverlay';
import { MultiPointOverlayOptions } from '../api/model/MultiPointOverlayOptions';
import { HeatMapLayerOptions } from '../api/model/HeatMapLayerOptions';
import { HeatMapLayer } from '../api/model/HeatMapLayer';
import { IndoorBuildingInfo } from '../api/model/IndoorBuildingInfo';
import { IndoorFloorSwitchAdapter } from '../api/model/IndoorFloorSwitchAdapter';
import { b1 } from '../api/model/CrossOverlay';
import { c1 } from '../api/model/CrossOverlayOptions';
/**
 * 地图接口的实现类
 */
export declare class i15 implements IAMap, r60 {
    private mapViewBridge;
    private context;
    private x62;
    private y62?;
    private z62?;
    protected a63?: u60;
    private b63;
    private glOverlayLayer;
    private resourceManager;
    private f56;
    private aMapJsCallback;
    private c63;
    private d63;
    private e63;
    private m2;
    private n2;
    private f63;
    private g63;
    private h63;
    private i63;
    private j63;
    private k63;
    private l63;
    private m63;
    private n63;
    private o63;
    constructor(l342: d12);
    addOnMapReadyDelayListener(listener: AMap.OnMapReadyDelayListener): void;
    addOnPolylineClickListener(listener: AMap.OnPolylineClickListener): void;
    removeOnPolylineClickListener(listener: AMap.OnPolylineClickListener): void;
    setIndoorFloorSwitchAdapter(listener: IndoorFloorSwitchAdapter): void;
    addHeatMapLayer(options: HeatMapLayerOptions): HeatMapLayer | undefined;
    setIndoorBuildingInfo(v62: IndoorBuildingInfo): void;
    y63(): boolean;
    m3(enabled: boolean): void;
    setMapLanguage(language: string): void;
    setWorldVectorMapStyle(style: string): void;
    getWorldVectorMapStyle(): string;
    addArc(options: ArcOptions): Arc;
    addTileOverlay(u62: TileOverlayOptions): TileOverlay | undefined;
    o59(options: f16): g16 | undefined;
    j57(): s60;
    t58(data: Uint8Array | undefined, style: l39 | undefined): void;
    l3(): void;
    n58(flag?: boolean | undefined): void;
    getMapScreenShot(listener: AMap.OnMapScreenShotListener, t62: boolean): void;
    z63(enable: boolean, data: Uint8Array): void;
    c3(s62: c1 | null): b1 | null;
    getViewMatrix(): Float64Array;
    getProjectionMatrix(): Float64Array;
    calculateZoomToSpanLevel(m62: number, n62: number, o62: number, p62: number, q62: LatLng, r62: LatLng): [
        number,
        LatLng
    ];
    getMapScreenMarkers(): ArrayList<Marker>;
    v2(k62: CameraUpdate, l62: number): void;
    u2(i62: CameraUpdate, j62: AMap.CancelableCallback): void;
    t2(f62: CameraUpdate, g62: number, h62: AMap.CancelableCallback): void;
    isMyLocationEnabled(): boolean;
    resetMinMaxZoomPreference(): void;
    setTouchPoiEnable(e62: boolean): void;
    isTouchPoiEnable(): boolean;
    getZoomToSpanLevel(c62: LatLng, d62: LatLng): number;
    setMapTextZIndex(x: number): void;
    getMapTextZIndex(): number;
    setInfoWindowAdapter(adapter: CustomBuilder | undefined): void;
    addOnPOIClickListener(listener: AMap.OnMapPOIClickListener): void;
    removeOnPOIClickListener(listener: AMap.OnMapPOIClickListener): void;
    addInfoWindowListener(adapter: AMap.InfoWindowListener): void;
    removeInfoWindowListener(adapter: AMap.InfoWindowListener): void;
    setRenderFps(fps: number): void;
    addAMapAppResourceListener(listener: AMap.AMapAppResourceRequestListener): void;
    removeAMapAppResourceListener(listener: AMap.AMapAppResourceRequestListener): void;
    g3(x: number, y: number): void;
    setCustomRenderer(render: AMap.CustomRenderer): void;
    isTrafficEnabled(): boolean;
    setNaviLabelEnable(enabled: boolean, a62: number, b62: number): void;
    getNativeMapController(): bigint;
    a3(): number;
    w2(options: GL3DModelOptions): GL3DModel;
    init(): void;
    moveCamera(z61: CameraUpdate): void;
    animateCamera(y61: CameraUpdate): void;
    stopAnimation(): void;
    setOnCameraChangeListener(listener: AMap.OnCameraChangeListener): void;
    addOnCameraChangeListener(listener: AMap.OnCameraChangeListener): void;
    setOnMapClickListener(listener: AMap.OnMapClickListener): void;
    setOnMapLongClickListener(listener: AMap.OnMapLongClickListener): void;
    setOnMapTouchListener(listener: AMap.OnMapTouchListener): void;
    addOnMapTouchListener(listener: AMap.OnMapTouchListener): void;
    z2(listener: AMap.OnMapReadyListener): void;
    setAMapGestureListener(listener: AMap.AMapGestureListener): void;
    addPolyline(w61: PolylineOptions): Polyline;
    addPolygon(u61: PolygonOptions): Polygon;
    addGroundOverlay(s61: GroundOverlayOptions): GroundOverlay;
    addCircle(q61: CircleOptions): Circle;
    addMarker(o61: MarkerOptions): Marker;
    addMultiPointOverlay(m61: MultiPointOverlayOptions): MultiPointOverlay;
    addText(textOptions: TextOptions): Text;
    addMarkers(options: ArrayList<MarkerOptions>, g61: boolean): ArrayList<Marker>;
    clear(f61?: boolean): void;
    destroy(): void;
    t64(visibility: number): void;
    u64(): void;
    v64(): void;
    /**
     * 地图绘制唤起
     */
    w64(): void;
    /**
     * 异步清除所有的手势消息和动画
     */
    y64(): void;
    getCameraPosition(): CameraPosition;
    /**
     * 地图绘制暂停
     */
    b16(e61: number): void;
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
    setLocationSource(d61: LocationSource): void;
    setMyLocationEnabled(enabled: boolean): void;
    setMyLocationStyle(style: MyLocationStyle): void;
    setCustomMapStyle(options: CustomMapStyleOptions, listener?: OnCustomMapStyleFailListener): void;
    setMaxZoomLevel(c61: number): void;
    setMinZoomLevel(b61: number): void;
    getMaxZoomLevel(): number;
    getMinZoomLevel(): number;
    setMapStatusLimits(a61: LatLngBounds): void;
    setTrafficEnabled(enabled: boolean): void;
    e3(enabled: boolean): void;
    f3(enabled: boolean): void;
    setOnMyLocationChangeListener(listener: AMap.OnMyLocationChangeListener): void;
    setOnMarkerDragListener(listener: AMap.OnMarkerDragListener): void;
    setOnInfoWindowClickListener(listener: AMap.OnInfoWindowClickListener): void;
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
    j3(w60: boolean): void;
    removeOverlay(id: string): void;
    y65(version: string, url: string, reason: number): void;
    onCreate(): void;
    u63(): void;
    l57(): b53;
}
