// @keepTs
// @ts-nocheck
import { IResponse } from "@amap/amap_lbs_common";
import { Context as Context } from "@ohos.abilityAccessCtrl";
import HashMap from "@ohos.util.HashMap";
export declare abstract class z193 {
    protected m17: boolean;
    mContext: Context;
    constructor(context: Context);
    /**
     * 发起网络请求
     * @return 返回请求数据
     * @throws AMapCoreException
     */
    protected f230(): Promise<IResponse | undefined>;
    /**
     * 发起网络请求, BaseTileProvider使用， utilcore 内部做了interrupted 的处理
     * @return 返回请求数据
     * @throws AMapCoreException
     */
    j17(): Promise<Uint8Array | undefined>;
    o126(): Map<string, string>;
    private m229;
    v101(p229: HashMap<string, string>): string[];
    g175(): Uint8Array | undefined;
    getParams(): HashMap<string, string> | undefined;
    protected abstract getUri(): string;
}
