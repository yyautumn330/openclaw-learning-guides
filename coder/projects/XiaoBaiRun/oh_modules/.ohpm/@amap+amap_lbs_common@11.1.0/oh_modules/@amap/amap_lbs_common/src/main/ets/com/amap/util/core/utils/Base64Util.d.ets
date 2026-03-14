// @keepTs
// @ts-nocheck
export declare class Base64Util {
    static i81(data: string): string;
    static encodeBase64Uint8ArrayToString(source: Uint8Array | undefined): string;
    static j81(source: Uint8Array, off: number, len: number, options: number): string;
    static k81(source: Uint8Array, off: number, len: number, options: number): Uint8Array;
    static m81(source: Uint8Array, r80: number, s80: number, destination: Uint8Array, t80: number, options: number): Uint8Array;
    static n81(options: number): Uint8Array;
    static fromSelfBase64(data: string): string;
    static u38(data: string): string;
    static o81: Uint8Array;
    static w38(): void;
    static decodeBase642Uint8Array(source: string): Uint8Array;
    static p81(data: string): Uint8Array | undefined;
    static q81(d80: Uint8Array, data: Uint8Array, iv: Uint8Array): Uint8Array;
    static a73(string: string): Uint8Array | undefined;
}
