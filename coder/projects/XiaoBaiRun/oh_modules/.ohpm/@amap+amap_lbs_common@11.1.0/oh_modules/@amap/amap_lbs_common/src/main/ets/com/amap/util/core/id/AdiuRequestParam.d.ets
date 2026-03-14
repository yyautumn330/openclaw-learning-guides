// @keepTs
// @ts-nocheck
import HashMap from '@ohos.util.HashMap';
import { x35 } from './ADIURunner';
import { IRequest } from '../net/IRequest';
export declare class c37 {
    private static p38;
    private static q38;
    /**
     * parse adiu data
     * @param context
     * @param result
     * @returns
     */
    t36(context: Context, result: string): string;
    /**
     * 获取拼接的query string参数
     * @returns
     */
    q36(): Promise<HashMap<string, string> | null>;
    r38(d38: Uint8Array, data: Uint8Array): Uint8Array;
    private s38;
    private t38;
    /**
     * 获取请求body数据
     * @param tid
     * @param imei
     * @param mac
     * @param imsi
     * @returns
     */
    r36(tid: string, k37: string, mac: string, l37: string): Promise<string>;
    stringToUint8Array(str: string): Uint8Array;
    z38(): string;
}
export declare class y35 implements x35 {
    a39: c37;
    z38(): string;
    t36(context: Context, result: string | Object | ArrayBuffer | undefined): string;
    q36(): Promise<HashMap<string, string> | null>;
    s36(body: Uint8Array, g37: HashMap<string, string>): IRequest;
    r36(tid: string, e37: string, mac: string, f37: string): Promise<string>;
}
