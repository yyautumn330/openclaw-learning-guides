// @keepTs
// @ts-nocheck
/**
 * 纹理覆盖物配置类
 *
 * 对应原生 Android 功能：
 * - 管理覆盖物纹理资源
 * - 定义纹理尺寸和锚点比例
 */
export declare class h157 {
    y164: number;
    z164: number;
    a165: number;
    /** 图标真实宽高*/
    b165: number;
    c165: number;
    /** 锚点对应原始图片X坐标的比例值*/
    d165: number;
    /** 锚点对应原始图片Y坐标的比例值*/
    e165: number;
    l94: number;
    /**
     * 构造纹理配置
     * @param resID 资源标识符
     * @param anchor 锚点模式
     * @param w 绘制宽度
     * @param h 绘制高度
     * @param xRatio 锚点X比例（可选）
     * @param yRatio 锚点Y比例（可选）
     */
    constructor(v164: number, anchor: number, w: number, h: number, w164?: number, x164?: number);
    /**
     * 获取锚点坐标（基于原始资源尺寸）
     */
    f165(): [
        number,
        number
    ];
}
