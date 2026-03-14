// @keepTs
// @ts-nocheck
/**
 * 定义了当POI搜索无结果时，引擎对于搜索的城市建议内容。
 * @since V1.0.0
 */
export declare class SuggestionCity {
    private x54;
    private k54;
    private j54;
    private o56;
    /**
     * 返回城市名称。
     * @return 城市名称。
     * @since V1.0.0
     */
    getCityName(): string | undefined;
    /**
     * 设置城市名称。
     * @param mCityName 城市名称。
     * @since V1.0.0
     */
    setCityName(n56: string | undefined): void;
    /**
     * 返回城市编码。城市编码参考请在网站“相关下载”处获取。
     * @return 城市编码。
     * @since V1.0.0
     */
    getCityCode(): string | undefined;
    /**
     * 设置城市编码。城市编码参考请在网站“相关下载”处获取。
     * @param mCityCode 城市编码。
     * @since V1.0.0
     */
    setCityCode(m56: string): void;
    /**
     * 返回区域代码。
     * @return 区域代码。
     * @since V1.0.0
     */
    getAdCode(): string | undefined;
    /**
     * 设置区域代码。
     * @param mAdCode 区域代码。
     * @since V1.0.0
     */
    setAdCode(l56: string | undefined): void;
    /**
     * 返回区域的建议结果数目。
     * @return 区域的建议结果数目。
     * @since V1.0.0
     */
    getSuggestionNum(): number | undefined;
    /**
     * 设置建议的结果数目。
     * @param mSuggestionNum 建议的结果数目。
     * @since V1.0.0
     */
    setSuggestionNum(k56: number | undefined): void;
}
