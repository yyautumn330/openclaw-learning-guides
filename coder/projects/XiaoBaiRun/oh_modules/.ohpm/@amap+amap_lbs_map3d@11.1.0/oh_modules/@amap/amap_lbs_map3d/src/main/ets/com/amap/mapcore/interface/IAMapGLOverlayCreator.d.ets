// @keepTs
// @ts-nocheck
import { GL3DModelOptions } from '../../api/model/GL3DModelOptions';
import { MarkerOptions } from '../../api/model/MarkerOptions';
import { PolygonOptions } from '../../api/model/PolygonOptions';
import { PolylineOptions } from '../../api/model/PolylineOptions';
import { CircleOptions } from '../../api/model/CircleOptions';
import { GroundOverlayOptions } from '../../api/model/GroundOverlayOptions';
import { TileOverlayOptions } from '../../api/model/TileOverlayOptions';
import { ArcOptions } from '../../api/model/ArcOptions';
import { MultiPointOverlayOptions } from '../../api/model/MultiPointOverlayOptions';
import { HeatMapLayerOptions } from '../../api/model/HeatMapLayerOptions';
export interface x69 {
    y70(overlayName: string, markerOptions: MarkerOptions): void;
    b71(overlayName: string, markerOptions: MarkerOptions): void;
    c71(overlayName: string, polylineOptions: PolylineOptions): void;
    d71(overlayName: string, polylineOptions: PolylineOptions): void;
    e71(overlayName: string, polygonOptions: PolygonOptions): void;
    f71(overlayName: string, polygonOptions: PolygonOptions): void;
    g71(overlayName: string, circleOptions: CircleOptions): void;
    h71(overlayName: string, circleOptions: CircleOptions): void;
    i71(overlayName: string, gl3DModelOptions: GL3DModelOptions): void;
    j71(overlayName: string, gl3DModelOptions: GL3DModelOptions): void;
    k71(overlayName: string, groundOverlayOptions: GroundOverlayOptions): void;
    l71(overlayName: string, groundOverlayOptions: GroundOverlayOptions): void;
    m71(overlayName: string, tileOverlayOptions: TileOverlayOptions): void;
    n71(overlayName: string, tileOverlayOptions: TileOverlayOptions): void;
    o71(overlayName: string, heatMapLayerOptions: HeatMapLayerOptions): void;
    p71(overlayName: string, heatMapLayerOptions: HeatMapLayerOptions): void;
    q71(overlayName: string, tileOverlayOptions: TileOverlayOptions): void;
    y58(overlayName: string, tileOverlayOptions: TileOverlayOptions): void;
    r71(overlayName: string, tileOverlayOptions: ArcOptions): void;
    s71(overlayName: string, tileOverlayOptions: ArcOptions): void;
    t71(overlayName: string, multiPointOverlayOptions: MultiPointOverlayOptions): void;
    u71(overlayName: string, multiPointOverlayOptions: MultiPointOverlayOptions): void;
}
