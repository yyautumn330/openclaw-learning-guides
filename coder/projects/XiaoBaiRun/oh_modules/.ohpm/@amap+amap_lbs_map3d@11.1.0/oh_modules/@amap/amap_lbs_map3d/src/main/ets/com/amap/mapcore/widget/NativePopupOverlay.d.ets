// @keepTs
// @ts-nocheck
import { BasePointOverlay } from '../../api/model/BasePointOverlay';
import { d16 } from '../interface/IGLOverlayLayer';
import { n60 } from './IInfoWindow';
import { o60 } from './IInfoWindowAction';
export declare class w72 implements o60 {
    private static readonly TAG;
    private static readonly overlayName;
    private context;
    private glOverlayLayer;
    private i280?;
    constructor(context: Context, h280: d16);
    showInfoWindow(marker: BasePointOverlay): void;
    hideInfoWindow(): void;
    isInfoWindowShown(): boolean;
    redrawInfoWindow(): void;
    o97(event: GestureEvent): boolean;
    i167(c280: n60): void;
}
