// @keepTs
// @ts-nocheck
import { a60 } from '../AmapDelegateListenerManager';
import { x52 } from '../interface/IAMapJsCall';
import { z59 } from '../interface/IAMapJsCallback';
import { x59 } from '../interface/IGLMapState';
import { d16 } from '../interface/IGLOverlayLayer';
import { IAMap } from '../interface/IAMap';
export declare class b60 implements z59 {
    private readonly mContext;
    private readonly g130;
    private readonly glOverlayLayer;
    private readonly o270;
    private readonly f56;
    private readonly r107;
    constructor(i270: Context, j270: a60, k270: d16, l270: x59, m270: x52, n270: IAMap);
    onMapRenderComplete(): void;
    initWorker(): void;
    onMapLoadComplete(): void;
    onMapClick(a270: number, b270: number): void;
    onPolylineClick(w269: string): void;
    onMarkerClick(s269: string): void;
    onMarkerDragstart(m269: string, n269: number, o269: number): void;
    onMarkerDragging(g269: string, h269: number, i269: number): void;
    onMarkerDragend(a269: string, b269: number, c269: number): void;
    onMapChange(w268: number, x268: number, zoom: number, bearing: number, tilt: number): void;
    onMapChangeFinish(s268: number, t268: number, zoom: number, bearing: number, tilt: number): void;
    onMapBoundsChange(o268: number, p268: number, q268: number, r268: number): void;
    private p97;
    private onMarkerDrag;
    log(info: string): void;
    /**
     * 如果是外置webview 通过@JavascriptInterface 监听不到回调，所以进行统一收口
     * 仅在 JavascriptInterface 个android.webkit.JavascriptInterface 不是同一个时使用
     * @param functionName
     * @param params 参数间隔
     */
    nativeCall(j268: string, params: string[]): void;
}
