// @keepTs
// @ts-nocheck
import HashMap from '@ohos.util.HashMap';
import { IRequest } from '../net/IRequest';
import { SDKInfo } from '../SDKInfo';
export declare class k31 {
    static r32(j97: HashMap<string, string>, context: Context): Promise<HashMap<string, string>>;
    static r97(f97: HashMap<string, string>): string[];
    static t97(y96: string, timestamp: string, z96: string): Promise<string | undefined>;
    /**
     * 通过请求的User Agent查找对应的产品明
     *
     * @param request 网络请求
     * @return 获取到的产品名字，如：navi、loc
     * @since 1.0.0
     */
    static d33(request: IRequest): string | undefined;
    static u97(userAgent: string | undefined): string | undefined;
    /**
     * 获取潘多拉请求的infoStr
    */
    static h34(): string;
    /**
     * 获取平台信息
    */
    static i34(request: IRequest): string | undefined;
    /**
     * 获取云控请求的platInfo
     */
    static n76(j96: SDKInfo): string;
}
export default k31;
