// @keepTs
// @ts-nocheck
/**
 * 城市属性的相关类。
 *
 * @since V2.0.1
 */
export declare class City {
    private s8;
    private t8;
    private u8;
    private mPinyin;
    private mAdcode;
    /**
     * 构造一个City对象。
     *
     * @since V2.0.1
     */
    City(): void;
    /**
     * 设置城市名称。
     *
     * @param city 城市名称。
     * @since V2.0.1
     */
    setCity(city: string): void;
    /**
     * 返回城市名称。
     *
     * @return 城市名称。
     * @since V2.0.1
     */
    getCity(): string;
    /**
     * 设置城市代码。
     *
     * @param code 城市代码。
     * @since V2.0.1
     */
    setCode(code: string): void;
    /**
     * 返回城市代码。
     *
     * @return 城市代码。
     * @since V2.0.1
     */
    getCode(): string;
    /**
     * 返回城市名称简拼拼音。
     *
     * @return 城市名称简拼拼音。
     * @since V2.2.0
     */
    getJianpin(): string;
    /**
     * 设置城市名称简拼拼音。
     *
     * @param initial 城市名称简拼拼音。
     * @since V2.2.0
     */
    setJianpin(r8: string): void;
    /**
     * 返回城市名称拼音
     *
     * @return 城市名称拼音
     * @since V2.0.1
     */
    getPinyin(): string;
    /**
     * 设置城市名称拼音
     *
     * @param pinyin 城市名称拼音
     * @since V2.0.1
     */
    setPinyin(q8: string): void;
    /**
     * 得到城市的行政编码
     *
     * @return 城市的行政编码
     * @since V2.2.0
     */
    getAdcode(): string;
    /**
     * 设置城市行政编码
     *
     * @param adcode 城市的行政编码
     * @since V2.2.0
     */
    setAdcode(p8: string): void;
}
