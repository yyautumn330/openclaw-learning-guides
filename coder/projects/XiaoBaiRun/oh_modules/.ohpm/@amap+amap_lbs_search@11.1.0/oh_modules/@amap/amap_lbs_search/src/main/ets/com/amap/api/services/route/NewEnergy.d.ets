// @keepTs
// @ts-nocheck
import { b72 } from "./CustomCostMode";
export declare class y76 {
    /**
     * 标识厂商信息
     */
    private key?;
    /**
     * costmodelswitch+相关参数
     */
    private o80?;
    /**
     * 电动汽车的最大电量负荷（浮点型）
     */
    private p80;
    /**
     * 当前电量（浮点型）
     */
    private q80;
    /**
     * 车重（单位kg）
     */
    private load;
    /**
     * 离开充电站前允许的剩余电量
     */
    private r80;
    /**
     * 到达充电站时允许的最小电量
     */
    private s80;
    /**
     *  到达目的地时允许的最小电量，默认值：0
     */
    private t80;
    /**
     * 以 JSON 形式，传入充电效率相关参数及开关
     * 为车企的新能源车能源充电模型，为一个比较专业的参数，同时模型参数值有比较严格的规范，不可以随意修改，现提供一份数据模型：
     * {
     *     "id": "default", --不能为空，如果没有对应项目，则传"default",使用默认模型，如有项目，则传项目id，如"audi_C040X"
     *      "charging_curve": "{
     *           "soc":[0,30,60,90,100], --当前电量百分比, 类型：数字
     *           "power":[180,150,120,90]}" --当前电量百分比下的充电功率，类型：数字, 单位kw
     *       }",
     *      "charging_time_offset": 10 --充电操作时间, 类型：数字，单位秒，小于0无效
     * }
     */
    private u80?;
    /**
     * 到达途径点时允许的最小电量
     * 若填写该值，则途经点允许最小电量以该值为准
     * 到达途经点最低电量百分比，仅支持充电站和自定义充电站
     */
    private v80;
    /**
     * 获取标识厂商信息
     *
     * @return 标识厂商信息
     * @exclude javadoc中不包含
     */
    getKey(): string;
    /**
     * 设置标识厂商信息
     *
     * @param key 标识厂商信息
     * @exclude javadoc中不包含
     */
    w80(key: string): void;
    /**
     * 获取costmodelswitch+相关参数
     *
     * @return costmodelswitch+相关参数
     * @exclude javadoc中不包含
     */
    x80(): b72;
    /**
     * 设置costmodelswitch+相关参数
     *
     * @param customCostMode costmodelswitch+相关参数
     * @exclude javadoc中不包含
     */
    y80(n80: b72): void;
    /**
     * 设置电动汽车的最大电量负荷（浮点型）
     *
     * @return 电动汽车的最大电量负荷（浮点型）
     * @exclude javadoc中不包含
     */
    z80(): number;
    /**
     * 设置电动汽车的最大电量负荷（浮点型）
     *
     * @param maxVehicleCharge 电动汽车的最大电量负荷（浮点型）
     * @exclude javadoc中不包含
     */
    a81(m80: number): void;
    /**
     * 获取当前电量（浮点型）
     *
     * @return 当前电量（浮点型）
     * @exclude javadoc中不包含
     */
    b81(): number;
    /**
     * 设置当前电量（浮点型）
     *
     * @param vehicleCharge 当前电量（浮点型）
     * @exclude javadoc中不包含
     */
    c81(l80: number): void;
    /**
     * 获取车重（单位kg）
     *
     * @return 车重（单位kg）
     * @exclude javadoc中不包含
     */
    d81(): number;
    /**
     * 设置车重（单位kg）
     *
     * @param load 车重（单位kg）
     * @exclude javadoc中不包含
     */
    e81(load: number): void;
    /**
     * 获取离开充电站前允许的剩余电量
     *
     * @return 离开充电站前允许的剩余电量
     * @exclude javadoc中不包含
     */
    f81(): number;
    /**
     * 设置离开充电站前允许的剩余电量
     *
     * @param leavingPercent 离开充电站前允许的剩余电量
     * @exclude javadoc中不包含
     */
    g81(k80: number): void;
    /**
     * 获取到达充电站时允许的最小电量
     *
     * @return 到达充电站时允许的最小电量
     * @exclude javadoc中不包含
     */
    h81(): number;
    /**
     * 设置到达充电站时允许的最小电量
     *
     * @param arrivingPercent
     * @exclude javadoc中不包含
     */
    i81(j80: number): void;
    /**
     * 获取到达目的地时允许的最小电量
     *
     * @return 到达目的地时允许的最小电量
     * @exclude javadoc中不包含
     */
    j81(): number;
    /**
     * 设置到达目的地时允许的最小电量
     *
     * @param destinationArrivingPercent 到达目的地时允许的最小电量
     * @exclude javadoc中不包含
     */
    k81(i80: number): void;
    /**
     * 以 JSON 形式，传入充电效率相关参数及开关
     *
     * @return 参数
     * @exclude javadoc中不包含
     */
    l81(): string;
    /**
     * 以 JSON 形式，传入充电效率相关参数及开关
     *
     * @param customChargingArguments 参数
     * @exclude javadoc中不包含
     */
    m81(h80: string): void;
    /**
     * 到达途径点时允许的最小电量
     * 若填写该值，则途经点允许最小电量以该值为准
     * 到达途经点最低电量百分比，仅支持充电站和自定义充电站
     *
     * @return 到达途径点时允许的最小电量
     */
    n81(): number;
    /**
     * 到达途径点时允许的最小电量
     * 若填写该值，则途经点允许最小电量以该值为准
     * 到达途经点最低电量百分比，仅支持充电站和自定义充电站
     *
     * @param waypointsArrivingPercent 到达途径点时允许的最小电量
     */
    o81(g80: number): void;
    b14(): string;
}
