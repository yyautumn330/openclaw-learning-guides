// @keepTs
// @ts-nocheck
/**
 *
 */
import { Context } from '@ohos.abilityAccessCtrl';
import { BasePointOverlay } from '../../api/model/BasePointOverlay';
import { IAMap } from '../interface/IAMap';
import { d16 } from '../interface/IGLOverlayLayer';
import { d12 } from '../interface/bridge/IMapViewBridge';
import { n60 } from './IInfoWindow';
import { o60 } from './IInfoWindowAction';
import { a60 } from '../AmapDelegateListenerManager';
export declare class q60 implements o60 {
    private g102;
    private z275;
    private mapViewBridge;
    private b162?;
    private mContext;
    private a276?;
    private b276;
    private c276;
    private d276;
    private e276;
    private f276;
    constructor(context: Context, map: IAMap, w275: d16, x275: d12, y275: a60);
    i167(v275: n60): void;
    g167(): void;
    showInfoWindow(marker: BasePointOverlay): void;
    private g276;
    private h276;
    private i276;
    private j276;
    /**
     * infoWindow刷新
     */
    redrawInfoWindow(): void;
    /**
     * 将InfoWindow添加到ViewGroup
     * 在创建InfoWindowContainer的时候需要添加一次
     *
     * @param offsetX
     * @param offsetY
     * @throws RemoteException
     */
    hideInfoWindow(): void;
    isInfoWindowShown(): boolean;
    destroy(): void;
    o97(e: GestureEvent): boolean;
}
