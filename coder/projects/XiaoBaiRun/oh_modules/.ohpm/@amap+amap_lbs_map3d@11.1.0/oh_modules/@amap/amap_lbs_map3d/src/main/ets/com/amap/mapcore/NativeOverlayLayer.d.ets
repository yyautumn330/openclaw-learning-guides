// @keepTs
// @ts-nocheck
import { DPoint } from "../api/model/DPoint";
import { Marker } from "../api/model/Marker";
import { MarkerOptions } from "../api/model/MarkerOptions";
import { s36 } from "./interface/INativeOverlayLayer";
import drawing from "@ohos.graphics.drawing";
import ArrayList from "@ohos.util.ArrayList";
import { BaseOverlay, Rect } from "../../../../../../Index";
import { IAMap } from "./interface/IAMap";
export declare class c73 implements s36 {
    private context;
    private l2;
    private x179;
    constructor(context: Context, map: IAMap);
    i96(marker: Marker, v179: MarkerOptions): void;
    u37(u179: string): void;
    m167(s179: string, t179: MarkerOptions): void;
    n167(): void;
    o167(): void;
    showInfoWindow(r179: string): void;
    hideInfoWindow(q179: string): void;
    isInfoWindowShown(p179: string): boolean;
    g8(o179: string): boolean;
    p167(m179: DPoint, n179: number): BaseOverlay;
    h8(l179: string): void;
    getMapScreenMarkers(): ArrayList<Marker>;
    q167(k179: string): Rect;
    clear(): void;
    r167(canvas: drawing.Canvas): void;
}
