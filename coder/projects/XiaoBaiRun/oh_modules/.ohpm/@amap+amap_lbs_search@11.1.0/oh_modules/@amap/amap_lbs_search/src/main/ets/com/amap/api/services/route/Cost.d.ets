// @keepTs
// @ts-nocheck
/**
 * 路线耗时等信息
 */
export declare class Cost {
    private duration;
    private q71;
    private r71?;
    private s71;
    private t71;
    /**
     * 获取线路耗时，包括方案总耗时及分段step中的耗时
     *
     * @return
     */
    getDuration(): number;
    /**
     * 设置线路耗时，包括方案总耗时及分段step中的耗时
     *
     * @param duration
     */
    setDuration(duration: number): void;
    /**
     * 获取收费路段里程，单位：米，包括分段信息
     *
     * @return
     */
    getTollDistance(): number;
    /**
     * 设置收费路段里程，单位：米，包括分段信息
     *
     * @param tollDistance
     */
    setTollDistance(p71: number): void;
    /**
     * 获取主要收费道路
     *
     * @return
     */
    getTollRoad(): string;
    /**
     * 设置主要收费道路
     *
     * @param tollRoad
     */
    setTollRoad(o71: string): void;
    /**
     * 获取此路线道路收费，单位：元，包括分段信息
     *
     * @return
     */
    getTolls(): number;
    /**
     * 设置此路线道路收费，单位：元，包括分段信息
     *
     * @param tolls
     */
    setTolls(n71: number): void;
    /**
     * 获取方案中红绿灯个数
     *
     * @return
     */
    getTrafficLights(): number;
    /**
     * 设置方案中红绿灯个数
     *
     * @param trafficLights
     */
    setTrafficLights(m71: number): void;
}
