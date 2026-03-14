// @keepTs
// @ts-nocheck
import { OfflineMapProvince } from "../../api/maps/offlinemap/OfflineMapProvince";
import { p199 } from "./net/AbstractProtocalHandler";
import ArrayList from "@ohos.util.ArrayList";
/**
 * @author zxy
 */
export declare class z200 extends p199<string, ArrayList<OfflineMapProvince>> {
    protected mContext?: Context;
    private static readonly p208;
    static readonly o198 = "result";
    static readonly p198 = "offlinemap_with_province_vfour";
    constructor(context: Context, o208: string);
    w94(context: Context): void;
    protected n126(n208: string): ArrayList<OfflineMapProvince> | undefined;
    protected y199(m208: string): string;
    protected z199(): string;
    protected a200(): Map<string, string>;
}
