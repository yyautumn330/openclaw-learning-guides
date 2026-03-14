// @keepTs
// @ts-nocheck
import { u60 } from "../interfaces/IWeatherSearch";
import { OnWeatherSearchListener } from "../weather/WeatherSearch";
import { WeatherSearchQuery } from "../weather/WeatherSearchQuery";
/**
 * 本类为天气查询的“入口”类，定义此类，开始搜索。天气查询分为实况天气查询和预报天气查询。
 * @since V2.7.0
 */
export declare class x94 implements u60 {
    private context;
    private query;
    private listener;
    private j43;
    private k43;
    private y89;
    constructor(context: Context);
    getQuery(): WeatherSearchQuery | undefined;
    /**
     * 设置天气查询条件。
     * @param query 查询条件。
     * @since V2.7.0
     */
    setQuery(query: WeatherSearchQuery): void;
    searchWeatherAsyn(): void;
    /**
     * 设置天气信息查询监听。
     * @param listener 天气信息查询监听对象。
     * @since V2.7.0
     */
    setOnWeatherSearchListener(listener: OnWeatherSearchListener): void;
    private z94;
    private a95;
}
