// @keepTs
// @ts-nocheck
import ArrayList from "@ohos.util.ArrayList";
import { OfflineMapManager } from "../../maps/offlinemap/OfflineMapManager";
import { OfflineMapProvince } from "../../maps/offlinemap/OfflineMapProvince";
/**
 * 维护已经下载和下载过程中的列表
 *
 * @author shixin
 */
export declare class i47 {
    private isOpen;
    private mContext;
    private provinceList;
    p47: ArrayList<OfflineMapProvince>;
    private q47;
    constructor(context: Context, m47: OfflineMapManager, n47: OfflineMapProvince[]);
    /**
     * 新增任务时，更新gruop列表
     */
    r47(): void;
    /**
     * 删除城市时，更新group列表
     */
    s47(): void;
}
