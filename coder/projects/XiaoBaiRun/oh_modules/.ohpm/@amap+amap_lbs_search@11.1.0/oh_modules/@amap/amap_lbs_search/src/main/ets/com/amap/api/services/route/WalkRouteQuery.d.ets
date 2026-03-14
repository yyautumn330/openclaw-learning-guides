// @keepTs
// @ts-nocheck
import { FromAndTo } from './FromAndTo';
/**
 * 此类定义了步行路径的起终点和计算路径的模式。
 *
 * @since V2.1.0
 */
export declare class WalkRouteQuery {
    private s67;
    /**
     * 扩展字段 base表示只返回基础数据，all表示所有数据 ，默认 base
     */
    private z2;
    /**
     * WalkRouteQuery构造函数。
     *
     * @param fromAndTo 路径的起终点。
     * @since 5.0.0
     */
    constructor(e88: FromAndTo);
    /**
     * 返回查询路径的起终点。
     *
     * @return 查询路径的起终点。
     * @since V2.1.0
     */
    getFromAndTo(): FromAndTo;
    /**
     * 返回计算路径的模式。
     *
     * @return 计算路径的模式。
     * @since V2.1.0
     * @deprecated 步行路径规划升级，废弃模式选择
     */
    /**
     * 扩展字段 base表示只返回基础数据，all表示所有数据 ，默认 base
     * @since 7.6.0
     */
    getExtensions(): string;
    /**
     * 扩展字段 base表示只返回基础数据，all表示所有数据 ，默认 base
     * @since 7.6.0
     */
    setExtensions(extensions: string): void;
    /**
     * @exclude javadoc中不显示。
     */
    q2(): number;
    clone(): WalkRouteQuery;
}
