// @keepTs
// @ts-nocheck
/**
 * 省属性的相关类。
 *
 * @since v2.2.0
 */
export declare class Province {
    private u10;
    private u8;
    private v10;
    private w10;
    /**
     * 构造一个Province对象。
     * @since v2.2.0
     */
    Province(): void;
    /**
     * 返回省名称。
     *
     * @return 省名称。
     * @since v2.2.0
     */
    getProvinceName(): string;
    /**
     * 返回省名称简拼拼音。
     *
     * @return 省名称简拼拼音。
     * @since v2.2.0
     */
    getJianpin(): string;
    /**
     * 返回省名称拼音。
     *
     * @return 省名称拼音。
     * @since v2.2.0
     */
    getPinyin(): string;
    /**
     * 设置省名称。
     *
     * @param provinceName 省名称。
     * @since v2.2.0
     */
    setProvinceName(provinceName: string): void;
    /**
     * 设置省名称简拼拼音。
     *
     * @param jianpin 省名称简拼拼音。
     * @since v2.2.0
     */
    setJianpin(t10: string): void;
    /**
     * 设置省名称拼音。
     *
     * @param pinyin 省名称拼音。
     * @since v2.2.0
     */
    setPinyin(s10: string): void;
    /**
     * 设置省行政编码。
     *
     * @param provinceCode 省的行政编码。
     * @since v2.2.0
     */
    setProvinceCode(r10: string): void;
    /**
     * 得到省的行政编码。
     *
     * @return 省的行政编码。
     * @since v2.2.0
     */
    getProvinceCode(): string;
}
