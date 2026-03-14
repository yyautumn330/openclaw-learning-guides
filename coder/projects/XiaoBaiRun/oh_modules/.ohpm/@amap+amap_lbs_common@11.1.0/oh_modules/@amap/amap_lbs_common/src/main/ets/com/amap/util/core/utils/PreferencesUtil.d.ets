// @keepTs
// @ts-nocheck
import h51 from '@ohos.data.preferences';
export declare class PreferencesUtil {
    static t94(context: Context): void;
    /**
     * isFlush: true 当前写入值会刷新至文件中持久化，flase 当前写入值仅更新内存中值。
     * @param context
     * @param key
     * @param value
     * @param isFlush
     */
    static putSync(context: Context, key: string, value: h51.ValueType | Array<boolean>, s94?: boolean): void;
    static getSync(context: Context, key: string, r94: h51.ValueType): h51.ValueType | undefined;
    deleteSync(context: Context, key: string): void;
    static flush(context: Context): void;
    observer(context: Context, key: string): void;
    static deletePreferences(context: Context): void;
}
