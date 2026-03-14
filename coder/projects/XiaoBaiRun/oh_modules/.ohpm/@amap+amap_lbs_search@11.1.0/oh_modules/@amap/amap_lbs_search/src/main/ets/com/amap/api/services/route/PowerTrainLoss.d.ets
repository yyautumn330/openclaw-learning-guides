// @keepTs
// @ts-nocheck
/**
 * PowerTrainLoss
 *
 * @exclude javadoc中不包含
 */
export declare class x71 {
    /**
     * 消耗的功率，单位kw
     */
    private v81;
    /**
     * 在此功率下额外的能耗，需要补充的能量，单位kwh
     */
    private w81;
    /**
     *
     */
    private speed;
    private x81;
    /**
     * 获取消耗的功率，单位kw
     *
     * @return 消耗的功率，单位kw
     * @exclude javadoc中不包含
     */
    r73(): number;
    /**
     * 设置消耗的功率，单位kw
     *
     * @param powerDemand 消耗的功率，单位kw
     * @exclude javadoc中不包含
     */
    y81(u81: number): void;
    /**
     * 获取在此功率下额外的能耗，需要补充的能量，单位kwh
     *
     * @return 在此功率下额外的能耗，需要补充的能量，单位kwh
     * @exclude javadoc中不包含
     */
    s73(): number;
    /**
     * 设置在此功率下额外的能耗，需要补充的能量，单位kwh
     *
     * @param powerDemandValue 在此功率下额外的能耗，需要补充的能量，单位kwh
     * @exclude javadoc中不包含
     */
    z81(t81: number): void;
    /**
     * 获取速度值，单位km/h
     *
     * @return 速度值，单位km/h
     * @exclude javadoc中不包含
     */
    getSpeed(): number;
    /**
     * 设置速度值，单位km/h
     *
     * @param speed 速度值，单位km/h
     * @exclude javadoc中不包含
     */
    setSpeed(speed: number): void;
    /**
     * 获取该速度下每行驶一公里的能耗值，单位wh/km
     *
     * @return 该速度下每行驶一公里的能耗值，单位wh/km
     * @exclude javadoc中不包含
     */
    t73(): number;
    /**
     * 设置该速度下每行驶一公里的能耗值，单位wh/km
     *
     * @param speedValue 该速度下每行驶一公里的能耗值，单位wh/km
     * @exclude javadoc中不包含
     */
    a82(s81: number): void;
}
