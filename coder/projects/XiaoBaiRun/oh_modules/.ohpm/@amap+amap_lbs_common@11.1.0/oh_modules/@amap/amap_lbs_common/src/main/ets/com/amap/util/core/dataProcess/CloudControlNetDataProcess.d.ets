// @keepTs
// @ts-nocheck
import { IRequest } from '../net/IRequest';
import { h31 } from './INetDataProcess';
/**
 * 网络请求云控相关数据处理
 */
export declare class s32 implements h31 {
    private b33;
    j31(request: IRequest): IRequest;
    /**
     * 检测业务请求header中是否携带云控相关信息
     *
     * @param 网络请求
     * @return 处理后的请求
     * @since 1.0.0
    */
    c33(request: IRequest): IRequest;
}
