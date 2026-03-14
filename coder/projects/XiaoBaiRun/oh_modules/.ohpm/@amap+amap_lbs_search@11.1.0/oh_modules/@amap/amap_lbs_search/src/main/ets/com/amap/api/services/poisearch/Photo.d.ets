// @keepTs
// @ts-nocheck
/**
 * POI图片类
 * @since V1.0.0
 * */
export declare class Photo {
    private o54;
    private v61;
    /**
     * 获取图片的名称。
     * @return 图片名称。
     * @since V1.0.0
     */
    getTitle(): string | undefined;
    /**
     * 设置图片的名称。
     * @param mTitle 图片名称。
     * @since V1.0.0
     */
    setTitle(u61: string | undefined): void;
    /**
     * 返回图片url。
     * @return 图片url。
     */
    getUrl(): string | undefined;
    /**
     * 设置图片url。
     * @param mUrl 图片url。
     * @since V1.0.0
     */
    setUrl(t61: string | undefined): void;
}
