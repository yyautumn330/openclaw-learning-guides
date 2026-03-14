// @keepTs
// @ts-nocheck
import { v71 } from './interface/IAMapOverlayFuncOperator';
import { d16 } from './interface/IGLOverlayLayer';
import { Point } from '../api/model/Point';
import { LatLng } from '../api/model/LatLng';
export declare class w71 implements v71 {
    private glOverlayLayer;
    constructor(g72: d16);
    a38(f72: string, clickable: boolean): void;
    z37(e72: string): boolean;
    h72(d72: string, shown: boolean): void;
    isInfoWindowShown(c72: string): boolean;
    i72(b72: string, result: Point): void;
    j72(a72: string, result: Point): void;
    k72(z71: string): LatLng;
    getAlpha(y71: string): number;
    getRotateAngle(x71: string): number;
}
