// @keepTs
// @ts-nocheck
import { e9 } from "./CityObject";
import { f182 } from "./TaskItem";
/**
 * 自定义任务处理框架 包含，开始，暂停，从新开始，删除任务等操作
 * @author zxy
 */
export declare class a201 {
    private static u209;
    private static readonly v209;
    /** LinkedHashMap 可以保证插入顺序*/
    private tasks;
    /**
     * 获取实例，可传入线程池数量（数量以第一次调用时传入的参数为准）
     *
     * @param threadNum 线程池的个数
     * @return
     */
    static getInstance(threadNum?: number, t209?: boolean): a201;
    private constructor();
    /**
     * 暂停所有任务
     */
    w209(): void;
    private x209;
    /**
     * 暂停指定的任务
     *
     * @param item 任务
     */
    i203(item: f182): void;
    /**
     * 开始一个下载任务
     *
     * @param item    任务
     * @param context 上下文
     * @param mAMap   地图amap对象
     * @throws AMapCoreException
     */
    e203(item: e9, context: Context): void;
    destroy(): void;
    static i107(): void;
    /**
     * 任务结束之后，需要调用这个方法，来移除下载列表中的任务
     *
     * @param item 任务
     */
    y209(item: f182): void;
    private flag;
    z209(): void;
    a210(): void;
}
