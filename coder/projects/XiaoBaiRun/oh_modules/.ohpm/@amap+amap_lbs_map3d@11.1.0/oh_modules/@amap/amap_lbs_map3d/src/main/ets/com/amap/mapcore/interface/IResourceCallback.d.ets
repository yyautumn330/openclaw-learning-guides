// @keepTs
// @ts-nocheck
import { AMapAppResourceItem } from '../AMapAppResourceItem';
export interface u167 {
    callSuccess(item: AMapAppResourceItem): void;
    callFailed(message: string): void;
    callCancel(): void;
}
