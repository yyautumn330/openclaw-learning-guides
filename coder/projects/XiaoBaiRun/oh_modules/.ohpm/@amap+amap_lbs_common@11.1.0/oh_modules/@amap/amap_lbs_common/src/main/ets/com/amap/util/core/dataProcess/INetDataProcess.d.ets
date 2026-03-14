// @keepTs
// @ts-nocheck
import { IRequest } from '../net/IRequest';
/**
 * 网络请求相关数据处理接口
 */
export interface h31 {
    j31?(request: IRequest): IRequest;
    k32?(request: IRequest): Promise<IRequest>;
}
