// @keepTs
// @ts-nocheck
import ArrayList from '@ohos.util.ArrayList';
import { IRequest } from '../net/IRequest';
import { h31 } from './INetDataProcess';
/**
 * 网络请求XInfo相关数据处理
 */
export declare class l33 implements h31 {
    k32(request: IRequest): Promise<IRequest>;
    c34(request: IRequest): Promise<IRequest>;
    d34(request: IRequest): ArrayList<Uint8Array>;
}
