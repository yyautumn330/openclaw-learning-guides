// @keepTs
// @ts-nocheck
import { LocalWeatherLive } from "./LocalWeatherLive";
import { WeatherSearchQuery } from "./WeatherSearchQuery";
/**
 * 此类定义了实况天气的结果集。
 * @since V1.0.0
 */
export declare class LocalWeatherLiveResult {
    private query;
    private h97;
    private constructor();
    /**
     * @exclude javadoc中不显示。
     */
    static createPagedResult(query: WeatherSearchQuery, e97: LocalWeatherLive): LocalWeatherLiveResult;
    /**
     * 返回该结果对应的查询参数。
     * @return 该结果对应的查询参数。
     * @since V1.0.0
     */
    getWeatherLiveQuery(): WeatherSearchQuery;
    /**
     * 返回实况天气的查询结果。
     * @return 实况天气的查询结果。
     * @since V1.0.0
     */
    getLiveResult(): LocalWeatherLive;
}
