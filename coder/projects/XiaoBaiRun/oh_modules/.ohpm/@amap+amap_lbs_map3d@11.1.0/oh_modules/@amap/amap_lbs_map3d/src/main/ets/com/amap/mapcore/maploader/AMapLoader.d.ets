// @keepTs
// @ts-nocheck
import { NetworkProxyManager } from '../NetworkProxyManager';
import ArrayList from "@ohos.util.ArrayList";
import HashMap from "@ohos.util.HashMap";
/**
 * 网络下载功能
 */
export declare class p172 {
    static readonly TAG = "AMapLoader";
    private context;
    private s174;
    private static readonly t174;
    private isCanceled;
    private u174;
    private v174;
    private w174;
    private static readonly x174;
    private y174;
    private z174;
    constructor(context: Context, q174: p172.t173, r174: NetworkProxyManager);
    private a175;
    /**
     * 子线程中调用
     */
    b175(): void;
    /**
     * 取消请求连接
     */
    j175(): void;
    /**
     * 取消请求并通知下层引擎
     */
    k175(): void;
    private onCancel;
    /**
     * 返回给定字符串的encode结果
     *
     * @return string
     */
    static m175(j174: string): string;
    /**
     * 生成AOS签名
     *
     * @param signPrams 需要签名的参数
     * @param params 已经确定的参数
     * @return
     */
    static n175(f174: ArrayList<string>, params: string): string;
    private static p175;
    /**
     * 得到请求数据时的参数, 有的数据类型不需要对gridParam进行加密
     */
    protected t101(a174: string, b174: boolean): string;
    /**
     * 单独处理queryString 因为需要构造rest请求需要的ts 和socde
     * @param str 已经确定的参数
     * @return 添加key ts scode的参数
     */
    static q175(context: Context, str: string): string;
    static r175(str: string): string;
    static s175(src: string): string;
    private t175;
    private v175;
}
export declare namespace p172 {
    enum r173 {
        GET = 0,
        POST = 1
    }
    enum s173 {
        CUSTOM = 0,
        FORM = 1
    }
    /**
     * Created by chaiyanrui on 16/10/26.
     */
    class t173 {
        /** 请求url的前缀，包含‘？’ **/
        e175: string;
        /** 请求url的数据块拼接部分**/
        w175: Uint8Array;
        /**
         * 请求头
         */
        headers: HashMap<string, string>;
        /**
         * 请求参数
         */
        x175: HashMap<string, string>;
        /**
         * 需要用于签名字段
         */
        y175: ArrayList<string>;
        /** 请求发起的实例句柄**/
        handler: bigint;
        /** 请求类型，0：GET， 1：POST**/
        f175: number;
        /** 需要进行url encode的字符，如果为空则不需要encode**/
        z175: Uint8Array;
        /** 标记是否压缩**/
        a176: number;
        /**
         * 请求体类型
         */
        b176: number;
    }
}
