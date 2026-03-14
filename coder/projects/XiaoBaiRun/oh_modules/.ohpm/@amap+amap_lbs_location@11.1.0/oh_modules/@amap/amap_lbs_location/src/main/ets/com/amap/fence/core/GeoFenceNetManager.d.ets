// @keepTs
// @ts-nocheck
import HashMap from "@ohos.util.HashMap";
/**
 * 创建时间：2016-11-7 下午5:48:27 项目名称：AMapLocationSDK2.0
 *
 * @author liqi
 * @version 1.0
 * @since JDK 1.6.0_21 文件名称：GeoFenceNetManager.java 类说明：
 */
export declare class l1 {
    private j13;
    /**
     * 构造方法
     * @param context
     */
    constructor();
    /**
     * 关键字搜索
     * @param ctx
     * @param url 域名
     * @param keywords 关键字
     * @param types 类型
     * @param city 城市
     * @param offset 每页个数
     * @return
     */
    x10(ctx: Context, url: string, keywords: string, types: string, city: string, offset: string): Promise<string>;
    /**
     * 周边搜索
     * @param ctx
     * @param url 域名
     * @param keywords 关键字
     * @param types 类型
     * @param offset 每页个数
     * @param lat 纬度
     * @param lon 精度
     * @param radius 半径
     * @return
     */
    y10(ctx: Context, url: string, keywords: string, types: string, offset: string, lat: string, lon: string, radius: string): Promise<string>;
    /**
     * 行政区划搜索
     * @param ctx
     * @param url 域名
     * @param keywords 关键字
     * @return
     */
    z10(ctx: Context, url: string, keywords: string): Promise<string>;
    private post;
    /**
     * @param ctx
     * @param keywords
     * @param types
     * @param city
     * @param offset
     * @param lat
     * @param lon
     * @param radius
     * @return
     * @since 3.2.0
     *
     */
    k13(keywords: string, types: string, city: string, offset: string, lat: string, lon: string, radius: string): HashMap<string, string>;
    o13(y12: HashMap<string, string>): string[];
    static getScode(context: Context, u12: string, v12: string): string;
    static n13(): string;
    static p13(params: HashMap<string, string>): string;
}
