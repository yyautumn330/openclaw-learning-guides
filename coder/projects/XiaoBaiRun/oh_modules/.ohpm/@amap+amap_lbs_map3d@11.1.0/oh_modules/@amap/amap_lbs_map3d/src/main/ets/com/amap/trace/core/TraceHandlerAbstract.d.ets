// @keepTs
// @ts-nocheck
import { e284 } from "./AbstractBasicLbsRestHandler";
import ArrayList from "@ohos.util.ArrayList";
import HashMap from "@ohos.util.HashMap";
import { TraceLocation } from "../TraceLocation";
import { LatLng } from "../../api/model/LatLng";
import { y200 } from "./TraceHandler";
export declare class d285 extends e284<ArrayList<TraceLocation>, ArrayList<LatLng>> {
    private n288;
    private o288?;
    private mIndex;
    private b286;
    private p288;
    /**
     * 返回结果都会放在data下~
     */
    static readonly q288: string;
    constructor(context: Context, handler: y200, l288: ArrayList<TraceLocation>, type: number, key: string, m288: number, index: number);
    /**
     * 获取请求参数
     * @return 返回请求参数
     */
    protected j103(): string;
    /**
     * 解析返回值的的json数据
     * @param jsonStr json串
     * @return 执行的类型
     * @throws AMapException amap定义的异常
     */
    protected k103(y287: string): Promise<ArrayList<LatLng> | undefined>;
    protected getUri(): string;
    static w101(): string;
    m103(): HashMap<string, string>;
    run(): Promise<void>;
}
