// @keepTs
// @ts-nocheck
import { FromAndTo } from "./FromAndTo";
/**
 * 此类定义了骑行路径的起终点和计算路径的模式。
 *
 * @since V1.0.0
 */
export declare class RideRouteQuery {
    private s67;
    private t67;
    /**
     * 扩展字段 base表示只返回基础数据，all表示所有数据 ，默认 base
     */
    private z2;
    /**
     * RideRouteQuery构造函数。
     *
     * @param fromAndTo 路径的起终点。
     * @param mode      计算路径的模式。可选，默认为推荐路线及最快路线综合。
     * @since V1.0.0
     */
    /**
     * RideRouteQuery构造函数。
     *
     * @param fromAndTo 路径的起终点。
     * @since 5.0.0
     */
    constructor(n82: FromAndTo, mode?: number);
    /**
     * 返回查询路径的起终点。
     *
     * @return 查询路径的起终点。
     * @since V1.0.0
     */
    getFromAndTo(): FromAndTo;
    /**
     * 返回计算路径的模式。
     *
     * @return 计算路径的模式。
     * @since V1.0.0
     * @deprecated 骑行路径规划升级，废弃模式选择
     */
    getMode(): number;
    /**
     * 扩展字段 base表示只返回基础数据，all表示所有数据 ，默认 base
     * @since V1.0.0
     */
    getExtensions(): string;
    /**
     * 扩展字段 base表示只返回基础数据，all表示所有数据 ，默认 base
     * @since V1.0.0
     */
    setExtensions(extensions: string): void;
    /**
     * @exclude javadoc中不显示。
     */
    clone(): RideRouteQuery;
}
