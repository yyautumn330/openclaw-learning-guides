// @keepTs
// @ts-nocheck
/**
 * 日志内容模板
 * @author yjl215
 * @date 2024/11/19 16:28
 */
export declare class l14 {
    static q14: number;
    static r14: number;
    private detail;
    private type;
    private s14;
    private session;
    private constructor();
    static t14(session: string, detail: string): l14;
    static u14(session: string, detail: string): l14;
    static getType(type: number): string;
    static isValid(p14: l14): boolean;
    static w14(o14: l14): string;
    static x14(list: l14[]): string;
    getType(): number;
    v14(): string;
    getSession(): string;
    y14(): string;
}
