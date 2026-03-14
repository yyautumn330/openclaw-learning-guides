// @keepTs
// @ts-nocheck
import { LocalDayWeatherForecast } from "./LocalDayWeatherForecast";
import ArrayList from "@ohos.util.ArrayList";
/**
 * 天气预报类。支持当前时间在内的4天的天气进行预报。
 * @since V1.0.0
 */
export declare class LocalWeatherForecast {
    private f58;
    private city;
    private x3;
    private q96;
    private r96;
    /**
     * LocalWeatherForecast的构造函数。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    constructor();
    /**
     * 返回省份名称。
     * @return 返回省份名称。
     * @since V1.0.0
     */
    getProvince(): string | undefined;
    /**
     * 设置省份名称。
     * @param mProvince 省份名称。
     * @since V1.0.0
     */
    setProvince(p96: string): void;
    /**
     * 返回城市名称。
     * @return 城市名称。
     * @since V1.0.0
     */
    getCity(): string | undefined;
    /**
     * 设置城市名称。
     * @param mCity 城市名称。
     * @since V1.0.0
     */
    setCity(o96: string): void;
    /**
     * 返回行政区划代码。
     * @return 行政区划代码。
     * @since V1.0.0
     */
    getAdCode(): string | undefined;
    /**
     * 设置行政区划代码。
     * @param mAdCode 行政区划代码。
     * @since V1.0.0
     */
    setAdCode(n96: string): void;
    /**
     * 返回天气预报发布时间。
     * @return 天气预报发布时间。
     * @since V1.0.0
     */
    getReportTime(): string | undefined;
    /**
     * 设置天气预报发布时间。
     * @param mReportTime 天气预报发布时间。
     * @since V1.0.0
     */
    setReportTime(m96: string): void;
    /**
     * 返回天气预报的数据的数组，数组中的对象为 LocalDayWeatherForecast。
     * <p>数组中的第一个数据（即List.get(0)）表示今天的天气；第二个数据（即List.get(1)）表示明天的天气；第三个数据（即List.get(2)）表示后天的天气；第四个数据（即List.get(3)）表示大后天的天气。</p>
     * @return 天气预报的数据的数组。
     * @since V1.0.0
     */
    getWeatherForecast(): ArrayList<LocalDayWeatherForecast>;
    /**
     * 设置天气预报的结果。
     * @param weatherForecastList 天气预报结果。
     * @since V1.0.0
     */
    setWeatherForecast(l96: ArrayList<LocalDayWeatherForecast>): void;
}
