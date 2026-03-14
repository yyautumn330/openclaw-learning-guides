// @keepTs
// @ts-nocheck
/**
 * 此类定义搜索返回行政区的名称和编码。
 * @since 1.0.0
 */
export declare class District {
    private j74?;
    private k74?;
    /**
     * 得到行政区的名称。
     * @return 行政区的名称。
     * @since 1.0.0
     */
    getDistrictName(): string;
    /**
     * 设置行政区的名称。
     * @param mDistrictName 行政区名称。
     * @since 1.0.0
     * @exclude javadoc中不显示。
     */
    k35(i74: string): void;
    /**
     * 得到行政区的编码。
     * @return 行政区的编码。
     * @since 1.0.0
     */
    getDistrictAdcode(): string;
    /**
     * 设置行政区的编码。
     * @param mDistrictAdcode 行政区的编码。
     * @since 1.0.0
     * @exclude javadoc中不显示。
     */
    l35(h74: string): void;
}
