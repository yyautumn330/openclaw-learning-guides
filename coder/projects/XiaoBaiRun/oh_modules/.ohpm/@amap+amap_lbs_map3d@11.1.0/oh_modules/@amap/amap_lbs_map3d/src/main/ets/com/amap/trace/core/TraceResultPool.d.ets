// @keepTs
// @ts-nocheck
import ArrayList from "@ohos.util.ArrayList";
import HashMap from "@ohos.util.HashMap";
import { LatLng } from "../../api/model/LatLng";
import { y200 } from "./TraceHandler";
/**
 * 轨迹纠偏结果集
 * @author xudong.tang
 */
export declare class b285 {
    private q291?;
    private static instance?;
    constructor();
    /**
     * 获取结果集
     * @return
     */
    static getInstance(): b285;
    /**
     * 添加片段结果
     * @param lineKey
     * @param index
     * @param segments
     */
    r288(p291: string, index: number, segments: ArrayList<LatLng>): void;
    /**
     * 删除某个片段
     * @param lineKey
     * @param index
     */
    s291(o291: string, index: number): void;
    /**
     * 根据lineKey初始化存储区域
     * @param lineKey
     */
    h286(l291: string, m291: number, steps: number, n291: number): void;
    /**
     * 根据lineKey删除这个Trace
     * @param lineKey
     */
    t291(k291: string): void;
    /**
     * 根据lineKey获取Trace
     * @param lineKey
     * @return
     */
    s288(j291: string): a291 | undefined;
    /**
     * 失败的时候通知回调
     * @param handler
     * @param lineID
     * @param errorInfo
     */
    g286(handler: y200, i291: number, errorInfo: string): void;
}
/**
 * 存放TraceSegments
 */
declare class a291 {
    private u291;
    private b286;
    private index;
    private v291;
    private w291;
    private x291?;
    private y291;
    constructor(g291: number, steps: number, h291: number, segments: HashMap<number, ArrayList<LatLng>>);
    z291(): number;
    r291(): HashMap<number, ArrayList<LatLng>> | undefined;
    /**
     * 每次下载成功触发回调
     * @param handler
     */
    t288(handler: y200): void;
    private a292;
    private b292;
}
export {};
