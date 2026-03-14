// @keepTs
// @ts-nocheck
import { BaseOptions } from '../api/model/BaseOptions';
import { BaseOverlay } from '../api/model/BaseOverlay';
import { Marker } from '../api/model/Marker';
import { MarkerOptions } from '../api/model/MarkerOptions';
import { Point } from '../api/model/Point';
import { PolylineOptions } from '../api/model/PolylineOptions';
import { IAMap } from './interface/IAMap';
import { x52 } from './interface/IAMapJsCall';
import { d16 } from './interface/IGLOverlayLayer';
import { i60 } from './platform/IResourceManager';
import { n60 } from './widget/IInfoWindow';
import { x69 } from './interface/IAMapGLOverlayCreator';
import { v71 } from './interface/IAMapOverlayFuncOperator';
import { b98 } from './interface/IAMapNativeGlOverlayLayer';
import { LatLng } from '../api/model/LatLng';
import ArrayList from "@ohos.util.ArrayList";
import { p66 } from './interface/IAMapNativeDelegate';
import { CircleOptions } from '../api/model/CircleOptions';
import { GL3DModelOptions } from '../api/model/GL3DModelOptions';
import { PolygonOptions } from '../api/model/PolygonOptions';
import { TileOverlayOptions } from '../api/model/TileOverlayOptions';
import { GroundOverlayOptions } from '../api/model/GroundOverlayOptions';
import { ArcOptions } from '../api/model/ArcOptions';
import { MultiPointOverlayOptions } from '../api/model/MultiPointOverlayOptions';
import { HeatMapLayerOptions } from '../api/model/HeatMapLayerOptions';
export declare class v59 implements d16, x69 {
    private readonly f56;
    private readonly r107;
    private readonly z161;
    private index;
    private a162;
    private b162?;
    constructor(w161: IAMap, x161: x52, y161: i60);
    o71(u161: string, v161: HeatMapLayerOptions): void;
    p71(s161: string, t161: HeatMapLayerOptions): void;
    q71(q161: string, r161: TileOverlayOptions): void;
    y58(o161: string, p161: TileOverlayOptions): void;
    t71(m161: string, n161: MultiPointOverlayOptions): void;
    u71(k161: string, l161: MultiPointOverlayOptions): void;
    n71(i161: string, j161: TileOverlayOptions): void;
    s71(g161: string, h161: ArcOptions): void;
    r71(e161: string, f161: ArcOptions): void;
    k71(c161: string, d161: GroundOverlayOptions): void;
    l71(a161: string, b161: GroundOverlayOptions): void;
    c8(y160: string, z160: string, args: object[]): object | undefined;
    m71(w160: string, x160: TileOverlayOptions): void;
    y70(u160: string, v160: MarkerOptions): void;
    b71(s160: string, t160: MarkerOptions): void;
    c71(q160: string, r160: PolylineOptions): void;
    d71(o160: string, p160: PolylineOptions): void;
    e71(m160: string, n160: PolygonOptions): void;
    f71(k160: string, l160: PolygonOptions): void;
    g71(i160: string, j160: CircleOptions): void;
    h71(g160: string, h160: CircleOptions): void;
    i71(e160: string, f160: GL3DModelOptions): void;
    j71(c160: string, d160: GL3DModelOptions): void;
    b8(b160: string, overlay: BaseOverlay, options: BaseOptions): BaseOverlay;
    x11(): p66;
    getMapScreenMarkers(): ArrayList<Marker>;
    z70(): b98 | undefined;
    c162(): x69 | undefined;
    x37(): v71 | undefined;
    f8(): void;
    draw(y159: number, z159: number, a160: boolean): boolean;
    destroy(): void;
    d8(e: GestureEvent | LatLng, x159: number): BaseOverlay;
    t97(e: GestureEvent): BaseOverlay | undefined;
    e8(type: string): string;
    k64(w159: string, overlay: BaseOverlay, options: BaseOptions): void;
    /**
     * 检查是否需要更新Marker信息收集
     * @param json
     */
    private d162;
    removeOverlay(v159: string): void;
    private g162;
    /**
     * 移除但保留部分覆盖物
     * @param keepOverlayNames
     */
    clear(r159: string[]): void;
    v158(q159: string): BaseOverlay;
    showInfoWindow(p159: string): void;
    hideInfoWindow(o159: string): void;
    isInfoWindowShown(): boolean;
    /**
     * 更新InfoWindow位置
     */
    redrawInfoWindow(): void;
    h8(n159: string): void;
    updateOption(m159: string, options: BaseOptions): void;
    private e162;
    /**
     * 更新图片资源
     * @param options
     */
    private h162;
    i64(options: PolylineOptions): void;
    n64(options: MarkerOptions): void;
    o64(options: MultiPointOverlayOptions): void;
    x63(l159: n60): void;
    g8(k159: string): boolean;
    i72(i159: string, j159: Point): void;
}
