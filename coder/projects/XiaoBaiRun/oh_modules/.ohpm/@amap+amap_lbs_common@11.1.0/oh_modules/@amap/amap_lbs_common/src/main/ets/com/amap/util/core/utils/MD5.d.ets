// @keepTs
// @ts-nocheck
export declare class MD5 {
    private static readonly w9;
    static getMd5StandardString(source: string | null): string;
    static n94(data: string): string;
    static getMD5StringSync(input: string): string;
    static getMd5String(input: string): Promise<string>;
    /**
     * 生成md5
     * @param input
     * @returns
     */
    static o94(input: Uint8Array): Promise<Uint8Array>;
    static getCoreMd5StandardString(source: string): Promise<string>;
}
