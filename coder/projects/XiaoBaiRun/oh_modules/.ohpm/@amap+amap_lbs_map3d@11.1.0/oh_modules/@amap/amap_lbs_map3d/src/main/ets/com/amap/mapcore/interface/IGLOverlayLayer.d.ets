// @keepTs
// @ts-nocheck
import { BaseOptions } from '../../api/model/BaseOptions';
import { BaseOverlay } from '../../api/model/BaseOverlay';
import { MarkerOptions } from '../../api/model/MarkerOptions';
import { Point } from '../../api/model/Point';
import { PolylineOptions } from '../../api/model/PolylineOptions';
import { n60 } from '../widget/IInfoWindow';
import { x69 } from './IAMapGLOverlayCreator';
import { b98 } from './IAMapNativeGlOverlayLayer';
import { v71 } from './IAMapOverlayFuncOperator';
import { LatLng } from '../../api/model/LatLng';
import ArrayList from '@ohos.util.ArrayList';
import { Marker } from '../../api/model/Marker';
import { p66 } from './IAMapNativeDelegate';
import { MultiPointOverlayOptions } from '../../api/model/MultiPointOverlayOptions';
export interface d16 {
    e8(type: string): string;
    k64(overlayName: string, overlay: BaseOverlay, options: BaseOptions): void;
    removeOverlay(overlayName: string): void;
    clear(keepOverlayNames: string[]): void;
    v158(overlayName: string): BaseOverlay | undefined;
    showInfoWindow(overlayName: string): void;
    hideInfoWindow(overlayName: string): void;
    isInfoWindowShown(overlayName?: string): boolean;
    redrawInfoWindow(): void;
    h8(overlayName: string): void;
    getMapScreenMarkers(): ArrayList<Marker>;
    updateOption(overlayName: string, options: BaseOptions): void;
    i64(options: PolylineOptions): void;
    n64(options: MarkerOptions): void;
    g8(overlayName: string): boolean;
    i72(overlayName: string, fPoint: Point): void;
    t97(e: GestureEvent): BaseOverlay | undefined;
    x63(infoWindowAdapterManager: n60): void;
    destroy(): void;
    draw(renderOrder: number, mapTextZIndex: number, useDefaultSort: boolean): boolean;
    f8(): void;
    c162(): x69 | undefined;
    x37(): v71 | undefined;
    z70(): b98 | undefined;
    d8(e: GestureEvent | LatLng, overlayType: number): BaseOverlay | undefined;
    x11(): p66;
    b8(overlayName: string, overlay: BaseOverlay, options: BaseOptions): BaseOverlay;
    c8(overlayName: string, functionName: string, args: object[]): object | undefined;
    o64(options: MultiPointOverlayOptions): void;
}
export declare class q162 {
    static readonly l164 = 0;
    static readonly m164 = 1;
    static readonly n164 = 2;
    static readonly o164 = 3;
    static readonly p164 = 4;
    static readonly q164 = 5;
    static readonly r164 = 6;
    static readonly s164 = 7;
    static readonly q166 = 8;
    static readonly r166 = 9;
    static readonly s166 = 10;
    static readonly t166 = 11;
}
export declare class b88 {
    static readonly c88 = 0;
    static readonly e88 = 1;
    static readonly f88 = 2;
}
