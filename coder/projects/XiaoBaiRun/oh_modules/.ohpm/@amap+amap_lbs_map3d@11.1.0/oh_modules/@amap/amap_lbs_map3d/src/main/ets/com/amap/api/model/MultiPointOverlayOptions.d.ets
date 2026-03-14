// @keepTs
// @ts-nocheck
import { BitmapDescriptor } from './BitmapDescriptor';
import { MultiPointItem } from './MultiPointItem';
import { BaseOptions } from './BaseOptions';
/**
 * 海量点选项类（自 Android）
 * 用于配置 MultiPointOverlay 的图标、锚点、数据等属性
 * 所有设置方法链式调用，最后通过 overlay 应用到地图
 * @since 2.2.3
 */
export declare class MultiPointOverlayOptions extends BaseOptions {
    private resource;
    private bitmapDescriptor;
    private anchorU;
    private anchorV;
    private enable;
    private multiPointItems;
    private multiPointItemsUpdated;
    /**
     * 构造海量点图层的配置选项
     * 默认使用系统标记图标，锚点位于底部居中 (0.5, 1.0)，图层默认启用
     * @since 2.2.3
     */
    constructor();
    /**
     * 设置图标在地理坐标上的锚点位置（相对于图标自身宽高）
     * 控制图标哪一部分对准地理点位
     * @param u 水平比例，取值范围 [0, 1]，0=左边缘，0.5=水平中心，1=右边缘
     * @param v 垂直比例，取值范围 [0, 1]，0=顶部，0.5=垂直中心，1=底部
     * @returns 当前 Options 实例，支持链式调用
     * @since 2.2.3
     */
    anchor(h39: number, v: number): MultiPointOverlayOptions;
    /**
     * 获取当前设置的水平锚点比例
     * @returns anchorU 值，范围 [0, 1]
     * @since 2.2.3
     */
    getAnchorU(): number;
    /**
     * 获取当前设置的垂直锚点比例
     * @returns anchorV 值，范围 [0, 1]
     * @since 2.2.3
     */
    getAnchorV(): number;
    /**
     * 设置所有点使用的统一图标
     * 图标由 BitmapDescriptor 定义，可来自资源文件或内存
     * @param descriptor 图标描述对象，不能为空
     * @returns 当前 Options 实例，支持链式调用
     * @since 2.2.3
     */
    icon(descriptor: BitmapDescriptor): MultiPointOverlayOptions;
    /**
     * 获取当前设置的图标描述对象
     * @returns BitmapDescriptor 实例，表示统一图标
     * @since 2.2.3
     */
    getIcon(): BitmapDescriptor;
    /**
     * 设置要渲染的海量点数据集合
     * 数据变更后需调用 MultiPointOverlay.setItems() 或 updateOption 生效
     * @param items MultiPointItem 对象数组，包含坐标和附加信息
     * @since 2.2.3
     */
    setMultiPointItems(items: Array<MultiPointItem>): void;
    /**
     * 获取当前配置中的海量点数据集合
     * @returns MultiPointItem 数组（引用副本，非深拷贝）
     * @since 2.2.3
     */
    getMultiPointItems(): Array<MultiPointItem>;
    /**
     * 设置图层是否启用显示
     * 可用于动态控制可见性
     * @param enable true 表示显示；false 表示隐藏
     * @since 2.2.3
     */
    setEnable(enable: boolean): void;
    /**
     * 获取图层当前是否启用显示
     * @returns true 表示启用；false 表示禁用
     * @since 2.2.3
     */
    getEnable(): boolean;
    /**
     * 克隆当前选项实例（浅拷贝）
     * 严格遵循 Android 版本行为：仅复制字段引用，不深拷贝对象
     * 主要用于配置备份或跨线程传递
     * @returns 新的 MultiPointOverlayOptions 实例，属性与原对象一致
     * @since 2.2.3
     */
    clone(): MultiPointOverlayOptions;
}
