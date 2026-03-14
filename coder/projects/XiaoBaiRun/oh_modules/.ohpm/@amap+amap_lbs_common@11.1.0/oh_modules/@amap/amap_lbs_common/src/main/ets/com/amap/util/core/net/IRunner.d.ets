// @keepTs
// @ts-nocheck
import HashMap from '@ohos.util.HashMap';
import { IRequest } from './IRequest';
export interface d39 {
    s36(body: Uint8Array, postParams: HashMap<string, string> | null): IRequest;
    t36(context: Context, result: string | Object | ArrayBuffer | undefined): string;
    q36(): Promise<HashMap<string, string> | null>;
    r36(tid: string, imei: string, mac: string, imsi: string): Promise<string>;
}
