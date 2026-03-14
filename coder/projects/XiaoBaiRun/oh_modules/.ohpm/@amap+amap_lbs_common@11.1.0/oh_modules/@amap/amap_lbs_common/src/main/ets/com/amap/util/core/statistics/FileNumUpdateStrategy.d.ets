// @keepTs
// @ts-nocheck
import { j17 } from './UpdateStrategy';
/**
 * 对应 Java: com.amap.apis.utils.core.statistics.updatestrategy.FileNumUpdateStrategy
 *
 * 功能：当日志文件数量 ≥ 阈值时才允许上传
 * 限制：仅修改本文件、不改父类、不用 any、不使用 assign 或字面量
 */
export declare class h58 extends j17 {
    private readonly s58;
    private readonly t58;
    private readonly u58;
    /**
     * 构造函数私有化，通过静态工厂创建实例
     */
    private constructor();
    /**
     * 工厂方法1：无上游策略
     */
    static v58(n58: string, o58: number): h58;
    /**
     * 工厂方法2：带上游策略
     */
    static w58(k58: string, l58: number, m58?: j17): h58;
    /**
     * 核心逻辑：检查目录下文件数是否达标
     */
    protected x17(): boolean;
    /**
     * 同步获取目录中文件数量
     */
    private x58;
    /**
     * 重写 isUpdate()：组合自身判断 + 上游策略
     */
    y58(): boolean;
    /**
     * 回调标记透传
     */
    z58(flag: boolean): void;
    /**
     * 获取单次最大读取大小
     */
    u17(): number;
    /**
     * 进度回调透传
     */
    a59(i58: number): void;
}
