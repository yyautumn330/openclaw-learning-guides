// @keepTs
// @ts-nocheck
import { BaseOverlay } from '../../api/model/BaseOverlay';
import { o60 } from './IInfoWindowAction';
export interface n60 {
    w63(viewInfoWindowAction: o60): void;
    k89(popupOverlay: o60): void;
    setInfoWindowAdapter(adapter: CustomBuilder, isDefault?: boolean): void;
    o274(): CustomBuilder | undefined;
    redrawInfoWindow(): void;
    hideInfoWindow(): void;
    showInfoWindow(marker: BaseOverlay): void;
    isInfoWindowShown(): boolean;
    t97(e: GestureEvent): BaseOverlay | undefined;
    p274(): boolean;
}
