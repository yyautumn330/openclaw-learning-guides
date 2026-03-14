// @keepTs
// @ts-nocheck
import { z48 } from '../AMapCallback';
import { i60 } from '../platform/IResourceManager';
export declare namespace x125 {
    function z125(context: Context, resourceManager: i60, a126: string, cacheSize: number, b126: number): y125;
}
export interface y125 {
    c126(url: string): WebResourceResponse | null;
    d126(url: string, path: string, mimeType: string, encoding: string): WebResourceResponse | null;
    e126(url: string, miniType: string, encoding: string, data: ArrayBuffer): string;
    f126(version: string, url: string, reason: number, updateListener: z48<boolean>): void;
}
