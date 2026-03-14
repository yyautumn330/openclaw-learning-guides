// @keepTs
// @ts-nocheck
import { Context as Context } from "@ohos.abilityAccessCtrl";
import { y16 } from "../../../mapcore/tool/BaseTileRequest";
import { Tile } from "../Tile";
import { TileProvider } from "../TileProvider";
export declare class z16 extends TileProvider {
    private x;
    private y;
    private z;
    private f17;
    private url;
    private g17;
    private context;
    constructor(e17: Context);
    /**
     *  获取url
     * @since v9.6.0
     * @exclude javadoc中不显示 后续开放
     * @return
     */
    getUrl(): string;
    /**
     * 设置url
     * @since v9.6.0
     * @param url
     */
    setUrl(url: string): void;
    getTile(x: number, y: number, zoom: number): Promise<Tile>;
    getTileWidth(): number;
    getTileHeight(): number;
    private h17;
    private i17;
    k17(template: string, ...args: string[]): string;
}
export declare class a17 extends y16 {
    private baseUrl;
    private l17;
    constructor(context: Context, url: string);
    protected getUri(): string;
}
