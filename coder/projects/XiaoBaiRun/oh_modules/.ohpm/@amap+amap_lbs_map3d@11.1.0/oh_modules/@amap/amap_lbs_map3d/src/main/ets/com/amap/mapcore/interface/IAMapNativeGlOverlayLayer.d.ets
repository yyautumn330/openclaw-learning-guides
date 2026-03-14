// @keepTs
// @ts-nocheck
import { BaseOptions } from '../../api/model/BaseOptions';
import { BitmapDescriptor } from '../../api/model/BitmapDescriptor';
import { ImageOptions } from '../../api/model/ImageOptions';
import { LatLng } from '../../api/model/LatLng';
import { w52 } from '../AMapAppRequestParam';
import { d98 } from './IAMapGLOverlayCallback';
export interface b98 {
    a71(): bigint;
    q71(overlayName: string, option: BaseOptions): void;
    removeOverlay(overlayName: string): void;
    clear(excludeOverlayName: string[]): void;
    y58(overlayName: string, option: BaseOptions): void;
    contain(latLng: LatLng, overlayType: number): string;
    g99(overlayName: string): number;
    c8(overlayName: string, functionName: string, args: object[]): object;
    render(renderOrder: number, mapTextZIndex: number, useDefaultSort: boolean): void;
    h99(listener: d98): void;
    a95(engineInstance: bigint): void;
    destroy(): void;
    h8(overlayName: string): void;
    i99(): string[];
    showInfoWindow(overlayName: string): void;
    hideInfoWindow(): void;
    j99(): void;
    k99(x: number, y: number): boolean;
    h72(overlayName: string, shown: boolean): void;
    l99(flingState: boolean): void;
    clearTileCache(): void;
    g8(overlayName: string): boolean;
    getEngineId(): number;
    j3(lowFrame: boolean): void;
    redrawInfoWindow(): void;
    getInfoWindow(overlayName: string): BitmapDescriptor;
    getInfoContents(overlayName: string): BitmapDescriptor;
    getInfoWindowUpdateOffsetTime(overlayName: string): bigint;
    getInfoWindowClick(overlayName: string): BitmapDescriptor;
    getOverturnInfoWindow(overlayName: string): BitmapDescriptor;
    getOverturnInfoWindowClick(overlayName: string): BitmapDescriptor;
    getBuildInImageData(imageName: number): BitmapDescriptor;
    getImagedData(options: ImageOptions): BitmapDescriptor;
    getAMapResource(param: w52): void;
}
