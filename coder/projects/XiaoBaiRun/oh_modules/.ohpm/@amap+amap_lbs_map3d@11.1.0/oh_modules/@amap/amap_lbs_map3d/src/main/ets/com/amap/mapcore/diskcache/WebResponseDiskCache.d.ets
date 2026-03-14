// @keepTs
// @ts-nocheck
import { z48 } from '../AMapCallback';
import { i60 } from '../platform/IResourceManager';
import { s121 } from './CacheDiskUtils';
import { y125 } from './IWebResponseDiskCache';
export declare class w125 implements y125 {
    private static readonly u127;
    private static readonly v127;
    private static readonly w127;
    private static readonly x127;
    private static readonly y127;
    private static readonly z127;
    private static readonly a128;
    private static readonly b128;
    private static readonly c128;
    /**
     * 是否使用磁盘缓存
     */
    private d128;
    private e128;
    private f128;
    private g128;
    private h128;
    private i128;
    private j128?;
    private mContext;
    private t56;
    k128: s121 | undefined;
    l128: s121 | undefined;
    constructor(context: Context, resourceManager: i60, s127: string, cacheSize: number, t127: number);
    private m128;
    private n128;
    /**
     * 从数据缓存中获取
     */
    c126(url: string): WebResourceResponse | null;
    /**
     *从asset或者离线资源缓存中取
     * @param url 请求url
     * @param path url中?后的path
     * @param mimeType mimetype
     * @param encoding  encoding
     * @return
     */
    d126(url: string, path: string, mimeType: string, encoding: string): WebResourceResponse | null;
    /**
     * 根据版本号对比，是从assets中获取还是从资源文件缓存中获取
     * @return
     */
    private p128;
    /**
     * 读取缓存文件版本号
     */
    private s128;
    /**
     * 读取assets文件版本号
     */
    private r128;
    private q128;
    private o128;
    /**
     * 保存到磁盘缓存
     * @param url
     * @return
     */
    e126(url: string, c127: string, encoding: string, data: ArrayBuffer): string;
    private y128;
    private z128;
    f126(version: string, url: string, reason: number, v126: z48<boolean>): void;
    onDestroy(): void;
}
