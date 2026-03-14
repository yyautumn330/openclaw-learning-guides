// @keepTs
// @ts-nocheck
export declare class DrivingStrategy {
    static readonly c79: DrivingStrategy[];
    private constructor();
    private value;
    getValue(): number;
    static fromValue(value: number): DrivingStrategy;
    /**
     * 默认，高德推荐，同高德地图APP默认
     */
    static readonly DEFAULT: DrivingStrategy;
    /**
     * 躲避拥堵
     */
    static readonly AVOID_CONGESTION: DrivingStrategy;
    /**
     * 高速优先
     */
    static readonly HIGHWAY_PRIORITY: DrivingStrategy;
    /**
     * 不走高速
     */
    static readonly AVOID_HIGHWAY: DrivingStrategy;
    /**
     * 少收费
     */
    static readonly LESS_CHARGE: DrivingStrategy;
    /**
     * 大路优先
     */
    static readonly ROAD_PRIORITY: DrivingStrategy;
    /**
     * 速度最快
     */
    static readonly SPEED_PRIORITY: DrivingStrategy;
    /**
     * 躲避拥堵＋高速优先
     */
    static readonly AVOID_CONGESTION_HIGHWAY_PRIORITY: DrivingStrategy;
    /**
     * 躲避拥堵＋不走高速
     */
    static readonly AVOID_CONGESTION_AVOID_HIGHWAY: DrivingStrategy;
    /**
     * 躲避拥堵＋少收费
     */
    static readonly AVOID_CONGESTION_LESS_CHARGE: DrivingStrategy;
    /**
     * 少收费＋不走高速
     */
    static readonly LESS_CHARGE_AVOID_HIGHWAY: DrivingStrategy;
    /**
     * 躲避拥堵＋少收费＋不走高速
     */
    static readonly AVOID_CONGESTION_LESS_CHARGE_AVOID_HIGHWAY: DrivingStrategy;
    /**
     * 躲避拥堵＋大路优先
     */
    static readonly AVOID_CONGESTION_ROAD_PRIORITY: DrivingStrategy;
    /**
     * 躲避拥堵＋速度最快
     */
    static readonly AVOID_CONGESTION_SPEED_PRIORITY: DrivingStrategy;
}
