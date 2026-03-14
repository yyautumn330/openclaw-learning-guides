// @keepTs
// @ts-nocheck
import { z48 } from '../AMapCallback';
import { h126 } from './UpdateJsFileRequest';
export declare class s126 {
    private static readonly TAG;
    private readonly version;
    private mContext;
    /**
     * 在线获取内容
     */
    private request;
    private listener;
    static readonly p57: number;
    static readonly o57: number;
    static readonly q57: number;
    private t126;
    constructor(context: Context, listener: z48<h126>, url: string, version: string);
    run(): void;
    interrupt(): void;
    start(): void;
}
