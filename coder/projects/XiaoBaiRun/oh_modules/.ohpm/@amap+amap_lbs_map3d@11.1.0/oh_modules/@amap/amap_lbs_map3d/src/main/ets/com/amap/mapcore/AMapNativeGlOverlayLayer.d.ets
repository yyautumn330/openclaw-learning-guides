// @keepTs
// @ts-nocheck
import { b98 } from './interface/IAMapNativeGlOverlayLayer';
import { BaseOptions } from '../api/model/BaseOptions';
import { LatLng } from '../api/model/LatLng';
import { w52 } from './AMapAppRequestParam';
import { BitmapDescriptor } from '../api/model/BitmapDescriptor';
import { ImageOptions } from '../api/model/ImageOptions';
import { d98 } from './interface/IAMapGLOverlayCallback';
export declare class b88 {
    static readonly c88 = 0;
    static readonly e88 = 1;
    static readonly f88 = 2;
}
export declare class l73 implements b98 {
    private x70;
    private e99;
    private f99?;
    constructor(d99: number);
    a71(): bigint;
    a95(c99: bigint): void;
    q71(b99: string, option: BaseOptions): void;
    removeOverlay(a99: string): void;
    clear(z98: string[]): void;
    y58(y98: string, option: BaseOptions): void;
    contain(latLng: LatLng, x98: number): string;
    g99(w98: string): number;
    c8(u98: string, v98: string, args: Object[]): object;
    render(r98: number, s98: number, t98: boolean): void;
    h99(listener: d98): void;
    destroy(): void;
    i99(): string[];
    showInfoWindow(q98: string): void;
    hideInfoWindow(): void;
    j99(): void;
    k99(x: number, y: number): boolean;
    h72(p98: string, shown: boolean): void;
    l99(o98: boolean): void;
    clearTileCache(): void;
    g8(n98: string): boolean;
    h8(m98: string): void;
    getEngineId(): number;
    j3(l98: boolean): void;
    redrawInfoWindow(): void;
    getInfoWindow(k98: string): BitmapDescriptor;
    getInfoContents(j98: string): BitmapDescriptor;
    getInfoWindowUpdateOffsetTime(i98: string): bigint;
    getInfoWindowClick(h98: string): BitmapDescriptor;
    getOverturnInfoWindow(g98: string): BitmapDescriptor;
    getOverturnInfoWindowClick(f98: string): BitmapDescriptor;
    getBuildInImageData(e98: number): BitmapDescriptor;
    getImagedData(options: ImageOptions): BitmapDescriptor;
    getAMapResource(param: w52): void;
}
