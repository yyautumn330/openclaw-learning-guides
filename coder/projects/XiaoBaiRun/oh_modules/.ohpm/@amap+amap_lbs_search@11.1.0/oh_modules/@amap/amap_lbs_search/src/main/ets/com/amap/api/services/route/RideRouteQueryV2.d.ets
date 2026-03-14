// @keepTs
// @ts-nocheck
import { AlternativeRoute } from "./AlternativeRoute";
import { FromAndTo } from "./FromAndTo";
/**
 * 此类定义了骑行路径的起终点和计算路径的模式。
 *
 * @since V1.0.0
 */
export declare class RideRouteQueryV2 {
    private s67;
    /**
     * 扩展字段 all表示所有数据 ，默认 cost
     */
    private p77;
    /**
     * 返回路线条数
     */
    private s82;
    /**
     * RideRouteQuery构造函数。
     *
     * @param fromAndTo 路径的起终点。
     * @since V1.0.0
     */
    constructor(r82: FromAndTo);
    /**
     * 返回查询路径的起终点。
     *
     * @return 查询路径的起终点。
     * @since V1.0.0
     */
    getFromAndTo(): FromAndTo;
    /**
     * 扩展字段 all表示所有数据 ，默认 cost {@link ShowFields}
     * @since V1.0.0
     */
    getShowFields(): number;
    /**
     * 扩展字段 all表示所有数据 ，默认 cost {@link ShowFields}
     * @since V1.0.0
     */
    setShowFields(q82: number): void;
    /**
     * 返回路线条数
     *
     * @return
     */
    getAlternativeRoute(): AlternativeRoute;
    /**
     * 设置返回路线条数
     *
     * @param alternativeRoute
     */
    setAlternativeRoute(p82: AlternativeRoute): void;
    /**
     * @exclude javadoc中不显示。
     */
    clone(): RideRouteQueryV2;
}
