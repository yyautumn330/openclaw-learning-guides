// @keepTs
// @ts-nocheck
/**
 * 定义了一个POI深度信息类。
 * @since V1.0.0
 */
export declare class PoiItemExtension {
    private y61;
    private e61;
    /**
     * PoiItemExtension 构造方法。
     * @param opentime 营业时间。
     * @param rating 评分。
     * @since V1.0.0
     */
    constructor(x61: string | undefined, rating: string | undefined);
    /**
     * 返回POI的营业时间。
     * @return 营业时间描述。
     * @since V1.0.0
     */
    getOpentime(): string | undefined;
    /**
     * 赋值营业时间
     * @param opentime
     */
    setOpentime(w61: string | undefined): void;
    /**
     * 返回POI的评分
     * @return POI评分。
     * @since V1.0.0
     */
    getRating(): string | undefined;
    /**
     * 赋值POI评分
     * @param opentime
     */
    setRating(rating: string | undefined): void;
}
