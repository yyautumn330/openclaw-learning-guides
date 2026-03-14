// @keepTs
// @ts-nocheck
/**
* 基础属性
* @since 1.0.0
*/
import HashMap from '@ohos.util.HashMap';
/**
 * Polyline尾部形状
 *
 */
export declare enum LineCapType {
    LineCapButt = 0,
    LineCapSquare = 1,
    LineCapArrow = 2,
    LineCapRound = 3
}
/**
 * Polyline连接处形状
 *
 * @since 1.0.0
 */
export declare enum LineJoinType {
    LineJoinBevel = 0,
    LineJoinMiter = 1,
    LineJoinRound = 2
}
export declare enum DottedLineType {
    /**
     * 虚线类型：不画虚线，值为-1；
     * @since 1.0.0
     */
    DOTTEDLINE_TYPE_DEFAULT = -1,
    /**
     * 虚线类型：方形，值为0；
     * @since 1.0.0
     */
    DOTTEDLINE_TYPE_SQUARE = 0,
    /**
     * 虚线类型：圆形，值为1；
     * @since 1.0.0
     */
    DOTTEDLINE_TYPE_CIRCLE = 1
}
export declare class BaseOptions {
    /**
     * @exclude javadoc中不显示
     */
    protected type: string;
    toJson(): string;
    protected jsonMap: HashMap<string, object>;
    private lastJsonMap;
    /**
     * 添加属性，会带有对比
     * @param fieldName 属性名称
     * @param value 内容
     * @param forceUpdate 如果为true 则不会和上一次的value对比直接添加
     */
    protected addIfPresent(fieldName: string, value: object, a22?: boolean): void;
}
export declare class BaseUpdateFlags {
    zIndexUpdate: boolean;
    reset(): void;
}
