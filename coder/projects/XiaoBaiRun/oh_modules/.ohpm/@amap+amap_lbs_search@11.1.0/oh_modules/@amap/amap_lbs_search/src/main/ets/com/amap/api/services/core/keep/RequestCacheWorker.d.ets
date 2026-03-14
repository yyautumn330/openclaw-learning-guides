// @keepTs
// @ts-nocheck
import HashMap from "@ohos.util.HashMap";
import { d48, e5, c48 } from "./RequestCacheControl";
/**
 * 请求缓存
 * @author zxy
 * @data 2020/9/14
 */
export declare class b48 {
    private enable;
    private p48;
    private q48;
    /**
     * 上一次清空缓存的时候，默认是初始化的时间
     */
    private j49;
    /**
     * 结果列表缓存
     */
    private readonly k49;
    private readonly l49;
    /**
     * 需要缓存的 请求路径
     */
    private m49;
    constructor(pathList: Array<string>);
    private init;
    protected n49(map: HashMap<e5, object | undefined>, i49: e5): boolean;
    protected o49(map: HashMap<e5, object | undefined>, h49: e5): object | undefined;
    protected p49(map: HashMap<e5, object | undefined>, g49: e5): object | undefined;
    /**
     * 如果相同参数的请求正在请求过程中，会等待请求结果回来一起回调。
     * @return
     */
    z6(key: e5): c48 | undefined;
    a7(url: e5, result: object): void;
    /**
     * 检查是否需要删除缓存
     */
    private r49;
    /**
     * 如果超过最大值了，会移除第一个
     */
    private s49;
    /**
     * 如果超过时间了会清除所有内容，时间根据初始化的时间来定
     * 如果超过缓存时间，则全部清空
     * 并重置上次清空时间
     */
    private q49;
    y6(b49: e5): boolean;
    z48(item: d48): void;
}
