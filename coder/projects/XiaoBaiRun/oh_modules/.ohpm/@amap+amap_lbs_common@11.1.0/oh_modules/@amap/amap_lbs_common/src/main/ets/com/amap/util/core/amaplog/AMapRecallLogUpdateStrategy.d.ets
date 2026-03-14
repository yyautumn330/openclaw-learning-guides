// @keepTs
// @ts-nocheck
import { j17 } from '../statistics/UpdateStrategy';
/**
 * 错误日志的数据处理策略，采用和 exception 同样的处理策略
 */
export declare class a15 extends j17 {
    protected o17: number;
    protected p17: number;
    private q17;
    private isForce;
    private r17;
    /**
     * 当日最大上限为10MB
     */
    private static readonly s17;
    private t17;
    /**
     * 构造函数
     *
     * @param isUploadable - 是否允许上传
     * @param interval - 上传时间间隔（毫秒）
     * @param strategy - 父类更新策略对象
     * @param uploadedSize - 已上传内容大小（字节）
     * @param dailyMaxSize - 单日最大上传量限制（字节），默认为 10MB
     */
    constructor(m17: boolean, interval: number, strategy: j17, uploadedSize: number, n17: number);
    /**
     * 获取单次读取的最大数据量
     * 最大320KB
     *
     * @returns 单次最大读取字节数
     */
    u17(): number;
    /**
     * 设置是否强制上传
     *
     * @param force - true 表示强制上传
     */
    q16(force: boolean): void;
    /**
     * 更新已经上传的大小
     *
     * @param uploadContentSize - 本次上传的内容大小（字节）
     */
    v17(l17: number): void;
    /**
     * 获取当前已经上传的大小
     *
     * @returns 已上传内容总大小（字节）
     */
    w17(): number;
    /**
     * 判断是否满足更新/上传条件
     *
     * @returns true 表示可以执行上传操作
     */
    protected x17(): boolean;
}
