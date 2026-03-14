// @keepTs
// @ts-nocheck
/**
 * Adiu存储组件类
 *
 * @author dong.sun
 * @see #syncGetAdiu()
 * @see #syncSetAdiu(String, int)
 */
import ArrayList from '@ohos.util.ArrayList';
export declare class e39 {
    /**
     * 内存缓存adius
     */
    private g39;
    /**
     * 存储adiu字段KEY名称
     */
    private mKey;
    private readonly mContext;
    /**
     * 存储类型-Setting.System The caller is expected to have the {@link android.Manifest.permission#WRITE_SETTINGS}
     * permission declared.
     */
    static readonly h39: number;
    /**
     * 存储类型—SD卡文件
     */
    static readonly i39: number;
    /**
     * 存储类型—SharedPreference
     */
    static readonly j39: number;
    static readonly k39: string;
    private static instance;
    static getInstance(context: Context): e39;
    private constructor();
    /**
     * 设置存储adiu值的key
     *
     * @param key 已经过MD5加密处理
     */
    l39(key: string | null): void;
    m39(): ArrayList<string> | undefined;
    setAdiu(f39: string): void;
    /*****************************************存储组件获取*****************************************/
    /**
     * 同步从存储组件中获取adiu值
     */
    private n39;
    /**
     * 同步保存adiu值到存储组件
     *
     */
    private o39;
}
