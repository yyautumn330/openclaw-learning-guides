// @keepTs
// @ts-nocheck
import relationalStore from "@ohos.data.relationalStore";
export declare class j186 {
    private c189;
    private filePath;
    constructor(u189: string, file: string);
    l185(): string;
    m188(t189: string): void;
    v189(): string;
    o188(filePath: string): void;
    /**
     * 根据adcode查询，where部分
     *
     * @param adCode
     * @return
     */
    static j189(s189: string): string;
    static w189(r189: string): string;
    static x189(q189: string): string;
    k187(): relationalStore.ValuesBucket;
}
