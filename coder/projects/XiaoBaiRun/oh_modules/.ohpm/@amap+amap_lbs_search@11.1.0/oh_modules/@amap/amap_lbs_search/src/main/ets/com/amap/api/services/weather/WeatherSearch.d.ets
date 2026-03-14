// @keepTs
// @ts-nocheck
import { LocalWeatherForecastResult } from "./LocalWeatherForecastResult";
import { LocalWeatherLiveResult } from "./LocalWeatherLiveResult";
import { WeatherSearchQuery } from "./WeatherSearchQuery";
/**
 * 本类为天气查询的“入口”类，定义此类，开始搜索。天气查询分为实况天气查询和预报天气查询。
 * @since V1.0.0
 */
export declare class WeatherSearch {
    private search?;
    constructor(context: Context);
    /**
     * 返回天气查询条件。
     * @return 返回查询条件
     * @since V1.0.0
     */
    getQuery(): WeatherSearchQuery | undefined;
    /**
     * 设置天气查询条件。
     * @param query 查询条件。
     * @since V1.0.0
     */
    setQuery(query: WeatherSearchQuery): void;
    /**
     * 查询天气信息的异步接口。
     * @since V1.0.0
     */
    searchWeatherAsyn(): void;
    /**
     * 设置天气信息查询监听。
     * @param listener 天气信息查询监听对象。
     * @since V1.0.0
     */
    setOnWeatherSearchListener(listener: OnWeatherSearchListener): void;
}
/**
 * 此接口定义了天气搜索的异步处理回调接口。
 * @since V1.0.0
 */
export interface OnWeatherSearchListener {
    /**
     * 返回Weather异步处理的实况天气结果。
     * @param weatherLiveResult 实况天气查询的搜索结果。
     * @param errorCode 返回结果成功或者失败的响应码。1000为成功(V3.2.1之后搜索成功响应码为1000，之前版本为0)，其他为失败（详细信息参见网站开发指南-错误码对照表）
     * @since V1.0.0
     */
    onWeatherLiveSearched: (weatherLiveResult: LocalWeatherLiveResult | undefined, errorCode: number) => void;
    /**
     * 返回Weather异步处理的预报天气结果。
     * @param weatherForecastResult 预报天气查询的搜索结果。
     * @param errorCode 返回结果成功或者失败的响应码。1000为成功(V3.2.1之后搜索成功响应码为1000，之前版本为0)，其他为失败（详细信息参见网站开发指南-错误码对照表）
     * @since V1.0.0
     */
    onWeatherForecastSearched: (weatherForecastResult: LocalWeatherForecastResult | undefined, errorCode: number) => void;
}
