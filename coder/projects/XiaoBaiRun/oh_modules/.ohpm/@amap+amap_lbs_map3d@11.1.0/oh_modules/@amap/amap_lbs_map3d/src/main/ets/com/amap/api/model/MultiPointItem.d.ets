// @keepTs
// @ts-nocheck
import { LatLng } from "./LatLng";
/**
 * 海量点中单个点的属性（严格移植）
 * 包含地理位置、自定义数据及唯一标识等信息，用于 MultiPointOverlay 渲染和交互
 * @since 2.2.3
 */
export declare class MultiPointItem {
    private latLng;
    private customerId;
    private title;
    private snippet;
    private object;
    /**
     * 构造一个海量点中的单个点项
     * @param latLng 点的地理坐标
     * @since 2.2.3
     */
    constructor(latLng: LatLng);
    /**
     * 获取该点的地理坐标
     * @returns LatLng 对象，包含 latitude 和 longitude
     * @since 2.2.3
     */
    getLatLng(): LatLng;
    /**
     * 设置该点的地理坐标
     * @param latLng 新的 LatLng 坐标对象
     * @since 2.2.3
     */
    setLatLng(latLng: LatLng): void;
    /**
     * 获取用户自定义的客户ID，可用于去重或业务关联
     * @returns 客户ID字符串或null
     * @since 2.2.3
     */
    getCustomerId(): string | null;
    /**
     * 设置用户自定义的客户ID，优先用于 equals 比较
     * @param customerId 唯一标识符，建议全局唯一
     * @since 2.2.3
     */
    setCustomerId(y38: string | null): void;
    /**
     * 获取该点的标题文本（可选）
     * @returns 标题字符串或null
     * @since 2.2.3
     */
    getTitle(): string | null;
    /**
     * 设置该点的标题文本，常用于提示显示
     * @param title 要设置的标题内容
     * @since 2.2.3
     */
    setTitle(title: string | null): void;
    /**
     * 获取该点的描述片段（可选）
     * @returns 片段文本或null
     * @since 2.2.3
     */
    getSnippet(): string | null;
    /**
     * 设置该点的描述片段，常用于信息窗口展示
     * @param snippet 描述内容
     * @since 2.2.3
     */
    setSnippet(snippet: string | null): void;
    /**
     * 获取绑定到该点的自定义对象数据
     * 可用于存储额外业务信息
     * @returns 任意对象或null
     * @since 2.2.3
     */
    getObject(): object | null;
    /**
     * 绑定自定义对象到该点，便于事件回调时获取上下文
     * @param obj 可序列化或运行时对象
     * @since 2.2.3
     */
    setObject(obj: object | null): void;
    /**
     * 判断两个 MultiPointItem 是否相等
     * 优先比较 customerId，再比较坐标
     * @param other 待比较的对象实例
     * @returns true 表示相等；false 表示不相等
     * @since 2.2.3
     */
    equals(other: object | null): boolean;
    /**
     * 计算该点的哈希值，用于集合类（如 HashMap）中的快速查找
     * 若存在 customerId，则以其字符串生成哈希；否则基于经纬度生成
     * @returns 32位无符号整数形式的哈希码
     * @since 2.2.3
     */
    hashCode(): number;
    /**
     * 使用 DJB2 算法计算字符串的哈希值
     * 内部工具方法，支持 hashCode 实现
     * @param str 输入字符串
     * @returns 32位无符号整数
     * @since 2.2.3
     */
    private hashString;
}
