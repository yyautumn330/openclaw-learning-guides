// @keepTs
// @ts-nocheck
export declare class TileOverlaySource {
    static readonly c18: number;
    static readonly d18: number;
    static readonly e18: number;
    static readonly f18: number;
    private readonly id;
    private readonly type;
    private readonly url;
    private attribute?;
    private minZoom;
    private maxZoom;
    private cacheEnabled;
    /**
     * Tile数据源，需要定数据的类型
     * @param id id
     * @param type 数据类型
     * @param url 数据下载的url
     */
    constructor(id: number, type: number, url: string);
    /**
     * 数据源唯一标识
     */
    getId(): number;
    /**
     * 数据源类型
     */
    getType(): number;
    /**
     * 数据最小级别
     */
    getMinZoom(): number;
    setMinZoom(minZoom: number): void;
    /**
     * 数据最大级别
     */
    getMaxZoom(): number;
    setMaxZoom(maxZoom: number): void;
    /**
     * 数据源下载地址
     */
    getUrl(): string;
    /**
     * 是否会缓存瓦片数据
     */
    h18(): boolean;
    g18(g46: boolean): void;
}
