// @keepTs
// @ts-nocheck
import { z48 } from '../AMapCallback';
export interface g60 {
    t110(request: WebResourceRequest): WebResourceResponse | null;
    y65(version: string, url: string, reason: number, updateListener: z48<boolean>): void;
}
