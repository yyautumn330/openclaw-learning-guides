// @keepTs
// @ts-nocheck
/**
 * 此类为实况天气返回结果类。
 * @since V1.0.0
 */
export declare class LocalWeatherLive {
    private f58;
    private city;
    private x3;
    private b97;
    private temperature;
    private c97;
    private d97;
    private humidity;
    private q96;
    /**
     * LocalWeatherLive 构造函数
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    constructor();
    /**
     * 返回省份名称。
     * @return 省份名称。
     * @since V1.0.0
     */
    getProvince(): string | undefined;
    /**
     * 返回城市名称。
     * @return 城市名称。
     * @since V1.0.0
     */
    getCity(): string | undefined;
    /**
     * 返回行政区划代码。
     * @return 行政区划代码。
     * @since V1.0.0
     */
    getAdCode(): string | undefined;
    /**
     * 返回天气现象描述，如“晴”、“多云”等。详细类型参见开发指南--天气对照表。
     * @return 天气现象描述。
     * @since V1.0.0
     */
    getWeather(): string | undefined;
    /**
     * 返回实时气温，单位：摄氏度。
     * @return 实时气温，单位：摄氏度。
     * @since V1.0.0
     */
    getTemperature(): string | undefined;
    /**
     * 返回风向。详细类型参见开发指南--天气对照表。
     * @return 风向。
     * @since V1.0.0
     */
    getWindDirection(): string | undefined;
    /**
     * 返回风力，单位：级。详细类型参见开发指南--天气对照表。
     * @return 风力，单位：级。
     * @since V1.0.0
     */
    getWindPower(): string | undefined;
    /**
     * 返回空气湿度的百分比。
     * @return 空气湿度的百分比。
     * @since V1.0.0
     */
    getHumidity(): string | undefined;
    /**
     * 返回实时数据发布时间。
     * @return 实时数据发布时间。
     * @since V1.0.0
     */
    getReportTime(): string | undefined;
    /**
     * 设置省份名称
     * @param province 省份名称
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    setProvince(a97: string): void;
    /**
     * 设置城市名称。
     * @param city 城市名称。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    setCity(city: string): void;
    /**
     * 设置行政区划代码。
     * @param adcode 行政区划代码。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    setAdCode(z96: string): void;
    /**
     * 设置天气现象描述。
     * @param weather 天气现象描述。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    c36(y96: string): void;
    /**
     * 设置实时气温。
     * @param temperature 实时气温，单位：摄氏度。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    d36(temperature: string): void;
    /**
     * 设置风向。
     * @param windDirection 风向。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    e36(x96: string): void;
    /**
     * 设置风力。
     * @param windPower 风力。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    f36(w96: string): void;
    /**
     * 设置湿度。
     * @param humidity 湿度。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    g36(humidity: string): void;
    /**
     * 设置实时数据发布时间。
     * @param reportTime 实时数据发布时间。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    setReportTime(v96: string): void;
}
