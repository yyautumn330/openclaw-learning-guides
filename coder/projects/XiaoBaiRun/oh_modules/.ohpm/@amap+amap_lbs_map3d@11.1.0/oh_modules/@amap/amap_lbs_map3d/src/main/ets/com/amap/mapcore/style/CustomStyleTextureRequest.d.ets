// @keepTs
// @ts-nocheck
import { x102 } from "../../trace/core/AbstractBasicHandler";
import HashMap from "@ohos.util.HashMap";
/**
 * 在线获取自定义样式纹理zip
 * @author zxy
 */
export declare class s216 extends x102<string, t216> {
    constructor(context: Context, z216: string);
    x96(y216: string): void;
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
    protected k103(x216: string): Promise<t216 | undefined>;
    protected r215(w216: Uint8Array): Promise<t216 | undefined>;
    protected getUri(): string;
    m103(): HashMap<string, string>;
}
export declare class t216 {
    data?: Uint8Array;
    errorCode: number;
    errorMessage: string;
}
