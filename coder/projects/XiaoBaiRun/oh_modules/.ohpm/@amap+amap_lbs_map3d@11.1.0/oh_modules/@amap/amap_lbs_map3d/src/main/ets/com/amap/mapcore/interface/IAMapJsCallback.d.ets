// @keepTs
// @ts-nocheck
/**
 * 外部实现webview需要实现的方法，用来接收js到java的回调
 */
export interface z59 {
    initWorker(): void;
    /**
     * 通过此回调将js调用java的信息通知到SDK
     * 仅在 外部自定义Webview的JavascriptInterface 个android.webkit.JavascriptInterface 不一样时使用
     * @param functionName
     * @param params
     */
    nativeCall(functionName: string, params: string[]): void;
    onMapRenderComplete(): void;
    onMapLoadComplete(): void;
    onMapClick(lat: number, lng: number): void;
    onPolylineClick(overlayName: string): void;
    onMarkerClick(overlayName: string): void;
    onMarkerDragstart(overlayName: string, lat: number, lon: number): void;
    onMarkerDragging(overlayName: string, lat: number, lon: number): void;
    onMarkerDragend(overlayName: string, lat: number, lon: number): void;
    onMapChange(lat: number, lng: number, zoom: number, bearing: number, tilt: number): void;
    onMapChangeFinish(lat: number, lng: number, zoom: number, bearing: number, tilt: number): void;
    onMapBoundsChange(n_lat: number, n_lng: number, s_lat: number, s_lng: number): void;
    log(info: string): void;
}
