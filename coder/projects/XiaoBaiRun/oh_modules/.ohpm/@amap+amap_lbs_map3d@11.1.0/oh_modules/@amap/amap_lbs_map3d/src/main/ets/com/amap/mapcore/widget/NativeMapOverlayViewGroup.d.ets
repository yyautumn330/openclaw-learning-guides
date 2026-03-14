// @keepTs
// @ts-nocheck
/**
 *
 */
import { Context } from '@ohos.abilityAccessCtrl';
import { BasePointOverlay } from '../../api/model/BasePointOverlay';
import { Point } from '../../api/model/Point';
import { IAMap } from '../interface/IAMap';
import { d16 } from '../interface/IGLOverlayLayer';
import { d12 } from '../interface/bridge/IMapViewBridge';
import { n60 } from './IInfoWindow';
import { o60 } from './IInfoWindowAction';
import { r72 } from '../interface/IMapOverlayViewGroup';
import { w166 } from './CompassView';
import { x166 } from './LocationView';
import { v166 } from './BlankView';
import { y166 } from './ScaleView';
import { b73 } from './WaterMarkerView';
import { CameraPosition } from '../../api/model/CameraPosition';
import { a60 } from '../AmapDelegateListenerManager';
import { s36 } from '../interface/INativeOverlayLayer';
import drawing from "@ohos.graphics.drawing";
import { IndoorFloorSwitchAdapter } from '../../api/model/IndoorFloorSwitchAdapter';
export declare class q72 implements r72, o60 {
    private g102;
    private o279;
    private n37;
    private z275;
    private mapViewBridge;
    private b162?;
    private mContext;
    private a276?;
    private b276;
    private c276;
    private d276;
    private e276;
    private p279;
    private q279;
    private r279;
    private s279;
    private t279;
    private u279;
    private v279;
    private g130;
    private a66;
    constructor(context: Context, map: IAMap, s342: d16, t342: d12, u342: a60, v342: s36);
    l92(h279: boolean): void;
    y97(g279: IndoorFloorSwitchAdapter): void;
    k92(f279: boolean): void;
    m92(e279: boolean): void;
    n92(d279: boolean): void;
    o92(c279: boolean): void;
    p93(b279: boolean): void;
    z166(path: string, enable: boolean, type: number): void;
    a167(zoom: number): void;
    setZoomPosition(position: number): void;
    setLogoPosition(position: number): void;
    setLogoBottomMargin(a279: number): void;
    setLogoLeftMargin(pixels: number): void;
    getLogoMarginRate(type: number): number;
    setLogoMarginRate(type: number, rate: number): void;
    x92(): Point;
    c93(flag: boolean): void;
    b167(): boolean;
    c167(): void;
    d167(): y166;
    f91(): v166;
    e167(): x166;
    f167(): w166;
    o91(): b73;
    z88(position: CameraPosition): void;
    h167(z278: boolean): void;
    clear(): void;
    j167(): void;
    k167(y278: boolean): void;
    g97(visible: boolean): void;
    l110(visible: boolean): void;
    l167(): void;
    i167(x278: n60): void;
    g167(): void;
    showInfoWindow(marker: BasePointOverlay): void;
    private i276;
    private j276;
    private g276;
    private h276;
    /**
     * infoWindow刷新
     */
    redrawInfoWindow(): void;
    hideInfoWindow(): void;
    private b280;
    isInfoWindowShown(): boolean;
    destroy(): void;
    o97(e: GestureEvent): boolean;
    p91(canvas: drawing.Canvas): Promise<void>;
}
