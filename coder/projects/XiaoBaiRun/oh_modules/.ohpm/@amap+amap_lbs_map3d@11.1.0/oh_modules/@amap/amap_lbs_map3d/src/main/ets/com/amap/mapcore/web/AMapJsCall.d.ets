// @keepTs
// @ts-nocheck
import { CameraUpdate } from '../../api/CameraUpdate';
import { LatLng } from '../../api/model/LatLng';
import { x52, m110 } from '../interface/IAMapJsCall';
import { d12 } from '../interface/bridge/IMapViewBridge';
export declare class w59 implements x52 {
    private static readonly a268;
    private static readonly b268;
    private mapViewBridge;
    private c268;
    private d268;
    private e268;
    constructor(z267: d12);
    init(): void;
    /**
     * 初始化JSMap， 需要在主线程调用
     */
    z65(): void;
    onDestroy(): void;
    k64(v267: string, w267: string): void;
    i162(t267: string, u267: string): void;
    removeOverlay(s267: string): void;
    moveCamera(o267: CameraUpdate, p267: boolean, q267: number): void;
    stopAnimation(): void;
    y58(n267: number, options: string): void;
    k166(): void;
    l166(): void;
    v37(x: number, y: number, m267: m110<string>): void;
    d92(j267: number, k267: number, l267: m110<string>): void;
    b59(type: number, i267: string): void;
    setMapStatusLimits(northeast: LatLng, southwest: LatLng): void;
    f65(g267: number, h267: number): void;
    setScrollGesturesEnabled(enabled: boolean): void;
    setRotateGesturesEnabled(enabled: boolean): void;
    setTiltGesturesEnabled(enabled: boolean): void;
    setZoomGesturesEnabled(enabled: boolean): void;
    setGestureScaleByMapCenter(isGestureScaleByMapCenter: boolean): void;
    setTrafficEnabled(enabled: boolean): void;
    g65(enabled: boolean): void;
    h65(enabled: boolean): void;
    /**
     * 将方法和参数拼接成，调用js的字符串
     * @param functionName 方法名称
     * @param args 参数
     * @return
     */
    private i268;
    private g268;
    private f268;
    /**
     * 调用js并获取返回值
     * @param functionName
     * @param args
     * @return
     */
    private h268;
    m166(): void;
}
