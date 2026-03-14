// @keepTs
// @ts-nocheck
/**
 * 日志内容模板
 * @author yjl215
 * @date 2024/11/19 17:04
 */
import { j17 } from "../../statistics/UpdateStrategy";
export declare class a15 extends j17 {
    static readonly c18: number;
    protected o17: number;
    protected d18: number;
    private q17;
    private isForce;
    private r17;
    private t17;
    constructor(a18: boolean, interval: number, strategy: j17, uploadedSize: number, b18: number);
    u17(): number;
    q16(force: boolean): void;
    v17(z17: number): void;
    w17(): number;
    protected x17(): boolean;
}
