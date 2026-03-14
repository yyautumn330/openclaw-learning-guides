// @keepTs
// @ts-nocheck
import { y189 } from "./db/DTInfo";
import { OfflineMapCity } from "../../api/maps/offlinemap/OfflineMapCity";
import { OfflineMapProvince } from "../../api/maps/offlinemap/OfflineMapProvince";
import relationalStore from "@ohos.data.relationalStore";
import ArrayList from "@ohos.util.ArrayList";
export declare class a25 extends y189 {
    static readonly l210: string;
    private x183;
    private context;
    constructor(context: Context);
    static i185(j210: OfflineMapCity, context: Context): a25;
    static k207(h210: OfflineMapProvince, context: Context): a25;
    k187(): relationalStore.ValuesBucket;
    static i187(resultSet: relationalStore.ResultSet | undefined, context: Context): ArrayList<a25>;
    /**
     * 太多写死的字段，这个初始化， 主要是为了fileName
     */
    protected init(): void;
    /**
     * 重置数据到初始化状态
     * 删除数据时会调用
     */
    m210(): void;
    w184(): string | undefined;
    x184(): string | undefined;
    z183(): string;
    y183(d210: string): void;
    /**
     * 解析数据，数据为离线文件.zip.tmp.dt中的数据
     *
     * @param aData
     */
    b205(c210: string): void;
    j207(): void;
    d207(): boolean;
    static f199(b210: object, key: string): string;
}
