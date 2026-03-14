// @keepTs
// @ts-nocheck
import { GL3DModelOptions } from '../api/model/GL3DModelOptions';
import { MarkerOptions } from '../api/model/MarkerOptions';
import { PolylineOptions } from '../api/model/PolylineOptions';
import { x69 } from './interface/IAMapGLOverlayCreator';
import { d16 } from './interface/IGLOverlayLayer';
import { PolygonOptions } from '../api/model/PolygonOptions';
import { CircleOptions } from '../api/model/CircleOptions';
import { GroundOverlayOptions } from '../api/model/GroundOverlayOptions';
import { TileOverlayOptions } from '../api/model/TileOverlayOptions';
import { ArcOptions } from '../api/model/ArcOptions';
import { MultiPointOverlayOptions } from '../api/model/MultiPointOverlayOptions';
import { HeatMapLayerOptions } from '../api/model/HeatMapLayerOptions';
export declare class z69 implements x69 {
    private glOverlayLayer;
    private x70;
    constructor(w70: d16);
    y70(v70: string, options: MarkerOptions): void;
    b71(u70: string, options: MarkerOptions): void;
    c71(t70: string, options: PolylineOptions): void;
    d71(s70: string, options: PolylineOptions): void;
    e71(r70: string, options: PolygonOptions): void;
    f71(q70: string, options: PolygonOptions): void;
    g71(p70: string, options: CircleOptions): void;
    h71(o70: string, options: CircleOptions): void;
    i71(n70: string, options: GL3DModelOptions): void;
    j71(m70: string, options: GL3DModelOptions): void;
    k71(l70: string, options: GroundOverlayOptions): void;
    l71(k70: string, options: GroundOverlayOptions): void;
    m71(j70: string, options: TileOverlayOptions): void;
    n71(i70: string, options: TileOverlayOptions): void;
    o71(h70: string, options: HeatMapLayerOptions): void;
    p71(g70: string, options: HeatMapLayerOptions): void;
    q71(f70: string, options: TileOverlayOptions): void;
    y58(e70: string, options: TileOverlayOptions): void;
    r71(d70: string, options: ArcOptions): void;
    s71(c70: string, options: ArcOptions): void;
    t71(b70: string, options: MultiPointOverlayOptions): void;
    u71(a70: string, options: MultiPointOverlayOptions): void;
}
