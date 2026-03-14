// @keepTs
// @ts-nocheck
/**
 * 此类定义了地理编码查询的关键字和查询城市。
 * @since V1.0.0
 */
export declare class GeocodeQuery {
    private j58;
    private city;
    private country;
    /**
     * GeocodeQuery构造函数。
     * @param locationName 查询地址。
     * @param city 可选值：cityname（中文或中文全拼）、citycode、adcode。如传入null或空字符串则为“全国”，
     * @since V1.0.0
     */
    constructor(i58: string | undefined, city: string | undefined);
    /**
     * 返回查询地理名称。
     * @return 该结果的查询地理名称。
     * @since V1.0.0
     */
    getLocationName(): string | undefined;
    /**
     * 设置查询的地理名称。
     * @param locationName 查询的地理名称。
     * @since V1.0.0
     */
    setLocationName(h58: string): void;
    /**
     * 返回查询城市编码/城市名称/行政区划代码。
     * @return 该结果的查询城市。
     * @since V1.0.0
     */
    getCity(): string | undefined;
    /**
     * 设置查询城市名称、城市编码或行政区划代码。
     * @param city 查询的cityname（中文或中文全拼）、citycode、adcode。
     * @since V1.0.0
     */
    setCity(city: string): void;
    /**
     * 海外生效
     * 国家编码
     * 指定查询国家，支持多个国家，用“|”分隔，可选值：国家代码ISO 3166 或 global
     * https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
     * @since 1.0.0
     */
    getCountry(): string | undefined;
    /**
     * 海外生效
     * 指定查询国家，支持多个国家，用“|”分隔，可选值：国家代码ISO 3166 或 global
     * https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
     * @since 1.0.0
     */
    setCountry(country: string): void;
    /**
     * 比较两个查询条件是否相同。
     * @param obj 查询条件。
     * @return 查询条件是否相同。
     * @since V1.0.0
     */
    equals(obj: Object): boolean;
}
