// @keepTs
// @ts-nocheck
import { FromAndTo } from "./FromAndTo";
export declare class BusRouteQuery {
    private s67;
    private t67;
    private b60;
    private u67?;
    private v67;
    /**
     * 扩展字段 base表示只返回基础数据，all表示所有数据 ，默认 base
     */
    private z2;
    /**
     * BusRouteQuery构造函数。
     *
     * @param fromAndTo 路径的起终点。
     * @param mode      计算路径的模式。可选，默认为最快捷 {@link RouteSearch#BusDefault}。
     * @param city      城市名称/城市区号/电话区号。此项不能为空。
     * @param nightFlag 是否计算夜班车，默认为不计算。0：不计算，1：计算。可选。
     * @since V2.1.0
     */
    constructor(q67: FromAndTo, mode: number, city: string, r67: number);
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
     */
    getMode(): number;
    /**
     * 返回查询的城市。
     *
     * @return 查询的城市。
     * @since V2.1.0
     */
    getCity(): string;
    /**
     * 返回是否计算夜班车。
     *
     * @return 是否计算夜班车，默认为不计算。0：不计算，1：计算。可选。
     * @since V2.1.0
     */
    getNightFlag(): number;
    /**
     * 返回目的地的城市（跨城公交路径规划）。
     *
     * @return 目的地的城市。
     * @since V3.4.0
     */
    getCityd(): string;
    /**
     * 设置跨城公交规划的目的地城市。
     *
     * @param cityd 目的地城市。跨城公交规划必填参数。可选值：城市名称/citycode
     * @since V3.4.0
     */
    setCityd(p67: string): void;
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
    /**
     * @exclude javadoc中不显示。
     */
    clone(): BusRouteQuery;
}
