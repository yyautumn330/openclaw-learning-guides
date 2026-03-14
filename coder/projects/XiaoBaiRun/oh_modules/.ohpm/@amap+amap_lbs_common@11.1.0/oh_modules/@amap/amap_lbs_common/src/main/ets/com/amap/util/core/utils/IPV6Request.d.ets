// @keepTs
// @ts-nocheck
import Request from "@system.request";
/**
 * 支持自动将ipv4的域名增加前缀
 */
export declare abstract class v9 extends Request {
    /**
     * ipv6相比于ipv4的前缀
     */
    private static readonly z90;
    /**
     * 解析 URL 字符串为对象
     * @param urlStr URL 字符串
     * @return 解析后的 URL 对象
     */
    private static l46;
    /**
     * 很重要。为是否支持ipv6的开关。如果为false，则只会进行ipv4请求
     */
    a91(): boolean;
    /**
     * 根据URL规则，自动为ipv4域名增加ipv6前缀
     * @return 转换后的URL
     */
    p49(): string;
    /**
     * 获取当前的请求URL
     * @return 请求URL字符串
     */
    abstract d10(): string;
}
