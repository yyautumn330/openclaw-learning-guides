// @keepTs
// @ts-nocheck
import { LatLng } from '../../api/model/LatLng';
import { Point } from '../../api/model/Point';
export interface v71 {
    a38(overlayName: string, clickable: boolean): void;
    z37(overlayName: string): boolean;
    h72(overlayName: string, shown: boolean): void;
    isInfoWindowShown(overlayName: string): boolean;
    i72(overlayName: string, result: Point): void;
    j72(overlayName: string, result: Point): void;
    k72(overlayName: string): LatLng;
    getAlpha(overlayName: string): number;
    getRotateAngle(overlayName: string): number;
}
