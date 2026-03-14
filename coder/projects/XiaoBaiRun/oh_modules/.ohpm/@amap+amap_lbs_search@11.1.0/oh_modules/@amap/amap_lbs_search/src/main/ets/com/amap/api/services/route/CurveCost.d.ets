// @keepTs
// @ts-nocheck
/**
 * 弯道消耗权值
 *
 * @exclude javadoc中不包含
 */
export declare class u71 {
    /**
     * 弯道速度上升导致的消耗系数，解释同TRANS_ACCESS
     */
    private access;
    /**
     * 弯道速度下降导致的消耗系数，解释同TRANS_DECESS
     */
    private value;
    /**
     * 获取弯道速度上升导致的消耗系数，解释同TRANS_ACCESS
     *
     * @return 弯道速度上升导致的消耗系数，解释同TRANS_ACCESS
     * @exclude javadoc中不包含
     */
    v71(): number;
    /**
     * 设置弯道速度上升导致的消耗系数，解释同TRANS_ACCESS
     *
     * @param access 弯道速度上升导致的消耗系数，解释同TRANS_ACCESS
     * @exclude javadoc中不包含
     */
    w71(access: number): void;
    /**
     * 获取弯道速度下降导致的消耗系数，解释同TRANS_DECESS
     *
     * @return 弯道速度下降导致的消耗系数，解释同TRANS_DECESS
     * @exclude javadoc中不包含
     */
    getValue(): number;
    /**
     * 设置弯道速度下降导致的消耗系数，解释同TRANS_DECESS
     *
     * @param value 弯道速度下降导致的消耗系数，解释同TRANS_DECESS
     * @exclude javadoc中不包含
     */
    setValue(value: number): void;
}
