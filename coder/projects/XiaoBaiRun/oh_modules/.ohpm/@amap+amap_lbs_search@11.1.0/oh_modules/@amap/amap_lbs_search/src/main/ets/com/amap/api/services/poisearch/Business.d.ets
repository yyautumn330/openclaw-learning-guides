// @keepTs
// @ts-nocheck
/**
 * 定义了一个POI商业信息类。
 */
export declare class Business {
    private c55;
    private b61;
    private c61;
    private i54;
    private d61;
    private e61;
    private f61;
    private d55;
    private g61;
    private h61;
    /**
     * Business 构造方法。
     * @param area            所在商圈
     * @param opentimeToday   今日营业时间
     * @param opentimeWeek    营业时间描述
     * @param tel             电话号码
     * @param tag             特色内容
     * @param rating          评分
     * @param cost            人均消费
     * @param parkType        停车场类型
     * @param alias           别名
     */
    constructor(area: string | undefined, w60: string | undefined, x60: string | undefined, y60: string | undefined, tag: string | undefined, rating: string | undefined, z60: string | undefined, a61: string | undefined, alias: string | undefined);
    /**
     * 所在商圈。
     */
    getBusinessArea(): string | undefined;
    /**
     * 今日营业时间。
     */
    getOpentimeToday(): string | undefined;
    /**
     * 营业时间描述。
     */
    getOpentimeWeek(): string | undefined;
    /**
     * 电话号码。
     */
    getTel(): string | undefined;
    /**
     * 特色内容。
     */
    getTag(): string | undefined;
    /**
     * 评分
     */
    getmRating(): string | undefined;
    /**
     * 人均消费
     */
    getCost(): string | undefined;
    /**
     * 停车场类型
     */
    getParkingType(): string | undefined;
    /**
     * 别名
     */
    getAlias(): string | undefined;
    /**
     * 获取cpid
     */
    getCPID(): string | undefined;
    /**
     * 设置cpid
     */
    setCPID(v60: string | undefined): void;
}
