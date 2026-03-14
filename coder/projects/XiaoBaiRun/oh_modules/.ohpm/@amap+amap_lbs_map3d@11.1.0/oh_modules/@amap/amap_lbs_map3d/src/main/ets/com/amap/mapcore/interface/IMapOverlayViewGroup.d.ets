// @keepTs
// @ts-nocheck
import { BasePointOverlay } from '../../api/model/BasePointOverlay';
import { CameraPosition } from '../../api/model/CameraPosition';
import { Point } from '../../api/model/Point';
import { v166 } from '../widget/BlankView';
import { w166 } from '../widget/CompassView';
import { p60 } from '../widget/InfoWindowDelegate';
import { x166 } from '../widget/LocationView';
import { y166 } from '../widget/ScaleView';
import { b73 } from '../widget/WaterMarkerView';
import drawing from "@ohos.graphics.drawing";
import { IndoorFloorSwitchAdapter } from '../../api/model/IndoorFloorSwitchAdapter';
export interface r72 {
    l92(isIndoorSwitchEnabled: boolean): void;
    y97(indoorFloorSwitchAdapter: IndoorFloorSwitchAdapter): void;
    k92(isZoomEnabled: boolean): void;
    m92(isMyLocationButtonEnabled: boolean): void;
    n92(isCompassEnabled: boolean): void;
    o92(isScaleEnabled: boolean): void;
    p93(isLogoEnabled: boolean): void;
    /**
     * 修改logo样式
     * @param path 图片地址
     * @param enable 是否开启
     * @param type 白天还是黑夜
     */
    z166(path: string, enable: boolean, type: number): void;
    a167(zoom: number): void;
    setZoomPosition(position: number): void;
    setLogoPosition(position: number): void;
    setLogoBottomMargin(iPixels: number): void;
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
    g167(): void;
    h167(logoEnable: boolean): void;
    i167(infoWindowAdapterManager: p60): void;
    showInfoWindow(marker: BasePointOverlay): void;
    redrawInfoWindow(): void;
    hideInfoWindow(): void;
    isInfoWindowShown(): boolean;
    destroy(): void;
    p91(canvas: drawing.Canvas): void;
    clear(): void;
    j167(): void;
    k167(showSelect: boolean): void;
    g97(visible: boolean): void;
    l110(visible: boolean): void;
    l167(): void;
}
