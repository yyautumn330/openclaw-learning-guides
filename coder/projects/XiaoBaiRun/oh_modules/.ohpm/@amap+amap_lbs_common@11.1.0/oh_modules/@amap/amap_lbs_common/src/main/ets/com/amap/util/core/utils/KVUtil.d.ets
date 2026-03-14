// @keepTs
// @ts-nocheck
export declare class KVUtil {
    private mContext;
    private options;
    constructor(context: Context);
    f91(key?: string, value?: Uint8Array | string | number | boolean): void;
    getValue(key: string): boolean | string | number | Uint8Array | undefined;
    deleteValue(key: string): void;
}
