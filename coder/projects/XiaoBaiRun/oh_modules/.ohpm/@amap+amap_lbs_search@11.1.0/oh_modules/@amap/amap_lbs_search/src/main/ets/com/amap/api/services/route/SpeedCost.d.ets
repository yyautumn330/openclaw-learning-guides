// @keepTs
// @ts-nocheck
/**
 * 速度相关权值，可以重复传多组，含多组SPEED和VALUE，每组代表一个特定速度下每行驶一公里的能耗值（不含坡度消耗），介于两个速度之间的可用线性插值计算
 *
 * @exclude javadoc中不包含
 */
export declare class z71 {
    /**
     * 速度值，单位km/h
     */
    private speed;
    /**
     * 该速度下每行驶一公里的能耗值，单位wh/km
     */
    private value;
    /**
     * 获取速度值，单位km/h
     *
     * @return 速度值
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
    getValue(): number;
    /**
     * 设置该速度下每行驶一公里的能耗值，单位wh/km
     *
     * @param value 该速度下每行驶一公里的能耗值，单位wh/km
     * @exclude javadoc中不包含
     */
    setValue(value: number): void;
}
