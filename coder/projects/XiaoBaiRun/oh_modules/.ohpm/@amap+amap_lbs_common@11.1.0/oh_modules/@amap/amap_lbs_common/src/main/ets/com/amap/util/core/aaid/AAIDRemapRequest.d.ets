// @keepTs
// @ts-nocheck
import { f5 } from './BaseAAIDRequest';
import common from "@ohos.app.ability.common";
export declare class c8 extends f5 {
    t1: string;
    t2: string;
    t3: string;
    s1: string;
    s2: string;
    s3: string;
    s4: string;
    gaid: string;
    oaid: string;
    url: string;
    body: string | Object | ArrayBuffer | undefined;
    private n5;
    constructor(context: common.UIAbilityContext);
    /**
     * 获取请求体字节数组（经过 GZip 压缩 + XOR 加密）
     * 若已缓存，则直接返回；否则构建 JSON 并加密
     */
    o5(): Promise<Uint8Array>;
}
