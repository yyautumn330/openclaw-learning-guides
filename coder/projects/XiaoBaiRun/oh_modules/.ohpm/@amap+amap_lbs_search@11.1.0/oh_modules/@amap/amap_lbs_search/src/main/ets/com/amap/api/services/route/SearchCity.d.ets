// @keepTs
// @ts-nocheck
/**
 * 此类定义搜索返回城市的名称和编码。
 * @since 1.0.0
 */
export declare class SearchCity {
    private q85?;
    private r85?;
    private s85?;
    /**
     * 得到城市的名称。
     * @return 城市的名称。
     * @since 1.0.0
     */
    getSearchCityName(): string;
    /**
     * 设置城市的名称。
     * @param cityName 城市名称。
     * @since 1.0.0
     */
    setSearchCityName(cityName: string): void;
    /**
     * 得到城市的编码。
     * @return 城市编码。
     * @since 1.0.0
     */
    getSearchCitycode(): string;
    /**
     * 设置城市的编码。
     * @param citycode 城市编码。
     * @since 1.0.0
     */
    setSearchCitycode(p85: string): void;
    /**
     * 得到城市的行政编码。
     * @return 城市的行政编码。
     * @since 1.0.0
     */
    getSearchCityAdCode(): string;
    /**
     * 设置城市的行政编码。
     * @param mSearchAdCode 城市的行政编码。
     * @since 1.0.0
     */
    setSearchCityhAdCode(o85: string): void;
}
