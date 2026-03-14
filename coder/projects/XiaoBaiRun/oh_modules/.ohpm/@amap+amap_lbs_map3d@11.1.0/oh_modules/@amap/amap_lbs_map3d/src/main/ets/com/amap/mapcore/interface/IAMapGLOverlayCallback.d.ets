// @keepTs
// @ts-nocheck
import { BitmapDescriptor } from '../../api/model/BitmapDescriptor';
import { ImageOptions } from '../../api/model/ImageOptions';
import { w52 } from '../AMapAppRequestParam';
export interface d98 {
    m99(lowFrame: boolean): void;
    n99(): void;
    getInfoWindow(overlayName: string): BitmapDescriptor;
    getInfoContents(overlayName: string): BitmapDescriptor;
    getInfoWindowUpdateOffsetTime(overlayName: string): bigint;
    getInfoWindowClick(overlayName: string): BitmapDescriptor;
    getOverturnInfoWindow(overlayName: string): BitmapDescriptor;
    getOverturnInfoWindowClick(overlayName: string): BitmapDescriptor;
    getBuildInImageData(imageName: number): BitmapDescriptor;
    o99(options: ImageOptions): BitmapDescriptor;
    getAMapResource(param: w52): void;
}
