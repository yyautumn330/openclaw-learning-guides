// @keepTs
// @ts-nocheck
import ArrayList from "@ohos.util.ArrayList";
import HashMap from "@ohos.util.HashMap";
import { IRequest, IResponse, NetManager } from "@amap/amap_lbs_common";
export declare abstract class x102<T, V> {
    protected task: T;
    protected v199: number;
    protected mContext: Context;
    private static readonly u283;
    protected url: string;
    protected p215: boolean;
    protected m17: boolean;
    private v283?;
    protected protocol: number;
    protected isREST: boolean;
    constructor(context: Context, t283: T);
    /**
     * 获取请求参数
     * @return 返回请求参数
     */
    protected abstract j103(): string;
    protected loadData(s283: string): Promise<V | undefined>;
    protected r215(result: Uint8Array): Promise<V | undefined>;
    /**
     * 解析返回值的的json数据
     * @param jsonStr json串
     * @return 执行的类型
     * @throws AMapException amap定义的异常
     */
    protected abstract k103(q283: string): Promise<V | undefined>;
    getData(): Promise<V | undefined>;
    protected abstract getUri(): string;
    g175(): Promise<Uint8Array | undefined>;
    p126(): Promise<string>;
    private x101;
    private m229;
    private x199;
    private y283;
    private s101;
    o126(): Promise<Map<string, string>>;
    protected x283(protocol: number, b283: NetManager, request: IRequest): Promise<IResponse> | undefined;
    abstract m103(): HashMap<string, string>;
    getParams(): HashMap<string, string>;
    v101(s282: HashMap<string, string>): string[];
}
export declare class r282 {
    z283?: Uint8Array;
    headersMap: Map<string, ArrayList<string>>;
    a284: string;
    b284: number;
    gsid: string;
    c284: boolean;
    d284: boolean;
}
