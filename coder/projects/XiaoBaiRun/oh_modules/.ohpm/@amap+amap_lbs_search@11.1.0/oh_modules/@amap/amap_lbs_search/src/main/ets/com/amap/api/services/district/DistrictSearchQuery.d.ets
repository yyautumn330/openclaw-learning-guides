// @keepTs
// @ts-nocheck
/**
 * 此类定义了行政区划搜索的参数。
 * @since 1.0.1
 *
 */
export declare class DistrictSearchQuery {
    /**
     * 行政区划级别-国家。
     * @deprecated 1.0.1 不再需要此参数限制
     * @since 1.0.1
     */
    static readonly KEYWORDS_COUNTRY: string;
    /**
     * 行政区划级别-省。
     * @deprecated 1.0.1 不再需要此参数限制
     * @since 1.0.1
     */
    static readonly KEYWORDS_PROVINCE: string;
    /**
     * 行政区划级别-市。
     * @deprecated 1.0.1 不再需要此参数限制
     * @since 1.0.1
     */
    static readonly KEYWORDS_CITY: string;
    /**
     * 行政区划级别-区/县。
     * @deprecated 1.0.1 不再需要此参数限制
     * @since 1.0.1
     */
    static readonly KEYWORDS_DISTRICT: string;
    /**
     * 行政区划级别-商圈。
     * @deprecated 1.0.1 不再需要此参数限制
     * @since 1.0.1
     */
    static readonly KEYWORDS_BUSINESS: string;
    private i57;
    private j57;
    private k57;
    /**
     * @deprecated 1.0.1 不再需要此参数限制
     * @since 1.0.1
     */
    private l57;
    private m57;
    private n57;
    private o57;
    private p57;
    /**
     * 构造 DistrictSearchQuery 对象。
     * @since 1.0.1
     */
    constructor();
    /**
     * 设置行政区域搜索是否返回边界值，true为返回，false为不返回。
     * @param isBoundary – true/false。
     * @since 1.0.1
     */
    setShowBoundary(isBoundary: boolean): void;
    /**
     * 返回行政区域查询是否返回边界值。
     * @return true为返回边界值，false为不返回。
     * @since 1.0.1
     */
    isShowBoundary(): boolean;
    /**
     * 获取设置查询的是第几页，从0开始。<font color="red">自 5.2.1后修改成从1开始，和iOS保持一致。</font>
     * @return 查询的是第几页。
     * @since 1.0.1
     */
    getPageNum(): number;
    /**
     * 设置查询第几页的结果数目。
     * @param mPageNum 查询第几页的结果，从0开始。<font color="red">自 5.2.1后修改成从1开始，和iOS保持一致。</font>
     * @since 1.0.1
     */
    setPageNum(h57: number): void;
    /**
     * 返回查询页面的结果数目。
     * @return 查询页面的结果数目。
     * @since 1.0.1
     */
    getPageSize(): number;
    /**
     * 设置查询每页的结果数目， 默认值是20 条，取值范围在[1-50]。
     * @param mPageSize 每页的最大结果数目。
     * @since 1.0.1
     */
    setPageSize(g57: number): void;
    /**
     * 返回查询时所用字符串关键字。
     * @return 查询字符串关键字。
     * @since 1.0.1
     */
    getKeywords(): string | undefined;
    /**
     * 设置查询字符串关键字。关键词支持：行政区名称、城市编码、区域编码。
     * @param mKeywords 查询字符串关键字。
     * @since 1.0.1
     */
    setKeywords(f57: string): void;
    /**
     * 返回查询关键字的级别。
     * @return 查询关键字的级别。
     * @deprecated 1.0.1 不再需要此参数限制
     * @since 1.0.1
     */
    getKeywordsLevel(): string | undefined;
    /**
     * 设置查询关键字的级别。
     * @param mLevel 查询关键字的级别，请参见 {@link DistrictSearch} 中定义的常量。
     * @deprecated 1.0.1 不再需要此参数限制
     * @since 1.0.1
     */
    setKeywordsLevel(e57: string): void;
    /**
     * 是否返回下级区划。
     * @return true表示返回下级区划，反之，不返回下级区划。
     * @deprecated 自 7.1.0 废弃，返回下级行政区划参考 {@link DistrictSearchQuery#getSubDistrict()}
     * @since 1.0.1
     */
    isShowChild(): boolean;
    /**
     * 设置是否返回下级区划。
     * @param mShowChild 是否返回下级区划，默认为true，返回下级区划。
     * @deprecated 自 7.1.0 废弃，设置下级行政区划参考 {@link DistrictSearchQuery#setSubDistrict(int)} ()}
     * @since 1.0.1
     */
    setShowChild(d57: boolean): void;
    /**
     * 是否返回下级区划。
     * @return 0:不返回下级行政区,1：返回下一级行政区2：返回下两级行政区3：返回下三级行政区。
     * @since 1.0.1
     */
    getSubDistrict(): number;
    /**
     * 设置显示下级行政区级数（行政区级别包括：国家、省/直辖市、市、区/县、乡镇/街道多级数据）
     * @param subDistrict 0:不返回下级行政区,1：返回下一级行政区2：返回下两级行政区3：返回下三级行政区。
     * 需要在此特殊说明，目前部分城市和省直辖县因为没有区县的概念，故在市级下方直接显示街道。
     * 例如：广东-东莞、海南-文昌市
     * @since 1.0.1
     */
    setSubDistrict(c57: number): void;
    /**
     * 返回是否显示商圈。
     * @return true表示下级行政区划会返回商圈（keyword级别为区/县）。
     * @since 1.0.1
     * @deprecated 自 5.1.0 废弃，用率极低，而且会影响精准度，取消商圈（biz_area）级别数据，用街道（street）顶替商圈位置
     */
    isShowBusinessArea(): boolean;
    /**
     * 设置是否显示商圈
     * @param showbiz 可选为true/false，为了能够精准的定位到街道，特别是在快递、物流、送餐等场景下，强烈建议将此设置为false。
     * @since 1.0.1
     * @deprecated 自 5.1.0 废弃，使用率极低，而且会影响精准度，取消商圈（biz_area）级别数据，用街道（street）顶替商圈位置
     */
    setShowBusinessArea(b57: boolean): void;
    /**
     * 检查行政区划级别参数是否正确
     * @return 行政区划级别参数是否正确
     * @deprecated v1.0.1 不再需要此参数限制
     * @since 1.0.1
     */
    checkLevels(): boolean;
    /**
     * 返回行政区划查询条件的关键字是否为非空。
     * @return true关键字不为空，false关键字为空。
     * @internal javadoc中不显示。
     */
    c13(): boolean;
    /**
     * 比较两个查询条件是否相同。
     * @param obj 查询条件。
     * @return 查询条件是否相同。
     * @since 1.0.1
     */
    equals(obj: object): boolean;
    /**
     * @internal javadoc中不显示。 内部使用接口
     */
    a3(a57: DistrictSearchQuery | undefined): boolean;
    clone(): DistrictSearchQuery;
}
