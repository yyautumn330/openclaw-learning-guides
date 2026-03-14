// @keepTs
// @ts-nocheck
/**
 * 此类定义了天气信息搜索的参数。
 * @since V1.0.0
 */
export declare class WeatherSearchQuery {
    /**
     * 实况天气，值为1。
     * @since V1.0.0
     */
    static readonly WEATHER_TYPE_LIVE: number;
    /**
     * 预报天气，值为2。
     * @since V1.0.0
     */
    static readonly WEATHER_TYPE_FORECAST: number;
    private city;
    private type;
    /**
     * 根据给定的参数来构造一个 WeatherSearchQuery 的新对象。
     * @param city 设置查询的城市，支持城市名称、adcode。
     * @param type 查询天气类型，分为实况天气和预报天气两种。
     * @since V1.0.0
     */
    constructor(city: string, type: number);
    /**
     * 返回查询的城市名称。
     * @return 返回查询的城市名称.
     * @since V1.0.0
     */
    getCity(): string;
    /**
     * 返回查询的天气类型。
     * @return 返回查询的天气类型。1，实况天气；2，预报天气。
     * @since V1.0.0
     */
    getType(): number;
    /**
     * @exclude javadoc中不显示。
     */
    clone(): WeatherSearchQuery;
}
