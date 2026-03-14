// @keepTs
// @ts-nocheck
import HashMap from '@ohos.util.HashMap';
import { n271 } from './InjectWebResourceRequest';
export declare class m271 {
    static readonly t272 = "content-encoding";
    static readonly s272 = "content-type";
    private context;
    private u273;
    constructor(context: Context, t273: n271);
    p126(): string;
    z272(): string;
    a273(): HashMap<string, string>;
    getRequestHeader(): Map<string, string>;
}
