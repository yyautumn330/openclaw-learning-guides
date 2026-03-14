// @keepTs
// @ts-nocheck
/**
 * Tile 数据源
 *
 * @author zxy
 * @data 3/19/21
 * @since v8.0.0
 */
export declare class TileOverlaySource {
    static c18: number;
    static d18: number;
    static e18: number;
    static f18: number;
    private id;
    /**
     * 数据源唯一标识，请求时通过唯一标识来进行区分，内部生成
     * @since v8.0.0
     */
    getId(): number;
    private type;
    /**
     * 数据源类型
     * @since v8.0.0
     */
    getType(): number;
    private url;
    /**
     * 数据源类型 下载地址
     * @since v8.0.0
     */
    getUrl(): string;
    private minZoom;
    /**
     *  数据最小级别，低于了没有数据
     * @since v8.0.0
     */
    setMinZoom(value: number): void;
    /**
     *  数据最小级别，低于了没有数据
     * @since v8.0.0
     */
    getMinZoom(): number;
    private maxZoom;
    /**
     *   数据最大级别，高于了没有数据
     * @since v8.0.0
     */
    setMaxZoom(value: number): void;
    /**
     *  数据最大级别，高于了没有数据
     * @since v8.0.0
     */
    getMaxZoom(): number;
    private cacheEnabled;
    /**
     * 是否会缓存瓦片数据
     * @since v8.0.0
     */
    g18(value: boolean): void;
    /**
     * 是否会缓存瓦片数据
     * @since v8.0.0
     */
    h18(): boolean;
    constructor(id: number, type: number, url: string);
}
