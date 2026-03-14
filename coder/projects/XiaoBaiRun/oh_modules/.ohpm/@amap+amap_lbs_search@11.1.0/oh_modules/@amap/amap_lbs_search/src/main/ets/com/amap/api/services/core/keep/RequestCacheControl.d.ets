// @keepTs
// @ts-nocheck
import { b48 } from "./RequestCacheWorker";
/**
 * 返回结果封装
 */
export declare class c48 {
    result: object;
    o48: boolean;
    constructor(result: object, n48: boolean);
}
export declare class e5 {
    key?: string;
    obj?: object;
    equals(l48: object): boolean;
    hashCode(): number;
}
export declare class d48 {
    private enable;
    private p48;
    private q48;
    private r48;
    isEnable(): boolean;
    s48(enable: boolean): void;
    t48(): number;
    u48(j48: number): void;
    v48(): number;
    w48(i48: number): void;
    o46(): number;
    x48(h48: number): void;
}
/**
 *
 * 目标：短时间内相同GPS的逆地理请求做结果复用，减少服务请求
 * https://aone.alibaba-inc.com/req/28431453
 * @author zxy
 * @data 2020-07-03
 */
export declare class d5 {
    private static instance;
    static getInstance(): d5;
    private workers;
    m46(key: string): b48;
    y48(key: string, worker: b48): void;
    /**
     * 如果相同参数的请求正在请求过程中，会等待请求结果回来一起回调。
     * @return
     */
    z6(f48: e5 | undefined): c48;
    a7(url: e5, result: object): void;
    /**
     * @param url
     * @return
     */
    y6(url: e5 | undefined): boolean;
    z48(e48: d48): void;
    a49(key: string, item: d48): void;
    reset(): void;
}
