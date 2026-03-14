// @keepTs
// @ts-nocheck
import { AMapAppResourceItem } from './AMapAppResourceItem';
import { u167 } from './interface/IResourceCallback';
export declare class ResourceCallback implements u167 {
    instance: bigint;
    constructor(instance: bigint);
    callSuccess(item: AMapAppResourceItem): void;
    callFailed(message: string): void;
    callCancel(): void;
}
