// @keepTs
// @ts-nocheck
import { x193 } from "./OfflineDownloadRequest";
import { j200 } from "./OfflineMapHttp";
import { a193 } from "../DownloadListener";
export declare class a194 {
    u200: x193;
    v200: number;
    w200: number;
    x200: j200;
    constructor(request: x193, startPos: number, endPos: number, t200: boolean);
    u195(): void;
    startDownload(listener: a193): void;
    /**
     * 根据 URL 获取远程文件大小（单位：字节）
     *
     * @param downloadUrl 远程文件 URL
     * @returns 文件大小（字节），失败返回 -1
     */
    static j195(s200: string): Promise<number>;
}
