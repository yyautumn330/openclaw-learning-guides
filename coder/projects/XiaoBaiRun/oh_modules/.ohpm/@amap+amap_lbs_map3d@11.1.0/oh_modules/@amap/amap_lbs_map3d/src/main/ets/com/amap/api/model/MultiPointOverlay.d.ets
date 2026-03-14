// @keepTs
// @ts-nocheck
import { MultiPointOverlayOptions } from './MultiPointOverlayOptions';
import { MultiPointItem } from './MultiPointItem';
import { BaseOverlay } from './BaseOverlay';
import { d16 } from '../../mapcore/interface/IGLOverlayLayer';
/**
 * 海量点管理对象（严格移植自 Android Java 版）
 * 用于高效渲染大量点标记（如10万+），通过 native 层优化性能
 * @since 2.2.3
 */
export declare class MultiPointOverlay extends BaseOverlay {
    private options;
    glOverlayLayer: d16;
    /**
     * 构造一个海量点图层实例
     * @param glOverlayLayer 图层代理接口，用于与 native 层通信
     * @param options 图层配置项，包含图标、锚点、数据等
     * @param overlayName 图层唯一名称，用于 native 层识别和更新
     * @since 2.2.3
     */
    constructor(e39: d16, options: MultiPointOverlayOptions, f39: string);
    /**
     * 设置海量点的数据集合（同步方法，大数据建议在子线程中准备）
     * 会触发图层重绘
     * @param items MultiPointItem 对象数组，包含坐标和自定义数据
     * @since 2.2.3
     */
    setItems(items: Array<MultiPointItem>): void;
    /**
     * 获取当前设置的海量点数据集合
     * @returns MultiPointItem 数组或 null（若 options 未初始化）
     * @since 2.2.3
     */
    getItems(): Array<MultiPointItem> | null;
    /**
     * 设置图层中所有点的统一锚点位置（相对于图标）
     * 注意：Android 默认锚点为 (0.5, 1.0)，即底部居中
     * @param anchorX 横向锚点比例，0=左对齐，0.5=居中，1=右对齐
     * @param anchorY 纵向锚点比例，0=顶部，0.5=垂直居中，1=底部
     * @since 2.2.3
     */
    setAnchor(c39: number, d39: number): void;
    /**
     * 设置图层是否启用显示
     * 可动态控制可见性
     * @param enable true 表示显示；false 表示隐藏
     * @since 2.2.3
     */
    setEnable(enable: boolean): void;
    /**
     * 将该图层从地图上移除
     * 移除后不可再使用，需重新添加
     * @since 2.2.3
     */
    remove(): void;
    /**
     * 销毁图层资源，释放 native 层内存
     * 调用后该实例不可再使用
     * @since 2.2.3
     */
    destroy(): void;
    /**
     * 更新 native 层的图层选项
     * 内部方法，用于同步 options 变更到 C++ 渲染层
     * @since 2.2.3
     */
    private updateOption;
    /**
     * 模拟 native 调用（参数类型安全，无 any/unknown）
     * 实际通过 IGLOverlayLayer 代理到 native 层（C++/JNI）
     * 支持的方法包括：updateOption、removeOverlay
     * @param method 方法名
     * @param args 参数列表，类型安全校验后转发
     * @since 2.2.3
     */
    private callNativeUpdate;
}
