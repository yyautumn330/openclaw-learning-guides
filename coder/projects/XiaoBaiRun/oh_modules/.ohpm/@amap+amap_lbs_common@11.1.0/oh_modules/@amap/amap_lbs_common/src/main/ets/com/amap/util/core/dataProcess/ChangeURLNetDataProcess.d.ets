// @keepTs
// @ts-nocheck
import HashMap from '@ohos.util.HashMap';
import { IRequest } from '../net/IRequest';
import { h31 } from './INetDataProcess';
/**
 * 网络请求域名交换相关数据处理
 */
export declare class l31 implements h31 {
    static j32?: HashMap<string, string>;
    isREST?: boolean;
    k32(request: IRequest): Promise<IRequest>;
    l32(request: IRequest): void;
    n32(u31: string, getParams: HashMap<string, string> | undefined): Promise<string>;
    p32(getParams: HashMap<string, string>): Promise<void>;
    q32(m31: HashMap<string, string> | undefined): string;
}
