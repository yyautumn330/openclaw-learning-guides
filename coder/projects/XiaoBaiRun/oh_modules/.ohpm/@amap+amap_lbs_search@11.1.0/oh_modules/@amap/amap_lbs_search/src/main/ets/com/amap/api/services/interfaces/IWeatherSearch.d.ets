// @keepTs
// @ts-nocheck
import { OnWeatherSearchListener } from "../weather/WeatherSearch";
import { WeatherSearchQuery } from "../weather/WeatherSearchQuery";
/**
 * 本类为天气查询的“入口”类，定义此类，开始搜索。天气查询分为实况天气查询和预报天气查询。
 * @since V2.7.0
 */
export interface u60 {
    /**
     * 返回天气查询条件。
     * @return 返回查询条件
     * @since V2.7.0
     */
    getQuery(): WeatherSearchQuery | undefined;
    /**
     * 设置天气查询条件。
     * @param query 查询条件。
     * @since V2.7.0
     */
    setQuery(query: WeatherSearchQuery): void;
    /**
     * 查询天气信息的异步接口。
     * @since V2.7.0
     */
    searchWeatherAsyn(): void;
    /**
     * 设置天气信息查询监听。
     * @param listener 天气信息查询监听对象。
     * @since V2.7.0
     */
    setOnWeatherSearchListener(listener: OnWeatherSearchListener): void;
}
