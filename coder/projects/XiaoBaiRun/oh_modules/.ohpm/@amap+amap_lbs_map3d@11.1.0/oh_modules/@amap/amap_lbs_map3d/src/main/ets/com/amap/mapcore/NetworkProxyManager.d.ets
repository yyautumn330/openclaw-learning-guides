// @keepTs
// @ts-nocheck
import { s167 } from './interface/INetworkProxyManager';
import { i180 } from './NetworkProxy';
import { s60 } from './interface/IGLMapEngine';
import { p66 } from './interface/IAMapNativeDelegate';
export declare class NetworkProxyManager implements s167 {
    private static readonly TAG;
    private static sInstance;
    private context;
    private e181;
    /**
     * 请求任务管理
     */
    private f181;
    private g181;
    private h181;
    private userAgent;
    private l2?;
    private i181;
    private j181;
    static getInstance(): NetworkProxyManager;
    private constructor();
    init(): void;
    b153(): boolean;
    destroy(): void;
    c153(context: Context): void;
    k181(): i180 | undefined;
    l181(proxy: i180 | undefined): void;
    n181(proxy: i180 | undefined): void;
    u175(): boolean;
    getUserAgent(): string;
    private m181;
    /**
     * 清除网络状态监听
     * 包含广播处理，建议放在主线程
     */
    private o181;
    d153(z180: bigint, a181: s60, b181: p66): void;
    /**
     * 取消所有下载任务，清空下载任务管理
     */
    private p181;
    h153(w180: bigint): void;
    r94(): boolean;
    d89(v180: boolean): void;
    d175(): boolean;
    m153(u180: boolean): void;
    requireMapDataAsyn(m180: number, n180: ArrayBuffer): number;
    h175(handler: bigint, l180: Uint8Array, len: number): void;
    i175(handler: bigint): void;
    s181(handler: bigint, code: number): void;
    l175(handler: bigint, code: number): void;
    c175(handler: bigint, code: number, k180: number): void;
}
