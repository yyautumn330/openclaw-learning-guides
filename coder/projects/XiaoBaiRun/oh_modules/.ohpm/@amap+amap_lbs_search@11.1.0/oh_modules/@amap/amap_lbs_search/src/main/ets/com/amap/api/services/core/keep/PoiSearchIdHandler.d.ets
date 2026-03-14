// @keepTs
// @ts-nocheck
import { PoiQuery } from "../../poisearch/PoiSearch";
import { PoiItem } from "../PoiItem";
import { e5 } from "./RequestCacheControl";
import { y43 } from "./PoiHandler";
export declare class z43 extends y43<string, PoiItem> {
    query: PoiQuery | undefined;
    constructor(context: Context, f44: string, query: PoiQuery | undefined);
    k6(): string;
    protected n6(json: string): PoiItem | undefined;
    private g44;
    protected m6(): string;
    protected v6(): e5 | undefined;
}
