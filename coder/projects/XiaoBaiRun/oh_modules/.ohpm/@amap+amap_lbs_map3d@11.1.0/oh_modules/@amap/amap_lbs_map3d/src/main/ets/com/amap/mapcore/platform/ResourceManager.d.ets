// @keepTs
// @ts-nocheck
import ArrayList from '@ohos.util.ArrayList';
import { BitmapDescriptor } from '../../api/model/BitmapDescriptor';
import { i60, h211 } from './IResourceManager';
/**
 * 资源加载管理
 */
export declare class ResourceManager implements i60 {
    private c212;
    private static readonly TAG;
    private readonly d212;
    private readonly e212;
    private readonly mContext;
    private f212;
    constructor(context: Context);
    j162(b212: BitmapDescriptor): void;
    l211(icons: ArrayList<BitmapDescriptor>): void;
    k162(tag: string): void;
    v128(tag: string, path: string, mimeType: string, encoding: string): h211 | null;
    private g212;
    private o212;
    /**
     * 1、从本地缓存文件中找
     * 2、从bundle(assets)中找
     * @param tag
     * @return
     */
    u128(tag: string): h211 | null;
    private j212;
    private i212;
    /**
     * 从url中解析path
     * @param tagTemp
     * @return
     */
    private k212;
    private l212;
    private m212;
    private n212;
    private h212;
}
