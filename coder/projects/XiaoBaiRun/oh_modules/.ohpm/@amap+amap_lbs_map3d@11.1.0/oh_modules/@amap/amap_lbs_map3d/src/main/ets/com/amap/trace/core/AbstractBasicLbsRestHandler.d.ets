// @keepTs
// @ts-nocheck
import { x102 } from "./AbstractBasicHandler";
import HashMap from "@ohos.util.HashMap";
/**
 * AbstractProtocalHandler
 *
 * <p>
 * 用于调用lbs rest服务的基础类，自动补全加入ts scode xinfo等相关逻辑
 *
 * @author
 * @version 1.0 2010.01.22<br>
 *
 */
export declare abstract class e284<T, V> extends x102<T, V> {
    constructor(context: Context, task: T);
    /**
     * 获取请求参数
     * @return 返回请求参数
     */
    protected abstract j103(): string;
    /**
     * 解析返回值的的json数据
     * @param jsonStr json串
     * @return 执行的类型
     * @throws AMapException amap定义的异常
     */
    protected abstract k103(g284: string): Promise<V | undefined>;
    g175(): Promise<Uint8Array | undefined>;
    getParams(): HashMap<string, string>;
    o126(): Promise<Map<string, string>>;
    protected h284(): V | undefined;
    protected i284(src?: string): string | undefined;
    protected s175(src?: string): string | undefined;
}
