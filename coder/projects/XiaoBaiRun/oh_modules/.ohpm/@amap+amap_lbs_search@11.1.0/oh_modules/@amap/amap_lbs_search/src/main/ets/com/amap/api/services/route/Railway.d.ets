// @keepTs
// @ts-nocheck
/**
 * 列车信息
 * @since V3.4.0
 */
export declare class Railway {
    private b82?;
    private n74?;
    /**
     * Railway构造方法。
     * @since V3.4.0
     */
    constructor();
    /**
     * 返回线路id编号。
     * @return 线路id编号。
     * @since V3.4.0
     */
    getID(): string;
    /**
     * 返回线路名称。
     * @return 线路名称。
     * @since V3.4.0
     */
    getName(): string;
    /**
     * 设置线路id编号。
     * @param id 线路id编号。
     * @since V3.4.0
     * @exclude javadoc中不显示。
     */
    setID(id: string): void;
    /**
     * 设置线路名称。
     * @param name 线路名称。
     * @since V3.4.0
     * @exclude javadoc中不显示。
     */
    setName(name: string): void;
    /**
     * @exclude javadoc中不显示。
     */
    q2(): number;
}
