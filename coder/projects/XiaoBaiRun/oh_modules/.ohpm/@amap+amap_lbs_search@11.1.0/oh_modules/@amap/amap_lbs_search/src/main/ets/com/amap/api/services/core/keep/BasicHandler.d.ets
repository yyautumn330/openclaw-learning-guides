// @keepTs
// @ts-nocheck
import { Context as Context } from "@ohos.abilityAccessCtrl";
import { IRequest, IResponse, NetManager } from "@amap/amap_lbs_common";
import { e5 } from "./RequestCacheControl";
export declare abstract class f5<T, V> {
    protected e6: boolean;
    protected task?: T;
    protected f6: number;
    protected g6: string;
    protected mContext: Context;
    private h6;
    protected gsid: string;
    constructor(context: Context, d6?: T);
    private j6;
    /**
     * 子类必须实现此方法：返回原始请求 URL
     */
    protected abstract k6(): string;
    /**
     * 获取最终用于请求的 URL
     * - 协议升级：http → https
     * - 备用域名：useBackupHost = true 时降级
     */
    protected l6(x5?: boolean): Promise<string>;
    /**
     * 拼接请求参数（由子类实现）
     */
    protected abstract m6(): string;
    /**
     * 解析 JSON 响应数据
     */
    protected abstract n6(w5: string): V | undefined;
    /**
     * 处理响应字节流
     */
    private o6;
    private loadData;
    private r6;
    /**
     * 发起 HTTP 请求
     */
    protected s6(protocol: number, u5: NetManager, request: IRequest): Promise<IResponse> | undefined;
    /**
     * 子类可重写：获取 POST 数据体
     */
    t6(): Uint8Array | undefined;
    /**
     * 子类可重写：获取请求头
     */
    u6(): Map<string, string> | undefined;
    /**
     * 子类可重写：获取查询参数
     */
    getParams(): Map<string, string> | undefined;
    /**
     * 获取唯一缓存键（用于缓存控制）
     */
    protected v6(): e5 | undefined;
    /**
     * 异常发生时回调
     */
    protected w6(): V | undefined;
    /**
     * 主入口：发起请求并返回结果
     */
    getData(): Promise<V | undefined>;
    private x6;
}
