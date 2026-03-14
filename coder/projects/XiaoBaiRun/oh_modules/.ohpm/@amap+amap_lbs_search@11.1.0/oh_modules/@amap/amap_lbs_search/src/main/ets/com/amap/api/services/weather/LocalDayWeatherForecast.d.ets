// @keepTs
// @ts-nocheck
/**
 * 此类为预报天气中某天的天气预报类。
 * @since V1.0.0
 */
export declare class LocalDayWeatherForecast {
    private date;
    private week;
    private d96;
    private e96;
    private f96;
    private g96;
    private h96;
    private i96;
    private j96;
    private k96;
    /**
     * LocalDayWeatherForecast构造函数
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    constructor();
    /**
     * 返回预报天气的年月日。
     * @return 预报天气的时间（年月日）。
     * @since V1.0.0
     */
    getDate(): string | undefined;
    /**
     * 设置预报天气的年月日。
     * @param date 预报天气的时间（年月日）。
     * @since V1.0.0
     */
    setDate(date: string): void;
    /**
     * 返回预报天气的星期。返回阿拉伯数字1-7。
     * @return 预报天气的星期。
     * @since V1.0.0
     */
    getWeek(): string | undefined;
    /**
     * 设置预报天气的星期。
     * @param week 预报天气的星期，阿拉伯数字1-7。
     * @since V1.0.0
     */
    setWeek(week: string): void;
    /**
     * 返回白天天气现象，如“晴”、“多云”。详细类型参见开发指南--天气对照表。
     * @return 天气现象描述。
     * @since V1.0.0
     */
    getDayWeather(): string | undefined;
    /**
     * 设置白天的天气现象。
     * @param dayWeather 天气现象描述。
     * @since V1.0.0
     */
    setDayWeather(c96: string): void;
    /**
     * 返回夜间天气现象，如“晴”、“多云”。详细类型参见开发指南--天气对照表。
     * @return 晚上天气现象。
     * @since V1.0.0
     */
    getNightWeather(): string | undefined;
    /**
     * 设置夜间天气现象。
     * @param nightWeather 夜间天气现象。
     * @since V1.0.0
     */
    setNightWeather(b96: string): void;
    /**
     * 返回白天天气温度，单位：摄氏度。
     * @return 白天的天气温度。
     * @since V1.0.0
     */
    getDayTemp(): string | undefined;
    /**
     * 设置白天天气温度
     * @param dayTemp 白天天气温度，单位：摄氏度。
     * @since V1.0.0
     */
    setDayTemp(a96: string): void;
    /**
     * 返回夜间天气温度，单位：摄氏度。
     * @return 夜间的天气温度。
     * @since V1.0.0
     */
    getNightTemp(): string | undefined;
    /**
     * 设置夜间天气温度。
     * @param nightTemp 夜间天气温度，单位：摄氏度。
     * @since V1.0.0
     */
    setNightTemp(z95: string): void;
    /**
     * 返回白天风向。详细类型参见开发指南--天气对照表。
     * @return 白天风向。
     * @since V1.0.0
     */
    getDayWindDirection(): string | undefined;
    /**
     * 设置白天风向。
     * @param dayWindDirection 白天风向。
     * @since V1.0.0
     */
    setDayWindDirection(y95: string): void;
    /**
     * 返回夜间风向。详细类型参见开发指南--天气对照表。
     * @return 夜间风向。
     * @since V1.0.0
     */
    getNightWindDirection(): string | undefined;
    /**
     * 设置夜间风向。
     * @param nightWindDirection 夜间风向。
     * @since V1.0.0
     */
    setNightWindDirection(x95: string): void;
    /**
     * 返回白天风力，单位：级。详细类型参见开发指南--天气对照表。
     * @return 白天风力。
     * @since V1.0.0
     */
    getDayWindPower(): string | undefined;
    /**
     * 设置白天风力。
     * @param dayWindPower 白天风力，单位：级。
     * @since V1.0.0
     */
    setDayWindPower(w95: string): void;
    /**
     * 返回夜间风力，单位：级。详细类型参见开发指南--天气对照表。
     * @return 夜间风力。
     * @since V1.0.0
     */
    getNightWindPower(): string | undefined;
    /**
     * 设置夜间风力。
     * @param nightWindPower 夜间风力，单位：级。
     * @since V1.0.0
     */
    setNightWindPower(v95: string): void;
}
