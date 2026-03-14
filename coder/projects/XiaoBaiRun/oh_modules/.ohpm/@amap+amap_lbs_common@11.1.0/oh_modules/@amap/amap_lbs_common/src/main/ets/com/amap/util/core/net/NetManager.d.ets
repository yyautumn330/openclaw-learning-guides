// @keepTs
// @ts-nocheck
import http from '@ohos.net.http';
import { l31 } from '../dataProcess/ChangeURLNetDataProcess';
import { s32 } from '../dataProcess/CloudControlNetDataProcess';
import { l33 } from '../dataProcess/PandoraNetDataProcess';
import { i47 } from '../respDataProcess/CloudControlRespNetDataProcess';
import { IRequest } from './IRequest';
import { p46, IResponse } from './IResponse';
export declare class NetManager {
    u47: l31;
    v47: s32;
    w47: l33;
    x47: i47;
    private static instance?;
    static getInstance(): NetManager;
    makeRequestGet(request: IRequest, context: Context): Promise<IResponse>;
    makeRequestPost(request: IRequest, context: Context): Promise<IResponse>;
    z47(request: IRequest, context: Context): Promise<IResponse>;
    y47(method: http.RequestMethod, request: IRequest, context: Context): Promise<IResponse>;
    b48(response: IResponse): p46 | undefined;
    private a48;
}
