// @keepTs
// @ts-nocheck
import { q185 } from "./DBCreator";
import relationalStore from "@ohos.data.relationalStore";
export declare class r185 {
    private context?;
    private a186?;
    private b186?;
    constructor(context: Context, name: string, version: number, z185: q185);
    c186(): Promise<void>;
    onCreate(w185: relationalStore.RdbStore): void;
    e186(t185: relationalStore.RdbStore, u185: number, v185: number): void;
    f186(s185: relationalStore.RdbStore): void;
    g186(): relationalStore.RdbStore | undefined;
    h186(): relationalStore.RdbStore | undefined;
}
