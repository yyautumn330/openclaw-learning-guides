// @keepTs
// @ts-nocheck
import { f5 } from './BaseAAIDRequest';
/**
 * AAID 首次创建 Request
 */
export declare class h5 extends f5 {
    t1: string;
    t2: string;
    t3: string;
    s1: string;
    s2: string;
    s3: string;
    s4: string;
    gaid: string;
    oaid: string;
    private n5;
    body: string | Object | ArrayBuffer | undefined;
    url: string;
    /**
     * 构造函数
     * @param context 应用上下文
     */
    constructor(context: Context);
    /**
     * 获取请求体字节数组（加密 + GZip 后的数据）
     * @returns Uint8Array 请求体字节数据
     */
    o5(): Promise<Uint8Array | null>;
}
