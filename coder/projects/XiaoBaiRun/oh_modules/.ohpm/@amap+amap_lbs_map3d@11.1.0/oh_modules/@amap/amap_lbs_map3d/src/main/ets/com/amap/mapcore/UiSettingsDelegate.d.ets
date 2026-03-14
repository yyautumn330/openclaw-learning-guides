// @keepTs
// @ts-nocheck
/**
 * 地图内置UI及手势控制器。
 *
 * @since 1.0.0
 */
import { x52 } from '../mapcore/interface/IAMapJsCall';
import { n49 } from '../mapcore/interface/IUiSettings';
export declare class c60 implements n49 {
    private f263;
    private g263;
    private h263;
    private i263;
    private j263;
    private k263;
    private l263;
    private m263;
    private n263;
    private o263;
    private aLogoPosition;
    private p263;
    private q263;
    private static readonly r263;
    private static readonly SCALE;
    private static readonly s263;
    private static readonly t263;
    private static readonly u263;
    private static readonly v263;
    private static readonly w263;
    private x263;
    private y263;
    constructor(e263: x52);
    l93(): boolean;
    getLogoPosition(): number;
    isScaleControlsEnabled(): boolean;
    isZoomControlsEnabled(): boolean;
    isCompassEnabled(): boolean;
    isMyLocationButtonEnabled(): boolean;
    s49(enable: boolean): void;
    v167(): void;
    isLogoEnable(): boolean;
    r49(): boolean;
    setIndoorSwitchEnabled(d263: boolean): void;
    setLogoMarginRate(type: number, rate: number): void;
    getLogoMarginRate(type: number): number;
    setLogoLeftMargin(pixels: number): void;
    setLogoBottomMargin(pixels: number): void;
    setZoomInByScreenCenter(c263: boolean): void;
    setScaleControlsEnabled(enabled: boolean): void;
    setZoomControlsEnabled(enabled: boolean): void;
    setCompassEnabled(enabled: boolean): void;
    setMyLocationButtonEnabled(enabled: boolean): void;
    setLogoPosition(position: number): void;
    setZoomPosition(position: number): void;
    getZoomPosition(): number;
    setScrollGesturesEnabled(enabled: boolean): void;
    setZoomGesturesEnabled(enabled: boolean): void;
    setTiltGesturesEnabled(enabled: boolean): void;
    setRotateGesturesEnabled(enabled: boolean): void;
    setAllGesturesEnabled(enabled: boolean): void;
    isScrollGesturesEnabled(): boolean;
    isZoomGesturesEnabled(): boolean;
    isTiltGesturesEnabled(): boolean;
    isRotateGesturesEnabled(): boolean;
    setGestureScaleByMapCenter(isGestureScaleByMapCenter: boolean): void;
    isGestureScaleByMapCenter(): boolean;
}
