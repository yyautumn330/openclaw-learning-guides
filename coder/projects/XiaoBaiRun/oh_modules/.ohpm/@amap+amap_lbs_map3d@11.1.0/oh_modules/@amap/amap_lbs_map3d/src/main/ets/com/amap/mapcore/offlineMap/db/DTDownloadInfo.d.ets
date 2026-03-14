// @keepTs
// @ts-nocheck
import relationalStore from "@ohos.data.relationalStore";
export declare class k186 {
    private c189;
    private d189;
    private e189;
    private startPos;
    private endPos;
    constructor(z188: string, a189: number, b189: number, startPos: number, endPos: number);
    f189(index: number): number;
    h189(index: number): number;
    /**
     * 根据adcode查询，where部分
     *
     * @param adCode
     * @return
     */
    static j189(y188: string): string;
    l185(): string;
    m188(x188: string): void;
    k189(): number;
    l189(w188: number): void;
    m189(): number;
    n189(v188: number): void;
    g189(): number;
    o189(startPos: number): void;
    i189(): number;
    p189(endPos: number): void;
    k187(): relationalStore.ValuesBucket;
}
