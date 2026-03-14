// @keepTs
// @ts-nocheck
/**
 * 拦截请求
 */
import HashMap from '@ohos.util.HashMap';
import uri from '@ohos.uri';
import ArrayList from '@ohos.util.ArrayList';
export declare class n271 {
    private readonly i273;
    private readonly j273;
    private readonly context;
    private readonly n272;
    private k273;
    private l273;
    private m273;
    private queryParams;
    constructor(f273: uri.URI, g273: ArrayList<Header>, context: Context, h273: string);
    /**
     * 替换请求中js版本号
     * @param url
     * @return
     */
    protected n273(url: string): string;
    /**
     * 如果没有key 就添加key
     * 如果有key就替换成sdk的key
     * @param url
     * @return
     */
    private o273;
    protected replaceUrl(url: string): string;
    private p273;
    private q273;
    u272(): void;
    w272(): void;
    v272(): uri.URI;
    z272(): string;
    a273(): HashMap<string, string>;
    r273(): ArrayList<Header>;
}
