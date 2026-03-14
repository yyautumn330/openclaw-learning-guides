// @keepTs
// @ts-nocheck
/**
 * AAID 字段缓存管理
 */
export declare class u1 {
    /**
     * 获取UUID
     * @param context
     * @return
     */
    static q3(context: Context): Promise<string>;
    /**
     * 保存UUID信息
     * @param context
     * @param uuid
     */
    static r3(context: Context, uuid: string): Promise<void>;
    /**
     * 保存本次获取的OAID信息
     * @param context
     * @param oaid
     */
    static u3(context: Context, k3: string): Promise<void>;
    /**
     * 获取上次缓存的OAID信息
     * @param context
     * @return
     */
    static v3(context: Context): Promise<string>;
    /**
     * SP 存储AAID
     * @param context
     * @param aaid
     */
    static w3(context: Context, aaid: string): Promise<void>;
    /**
     * 获取上次缓存的AAID
     * @param context
     * @return
     */
    static x3(context: Context): Promise<string>;
    /**
     * 保存aaid最近一次更新时间
     * @param context
     * @param aaidUpdateTime
     */
    static y3(context: Context, f3: number): Promise<void>;
    /**
     * 获取最近一次aaid更新时间
     * @param context
     * @return
     */
    static z3(context: Context): Promise<number>;
    /**
     * 保存AAID res下发的uabc信息
     * @param context
     * @param uabc
     */
    static a4(context: Context, c3: string): Promise<void>;
    /**
     * 获取上次AAID res uabc信息
     * @param context
     * @return
     */
    static b4(context: Context): Promise<string>;
    /**
     * 保存上次AAID res resetToken
     * @param context
     * @param resetToken
     */
    static c4(context: Context, z2: string): Promise<void>;
    /**
     * 获取上次AAID res resetToken
     * @param context
     * @return
     */
    static d4(context: Context): Promise<string>;
    /**
     * 保存T1
     * @param context
     * @param t1
     */
    static e4(context: Context, u2: string): Promise<void>;
    /**
     * 获取T1信息
     * @param context
     * @return
     */
    static f4(context: Context): Promise<string>;
    /**
     * 保存T2
     * @param context
     * @param t2
     */
    static g4(context: Context, r2: string): Promise<void>;
    /**
     * 获取T2信息
     * @param context
     * @return
     */
    static h4(context: Context): Promise<string>;
    /**
     * 保存T3
     * @param context
     * @param t3
     */
    static i4(context: Context, n2: string): Promise<void>;
    /**
     * 获取T3信息
     * @param context
     * @return
     */
    static j4(context: Context): Promise<string>;
    /**
     * 保存S1
     * @param context
     * @param s1
     */
    static l4(context: Context, k2: string): Promise<void>;
    /**
     * 获取S1信息
     * @param context
     * @return
     */
    static m4(context: Context): Promise<string>;
    /**
     * 保存S2
     * @param context
     * @param s2
     */
    static n4(context: Context, h2: string): Promise<void>;
    /**
     * 获取S2信息
     * @param context
     * @return
     */
    static o4(context: Context): Promise<string>;
    /**
     * 保存S3
     * @param context
     * @param s3
     */
    static q4(context: Context, e2: string): Promise<void>;
    /**
     * 获取S3信息
     * @param context
     * @return
     */
    static r4(context: Context): Promise<string>;
    /**
     * 保存S4
     * @param context
     * @param s4
     */
    static t4(context: Context, b2: string): Promise<void>;
    /**
     * 获取S4信息
     * @param context
     * @return
     */
    static u4(context: Context): Promise<string>;
    /**
     * 保存上次请求AAID时的gaid信息
     * @param context
     * @param gaid
     */
    static v4(context: Context, w1: string): Promise<void>;
    /**
     * 获取上次请求AAID时的gaid信息
     * @param context
     * @return
     */
    static w4(context: Context): Promise<string>;
}
