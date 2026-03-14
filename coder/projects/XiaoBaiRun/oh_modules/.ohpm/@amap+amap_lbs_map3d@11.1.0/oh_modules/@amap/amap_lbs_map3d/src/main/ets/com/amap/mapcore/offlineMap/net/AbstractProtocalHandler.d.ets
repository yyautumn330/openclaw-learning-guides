// @keepTs
// @ts-nocheck
/**
 * AbstractProtocalHandler
 *
 * <p>
 * Base class with code to manage the network connecting
 *
 * @author
 * @version 1.0 2010.01.22<br>
 *
 */
export declare abstract class p199<T, V> {
    protected task?: T;
    protected v199: number;
    protected mContext?: Context;
    constructor(context: Context, u199: T);
    private w199;
    /**
     * 解析json对象
     * @param jsonStr  json串
     * @throws AMapException amap包含的异常
     * @return 解析后的对象
     */
    protected abstract n126(s199: string): V | undefined;
    getData(): V | undefined;
    /**
     * 使用AuthConfigManager获取网络数据，主要是获取网络配置文件
     * @return
     * @throws AMapException
     */
    protected x199(): V | undefined;
    /**
     * 由子类判断获取configEntity中的哪个属性
     * @param configEntity
     * @return
     */
    protected abstract y199(q199: string): string;
    /**
     *  请求时传递的云控参数
     * @return 请求时传递的云控参数
     */
    protected abstract z199(): string;
    /**
     * 请求时传递的参数 如版本号等 普通参数
     * @return 请求时传递的参数
     */
    protected abstract a200(): Map<String, String>;
}
