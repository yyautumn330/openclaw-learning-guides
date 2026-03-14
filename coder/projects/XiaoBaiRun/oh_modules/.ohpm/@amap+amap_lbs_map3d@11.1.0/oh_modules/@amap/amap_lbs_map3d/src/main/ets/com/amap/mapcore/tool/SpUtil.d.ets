// @keepTs
// @ts-nocheck
import f251 from '@ohos.data.preferences';
export declare class u215 {
    static j251(context: Context, i251: string): void;
    /**
     * isFlush: true 当前写入值会刷新至文件中持久化，flase 当前写入值仅更新内存中值。
     * @param context
     * @param key
     * @param value
     * @param isFlush
     */
    static putSync(context: Context, fileName: string, key: string, value: f251.ValueType | Array<boolean>, h251?: boolean): void;
    static flush(context: Context, fileName: string): void;
    static getSync(context: Context, fileName: string, key: string, g251: f251.ValueType): f251.ValueType | undefined;
    deleteSync(context: Context, fileName: string, key: string): void;
}
