// @keepTs
// @ts-nocheck
import { q185 } from "./DBCreator";
import relationalStore from "@ohos.data.relationalStore";
export declare class y47 implements q185 {
    static readonly d186 = "offlineDbV4.db";
    static readonly o187 = "update_item";
    static readonly p187 = "update_item_file";
    static readonly q187 = "update_item_download_info";
    /** 存储个城市下载状态的表*/
    static readonly r187 = "title";
    static readonly s187 = "url";
    static readonly t187 = "mAdcode";
    static readonly v187 = "fileName";
    static readonly w187 = "version";
    static readonly y187 = "lLocalLength";
    static readonly a188 = "lRemoteLength";
    static readonly c188 = "localPath";
    static readonly e188 = "mIndex";
    static readonly g188 = "isProvince";
    static readonly h188 = "mCompleteCode";
    static readonly j188 = "mCityCode";
    static readonly k188 = "mState";
    static readonly l188 = "mPinyin";
    /** 存储个城市与其对应离线数据文件的表*/
    static readonly n188 = "mAdcode";
    static readonly p188 = "file";
    /** 存放下载状态的表*/
    static readonly q188 = "mAdcode";
    static readonly r188 = "fileLength";
    static readonly s188 = "splitter";
    static readonly t188 = "startPos";
    static readonly u188 = "endPos";
    private static readonly y190;
    private static readonly z190;
    private static readonly a191;
    private static b191;
    constructor();
    onCreate(x190: relationalStore.RdbStore): void;
    static getInstance(): y47;
    i186(): string;
    getVersion(): number;
    f186(w190: relationalStore.RdbStore): void;
    e186(t190: relationalStore.RdbStore, u190: number, v190: number): void;
}
