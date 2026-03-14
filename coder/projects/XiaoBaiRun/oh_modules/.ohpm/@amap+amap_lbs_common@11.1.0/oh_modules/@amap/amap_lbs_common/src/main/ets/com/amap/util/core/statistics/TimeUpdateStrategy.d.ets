// @keepTs
// @ts-nocheck
import { j17 } from './UpdateStrategy';
/**
 * 对应 Java: com.amap.apis.utils.core.statistics.updatestrategy.TimeUpdateStrategy
 *
 * 功能：
 * - 基于时间间隔判断是否允许上传
 * - 支持链式策略组合（如：时间到 + 文件数达标）
 */
export declare class z65 extends j17 {
    private readonly y67;
    private readonly z67;
    private v27;
    private readonly preferences;
    private readonly q64;
    /**
     * 统一构造函数：支持两种调用方式
     *
     * new TimeUpdateStrategy(context, interval, key)
     * TimeUpdateStrategy.create(context, interval, key, strategy)
     */
    constructor(context: Context, v67: number, w67: string, x67?: j17);
    /**
     * 静态工厂：创建带链式策略的实例（与 Android 对齐）
     */
    static create(context: Context, s67: number, t67: string, u67?: j17): z65;
    /**
     * 从持久化存储加载上次更新时间
     */
    private a68;
    /**
     * 保存当前时间为最后更新时间
     */
    private b68;
    /**
     * 核心逻辑：是否满足时间间隔？
     */
    protected x17(): boolean;
    /**
     * 重写 isUpdate()：组合自身 + 上游策略
     */
    y58(): boolean;
    /**
     * 回调通知：上传成功后更新时间戳
     */
    z58(flag: boolean): void;
    /**
     * 获取单次最大读取大小（透传给上游策略）
     */
    u17(): number;
    /**
     * 进度回调透传
     */
    a59(q67: number): void;
    /**
     * 【调试】获取当前时间戳
     */
    c68(): number;
    /**
     * 【调试】手动重置时间
     */
    d68(): void;
}
