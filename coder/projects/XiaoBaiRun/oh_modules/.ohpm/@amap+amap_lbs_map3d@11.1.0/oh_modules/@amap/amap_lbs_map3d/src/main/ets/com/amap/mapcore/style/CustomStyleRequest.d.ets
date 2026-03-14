// @keepTs
// @ts-nocheck
import { x102 } from "../../trace/core/AbstractBasicHandler";
import HashMap from "@ohos.util.HashMap";
/**
 * 在线取图服务
 */
export declare class u214 extends x102<string, v214> {
    static readonly j215: string;
    private k215;
    private l215;
    private lastModified;
    private readonly m215;
    private n215;
    private o215;
    /**
     * @param context
     * @param tsk
     * @param isNewVersion 新版自定义样式 下载路径不同，下载的是引擎直接支持的data文件，旧版是json
     */
    constructor(context: Context, h215: string, i215: boolean);
    q215(g215: string): void;
    protected loadData(b215: string): Promise<v214 | undefined>;
    protected r215(data: Uint8Array): Promise<v214 | undefined>;
    protected j103(): string;
    protected k103(a215: string): Promise<v214 | undefined>;
    protected getUri(): string;
    m103(): HashMap<string, string>;
    d59(x214: string): void;
    setProtocol(protocol: string): void;
    t215(w214: string): void;
}
export declare class v214 {
    data?: Uint8Array;
    errorCode: number;
    errorMessage: string;
    lastModified: string;
    s215: boolean;
}
