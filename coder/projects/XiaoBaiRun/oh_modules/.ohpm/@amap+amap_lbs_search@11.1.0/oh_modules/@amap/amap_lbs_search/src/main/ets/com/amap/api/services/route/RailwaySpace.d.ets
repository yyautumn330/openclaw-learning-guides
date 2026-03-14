// @keepTs
// @ts-nocheck
/**
 * 列车的舱位及价格信息
 * 舱位：动车分一般为一等软座和二等软座
 * @since V3.4.0
 */
export declare class RailwaySpace {
    private d82;
    private f61;
    /**
     * RailwaySpace构造方法。
     * @param code 舱位编码。
     * @param cost 对应舱位的费用。
     * @since V3.4.0
     * @exclude javadoc中不显示。
     */
    constructor(code: string, c82: number);
    /**
     * 返回舱位编码。
     * @return 舱位编码。
     * @since V3.4.0
     */
    getCode(): string;
    /**
     * 返回对应舱位的费用信息。
     * @return 舱位费用。
     * @since V3.4.0
     */
    getCost(): number;
    /**
     * @exclude javadoc中不显示。
     */
    q2(): number;
}
