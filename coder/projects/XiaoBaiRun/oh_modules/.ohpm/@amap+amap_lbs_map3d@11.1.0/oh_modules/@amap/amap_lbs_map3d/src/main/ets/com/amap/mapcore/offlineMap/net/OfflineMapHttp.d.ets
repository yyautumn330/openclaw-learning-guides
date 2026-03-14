// @keepTs
// @ts-nocheck
import http from "@ohos.net.http";
import { a193 } from '../DownloadListener';
export declare class j200 {
    private url;
    extraData?: Object;
    options: http.HttpRequestOptions;
    private totalSize;
    private l200;
    private m200;
    private listener?;
    n200: http.HttpRequest;
    constructor();
    setUrl(url: string): void;
    o189(pos: number): void;
    o200(method: string): void;
    p200(extraData: Object): void;
    setOptions(option: Object): void;
    q200(list: number[], flag: number): number[];
    setParameter(keys: string[], values: string[]): void;
    r200(listener: a193): void;
    stop(): void;
    request(): Promise<void>;
}
