// @keepTs
// @ts-nocheck
import relationalStore from "@ohos.data.relationalStore";
export interface q185 {
    /**
     * 创建数据库回调，用于初始化创建表相关工作
     * */
    onCreate(store: relationalStore.RdbStore): void;
    /**
     * 数据库升级回调
     * */
    e186(store: relationalStore.RdbStore, oldVersion: number, newVersion: number): void;
    /**
     * 数据库名称
     * */
    i186(): string;
    /**
     * 数据库版本
     * */
    getVersion(): number;
    /**
     * 初始化数据库，会清空所有数据，重新生成新的数据库
     * */
    f186(store: relationalStore.RdbStore): void;
}
