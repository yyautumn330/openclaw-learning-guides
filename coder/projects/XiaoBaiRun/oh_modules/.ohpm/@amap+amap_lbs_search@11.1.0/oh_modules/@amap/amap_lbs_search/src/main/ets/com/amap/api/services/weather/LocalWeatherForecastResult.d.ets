// @keepTs
// @ts-nocheck
import { LocalWeatherForecast } from "./LocalWeatherForecast";
import { WeatherSearchQuery } from "./WeatherSearchQuery";
/**
 * 此类定义了预报天气的结果集。
 * @since V1.0.0
 */
export declare class LocalWeatherForecastResult {
    private query;
    private u96;
    private constructor();
    /**
     * @exclude javadoc中不显示。
     */
    static createPagedResult(query: WeatherSearchQuery, s96: LocalWeatherForecast): LocalWeatherForecastResult;
    /**
     * 返回该结果对应的查询参数。
     * @return 该结果对应的查询参数。
     * @since V1.0.0
     */
    getWeatherForecastQuery(): WeatherSearchQuery;
    /**
     * 返回预报天气的查询结果。
     * @return 预报天气的查询结果。
     * @since V1.0.0
     */
    getForecastResult(): LocalWeatherForecast;
}
