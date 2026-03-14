// @keepTs
// @ts-nocheck
/**
 * 扩展字段
 */
export declare class ShowFields {
    /**
     * 设置后可返回方案所需时间及费用成本
     */
    static readonly COST: number;
    /**
     * 设置后可返回分段路况详情
     */
    static readonly TMCS: number;
    /**
     * 设置后可返回详细导航动作指令
     */
    static readonly NAVI: number;
    /**
     * 设置后可返回分段途径城市信息
     */
    static readonly CITIES: number;
    /**
     * 设置后可返回分路段坐标点串，两点间用“,”分隔
     */
    static readonly POLINE: number;
    /**
     * 设置后返回电量消耗信息
     *
     * @internal
     */
    static readonly g12: number;
    /**
     * 设置后返回充电桩信息
     *
     * @internal
     */
    static readonly h12: number;
    /**
     * 设置后添加所有字段
     */
    static readonly ALL: number;
}
