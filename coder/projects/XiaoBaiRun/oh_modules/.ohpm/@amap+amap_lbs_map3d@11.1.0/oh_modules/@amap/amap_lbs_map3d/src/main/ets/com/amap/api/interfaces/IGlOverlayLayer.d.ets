// @keepTs
// @ts-nocheck
import { BaseOptions } from '../model/BaseOptions';
import { BaseOverlay } from '../model/BaseOverlay';
import { LatLng } from '../model/LatLng';
export interface a8 {
    updateOption(overlayName: string, options: BaseOptions): void;
    removeOverlay(id: string): boolean;
    b8(overlayName: string, overlay: BaseOverlay, options: BaseOptions): BaseOverlay;
    /**
     * 获取Native层属性，比如热力图根据中心点获取经纬度信息
     * @param overlayName overlay唯一标识
     * @param args 参数各自overlay具体实现，上层和下沉保持一致
     * @return
     */
    c8(overlayName: string, functionName: string, args: object[]): object;
    draw(renderOrder: number, mapTextZIndex: number, useDefaultSort: boolean): boolean;
    d8(event: LatLng, overlayType: number): BaseOverlay;
    e8(type: string): string;
    f8(): void;
    destroy(): void;
    clear(keepOverlayNames: string[]): void;
    showInfoWindow(overlayName: string): void;
    hideInfoWindow(overlayName: string): void;
    g8(overlayName: string): boolean;
    h8(overlayName: string): void;
}
