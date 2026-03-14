// @keepTs
// @ts-nocheck
import { g60 } from './IAMapJsInterceptor';
import { z48 } from '../AMapCallback';
import { i60 } from '../platform/IResourceManager';
export declare class h60 implements g60 {
    /**
     * 是否使用缓存总开关
     */
    private l272;
    private m272?;
    private n272;
    private context;
    constructor(resourceManager: i60, context: Context);
    y65(version: string, url: string, reason: number, i272: z48<boolean>): void;
    t110(request: WebResourceRequest): WebResourceResponse | null;
    private o272;
    private p272;
    private q272;
    private r272;
    private y272;
    private x272;
}
