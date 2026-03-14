// @keepTs
// @ts-nocheck
import { s60 } from './interface/IGLMapEngine';
import { CancelableCallback } from '../api/AMap';
import { LatLng } from '../api/model/LatLng';
import { Point } from '../api/model/Point';
import { InitParam, MapViewInitParam } from './AMapEngineConfig';
import { v6 } from './camera/AbstractCameraUpdateMessage';
import { x59 } from './interface/IGLMapState';
import { p72 } from './message/AbstractGestureMapMessage';
import ArrayList from '@ohos.util.ArrayList';
import { p66 } from './interface/IAMapNativeDelegate';
import { s140 } from './glanimation/OhglMapAnimationMgr';
import { v72 } from './style/StyleItem';
import { l39 } from '../api/model/MyTrafficStyle';
import { BitmapDescriptor } from '../api/model/BitmapDescriptor';
import { j73 } from './BaseMapOverlay';
import { i73 } from './GLOverlay';
import { k73 } from './GLOverlayBundle';
import { h73 } from './GLTextureProperty';
/**
 * gl渲染引擎实现
 */
export declare class u60 implements s60, s140 {
    private static readonly TAG;
    private context;
    private y151;
    private engineId;
    private z151;
    private d63?;
    private a152?;
    private b152;
    private c152;
    private d152;
    private e152;
    private f152;
    private g152;
    private h152;
    private i152;
    /**
     * 引擎是否渲染完成，没有网格表示渲染完成
     */
    private f86;
    constructor(context: Context, x151: p66);
    r96(s151: number, t151: number, u151: number, v151: boolean, w151: v72[]): boolean;
    a71(): bigint;
    getEngineId(): number;
    t94(r151: number): void;
    m95(q151: number): boolean;
    r95(j151: number, k151: number, l151: number, m151: number, n151: number, o151: number, p151: number): void;
    j152(e151: number, f151: number, g151: number, p2: number, h151: number, i151: number): void;
    k152(d151: number, stateType: number, flag: boolean): void;
    l152(c151: number, stateType: number): boolean;
    w90(y150: number, z150: string, a151: number, b151: string): void;
    u67(w150: number): x59 | undefined;
    f92(v150: number): x59 | undefined;
    m152(): x59 | undefined;
    o95(s150: number, t150: x59, u150?: boolean): void;
    o152(): void;
    k97(o150: p72, isGestureScaleByMapCenter: boolean, p150: number, q150: number): void;
    /**
     * 处理moveCamera
     *
     * @return true 表示有需要处理的，false 表示没有动画需要处理
     */
    private p152;
    /**
     * 处理手势操作
     *
     * @return true 表示有需要处理的，false 表示没有需要处理
     */
    private q152;
    /**
     * 处理Animation
     *
     * @param glMapState
     * @return true 表示有需要处理的，false 表示没有动画需要处理
     */
    private s152;
    f96(): void;
    e113(b150: number, duration: number, c150: number, d150: number, e150: number, f150: number, g150: number, h150: CancelableCallback | undefined): void;
    r91(a150: number): boolean;
    w88(): number;
    z64(): void;
    a65(): void;
    w152(s149: number, touchPoint: Point, x: number, y: number): void;
    x152(r149: number, pivot: Point, zoom: number, angle: number, time: number): void;
    private u87;
    private v87;
    x88(): number;
    v95(p149: v6, q149: boolean): void;
    w95(): v6 | undefined;
    a88(): void;
    d88(): void;
    w57(l149: number, m149: number, n149: number): boolean;
    q71(j149: number, k149: number): bigint;
    bundle: k73<i73, j73<i73, object>> | null;
    q95(i149: number, bundle: k73<i73, j73<i73, object>>): void;
    v89(h149: number): k73<i73, j73<i73, object>> | null;
    o94(g149: number, bitmap: BitmapDescriptor): number;
    j94(e149: number, f149: h73): void;
    y152(d149: number): bigint;
    n146(b149: number, c149: bigint): void;
    h95(a149: number, enable: boolean): void;
    h91(z148: number, enable: boolean): void;
    z152(y148: number, enable: boolean): void;
    setNaviLabelEnable(v148: number, enable: boolean, w148: number, x148: number): void;
    c97(t148: number, u148: boolean): void;
    i97(s148: number, enable: boolean): void;
    h97(r148: number, enable: boolean): void;
    s96(q148: number, enable: boolean): void;
    c91(n148: number, o148: number, p148: number): void;
    g95(m148: number, enabled: boolean): void;
    a153(l148: number, enabled: boolean): void;
    n97(k148: number, enabled: boolean): void;
    u37(i148: number, j148: string): void;
    k96(h148: number): void;
    u94(w147: InitParam): boolean;
    n95(t147: MapViewInitParam): void;
    n91(): void;
    t95(): void;
    g153(): void;
    getNativeMapController(r147: number): bigint;
    j95(path: string): void;
    s97(x: number, y: number): void;
    i153(q147: ArrayList<LatLng>): number;
    j153(p147: number): void;
    k153(o147: boolean): void;
    g88(n147: boolean): void;
    k91(m147: number): boolean;
    f153(): void;
    private u152;
    /**
     * 处理moveCamera操作
     *
     * @return true 表示有需要处理的，false 表示没有动画需要处理
     */
    private r152;
    /**
     * 通知渲染引擎上层view状态，用于多语言切换
     *
     * @param flags 前后台状态前台true,后台false
     */
    n96(flags: boolean): void;
    /**
     * 多语言设置区域经纬度
     *
     * @param latLng
     */
    l153(i147: LatLng): void;
    v152(h147: CancelableCallback | undefined): void;
    e141(g147: CancelableCallback | undefined): void;
    x97(f147: number, enabled: boolean): void;
    f58(d147: number, e147: Uint8Array | undefined): void;
    m58(a147: number, b147: Uint8Array | undefined, c147: Uint8Array | undefined): void;
    s58(y146: number, z146: Uint8Array): boolean;
    t58(x146: number, data: Uint8Array, style: l39): void;
    u58(v146: number, w146: Uint8Array): void;
    r59(t146: number, u146: string): void;
    l91(s146: number, x: number, y: number, width: number, height: number): PixelMap | undefined;
    q94(r146: boolean): void;
    d89(q146: boolean): void;
    p94(o146: number, p146: boolean): void;
}
