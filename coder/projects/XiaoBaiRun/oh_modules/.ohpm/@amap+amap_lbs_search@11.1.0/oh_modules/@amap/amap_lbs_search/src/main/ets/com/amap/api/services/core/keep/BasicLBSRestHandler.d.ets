// @keepTs
// @ts-nocheck
import { f5 } from "./BasicHandler";
/**
 * ProtocalHandler
 *
 * <p>
 * 用于调用lbs rest服务的基础类，自动补全加入ts scode xinfo等相关逻辑
 *
 * @author
 * @version 1.0 2010.01.22<br>
 *
 */
export declare abstract class b7<T, V> extends f5<T, V> {
    constructor(context: Context, task?: T);
    protected abstract m6(): string;
    protected abstract n6(l7: string): V | undefined;
    t6(): Uint8Array | undefined;
    getParams(): Map<any, any>;
    u6(): Map<string, string>;
    m7(str: string): string;
    protected w6(): V | undefined;
    protected q7(src: string): string;
    protected p7(src: string): string;
}
