// @keepTs
// @ts-nocheck
import http from '@ohos.net.http';
export interface IResponse extends http.HttpResponse {
    message?: string;
    commonResponseResult?: p46;
}
export interface p46 {
    status?: string;
    info?: string;
    infocode?: string;
}
