// @keepTs
// @ts-nocheck
import { q185 } from "./DBCreator";
import ArrayList from "@ohos.util.ArrayList";
import relationalStore from "@ohos.data.relationalStore";
import { a25 } from "../UpdateItem";
import { j186 } from "./DTFileInfo";
export declare class l186 {
    private d187?;
    private a186?;
    e187?: relationalStore.RdbStore;
    private context;
    /**
     * 创建数据库，数据库位于dada/data下的私有目录
     *
     * */
    constructor(context: Context, c187: q185);
    c186(): Promise<void>;
    f187(): relationalStore.RdbStore | undefined;
    /**
     * 获取String String方式的查询串
     */
    /**
     * 删除数据
     *
     * @param sql 删除条件
     * @param t   删除实体类
     */
    deleteData<T>(sql: string, b187: string): void;
    /**
     * @deprecated 未开发完整，不要使用
     */
    g187<T>(predicates: relationalStore.RdbPredicates, tableName: string, x186?: boolean): ArrayList<T>;
    insertData(object: object, w186?: boolean): void;
    /**
     * 批量插入功能（已开启事物）
     *
     * @param entities 要插入的实体
     */
    l187(entities: ArrayList<j186>): void;
    private g186;
    private h186;
    m187(r186: a25): void;
    k187(object: object): relationalStore.ValuesBucket;
    static j187(object: object): string;
    private h187;
}
