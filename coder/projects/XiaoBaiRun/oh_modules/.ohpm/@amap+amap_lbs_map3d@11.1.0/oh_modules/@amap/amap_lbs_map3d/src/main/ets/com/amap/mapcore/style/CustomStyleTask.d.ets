// @keepTs
// @ts-nocheck
import { IAMap } from "../interface/IAMap";
import { OnCustomMapStyleFailListener } from "../../api/AMap";
/**
 * 在线取图子线程
 */
export declare class z52 {
    private mContext?;
    private g102?;
    /** 在线获取自定义地图样式相关 */
    private request?;
    private g216;
    private h216;
    private i216;
    private static readonly j216;
    private static readonly k216;
    private listener?;
    static readonly p57 = 0;
    static readonly o57 = 1;
    static readonly q57 = 2;
    private t126;
    private l216;
    constructor(context: Context, d216: IAMap | undefined, listener: a53 | undefined, e216: number | undefined, f216: string | undefined);
    d59(c216: string): void;
    private m216?;
    c59(listener: OnCustomMapStyleFailListener): void;
    private n216;
    private o216;
    /**
     * 根据key 读取上次修改时间
     */
    private q216;
    /**
     * 根据key 保持上次修改时间
     */
    private r216;
    d203(): Promise<void>;
    interrupt(): void;
    start(): void;
    cancel(): void;
}
/**
 *下载完成之后回调
 */
export interface a53 {
    /**
     * 下载完成
     * 如果和onCacheComplete中数据相同就不会回调了
     * @param data 二进制数据
     */
    onComplete: (data: Uint8Array, requestVersionState: number) => void;
    /**
     * 缓存读取完成的回调，发起请求时会优先从缓存获取，如果缓存有值，会先返回缓存的内容
     * @param data
     * @param requestVersionState
     */
    t57: (data: Uint8Array, requestVersionState: number) => void;
}
