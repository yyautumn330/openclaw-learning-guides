// @keepTs
// @ts-nocheck
import { FromAndTo } from './FromAndTo';
export declare class AlternativeRoute {
    static ALTERNATIVE_ROUTE_ONE: number;
    static ALTERNATIVE_ROUTE_TWO: number;
    static ALTERNATIVE_ROUTE_THREE: number;
}
/**
 * 此类定义了步行路径的起终点和计算路径的模式。
 *
 * @since V9.4.0
 */
export declare class WalkRouteQueryV2 {
    private s67;
    /**
     * 扩展字段，默认 Cost
     * 可以组合
     */
    private p77;
    /**
     * 是否需要室内算路
     */
    private j88;
    /**
     * 返回路线条数
     */
    private s82;
    /**
     * WalkRouteQuery构造函数。
     *
     * @param fromAndTo 路径的起终点。
     * @since 9.4.0
     */
    constructor(i88: FromAndTo);
    /**
     * 返回查询路径的起终点。
     *
     * @return 查询路径的起终点。
     * @since V9.4.0
     */
    getFromAndTo(): FromAndTo;
    /**
     * 是否需要室内算路
     *
     * @return
     */
    getIsIndoor(): boolean;
    /**
     * 设置是否需要室内算路
     *
     * @param indoor
     */
    k88(h88: boolean): void;
    /**
     * 返回路线条数
     *
     * @return
     */
    getAlternativeRoute(): number;
    /**
     * 设置返回路线条数
     *
     * @param alternativeRoute
     */
    setAlternativeRoute(g88: number): void;
    /**
     * 扩展字段 {@link ShowFields}
     * @since 9.4.0
     */
    getShowFields(): number;
    /**
     * 扩展字段 {@link ShowFields}
     * @since 9.4.0
     */
    setShowFields(f88: number): void;
    /**
     * @exclude javadoc中不显示。
     */
    q2(): number;
    /**
     * @exclude javadoc中不显示。
     */
    clone(): WalkRouteQueryV2;
}
