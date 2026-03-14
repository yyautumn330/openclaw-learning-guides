// @keepTs
// @ts-nocheck
import fs from '@ohos.file.fs';
export declare class p121 {
    private static readonly TAG;
    private static readonly i122;
    private cacheSize;
    private v124;
    private w124;
    private x124;
    private y124;
    private cacheDir;
    constructor(cacheDir: string, t124: number, u124: number);
    private z124;
    l123(): number;
    m123(): number;
    a123(key: string): fs.File | undefined;
    g123(key: string): fs.File | undefined;
    private a125;
    put(file: string): void;
    c123(file: string): void;
    j123(key: string): boolean;
    clear(): boolean;
    /**
     * Remove the oldest files.
     *
     * @return the size of oldest files, in bytes
     */
    private b125;
}
