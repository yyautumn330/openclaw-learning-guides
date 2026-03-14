// @keepTs
// @ts-nocheck
import { IRequest } from '@amap/amap_lbs_common';
/**
 * @author zxy
 * @data 2020/11/24
 */
export declare class g126 implements IRequest {
    url: string;
    m17: Boolean;
    constructor(context: Context, m126: string);
    protected loadData(result: Int8Array): h126;
    protected n126(l126: string | null): h126;
    o126(): Map<string, string>;
    /**
     * 获取请求参数
     *
     * @return 返回请求参数
     */
    protected j103(): string;
    getParams(): Map<string, string>;
    p126(): string;
    q126(): string;
    r126(): boolean;
}
export declare class h126 {
    data: Int8Array;
    version: string;
    errorCode: number;
    errorMessage: string;
}
