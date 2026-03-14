// @keepTs
// @ts-nocheck
export declare class InitStorageParam {
    private static readonly z34;
    private static readonly a35;
    private static b35;
    version: number;
    maxFileCount: number;
    maxFileSize: number;
    path: string;
    private constructor();
    static obtain(): InitStorageParam;
    static create(version: number, path: string, v34: number, w34: number): InitStorageParam;
    static c35(path: string): void;
    toString(): string;
}
