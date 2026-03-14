// @keepTs
// @ts-nocheck
import { LatLonPoint } from '../core/LatLonPoint';
/**
 * 新能源充电桩信息
 *
 * @exclude javadoc中不显示
 */
export declare class t14 {
    /**
     * 导航段steps索引
     */
    private stepIndex;
    /**
     * 显示坐标，规则： lon，lat（经度，纬度）， “,”分割，如117.500244, 40.417801 经纬度小数点不超过6位
     */
    private u70?;
    /**
     * 显示坐标的投影点坐标，规则： lon，lat（经度，纬度）， “,”分割，如117.500244, 40.417801 经纬度小数点不超过6位
     */
    private v70?;
    /**
     * POIID
     */
    private w70?;
    /**
     * 充电站名称
     */
    private name?;
    /**
     * 充电站品牌名称
     */
    private x70?;
    /**
     * 快充桩最大功率，单位：千瓦
     */
    private maxPower;
    /**
     * 建议充电百分比，百分比*100后的整数，如60
     */
    private y70;
    /**
     * 预计充电时长，单位秒，注意：当电量不可达时，这个值不可用
     */
    private z70;
    /**
     * 预计到达充电桩剩余电量，单位：百分之一瓦时，注意：当这个值小于0时，表示该站电量不可达
     */
    private a71;
    /**
     * 充电桩的电压，单位：伏特
     */
    private voltage;
    /**
     * 充电桩的电流，单位：安培
     */
    private b71;
    /**
     * 获取导航段steps索引
     *
     * @return 导航段steps索引
     * @exclude javadoc中不包含
     */
    c71(): number;
    /**
     * 设置导航段steps索引
     *
     * @param stepIndex 导航段steps索引
     * @exclude javadoc中不包含
     */
    y36(stepIndex: number): void;
    /**
     * 获取显示坐标，规则： lon，lat（经度，纬度）， “,”分割，如117.500244, 40.417801 经纬度小数点不超过6位
     *
     * @return 显示坐标，规则： lon，lat（经度，纬度）， “,”分割，如117.500244, 40.417801 经纬度小数点不超过6位
     * @exclude javadoc中不包含
     */
    d71(): LatLonPoint;
    /**
     * 设置显示坐标，规则： lon，lat（经度，纬度）， “,”分割，如117.500244, 40.417801 经纬度小数点不超过6位
     *
     * @param showPoint 显示坐标，规则： lon，lat（经度，纬度）， “,”分割，如117.500244, 40.417801 经纬度小数点不超过6位
     * @exclude javadoc中不包含
     */
    q36(t70: LatLonPoint): void;
    /**
     * 获取显示坐标的投影点坐标，规则： lon，lat（经度，纬度）， “,”分割，如117.500244, 40.417801 经纬度小数点不超过6位
     *
     * @return 显示坐标的投影点坐标，规则： lon，lat（经度，纬度）， “,”分割，如117.500244, 40.417801 经纬度小数点不超过6位
     * @exclude javadoc中不包含
     */
    e71(): LatLonPoint;
    /**
     * 设置显示坐标的投影点坐标，规则： lon，lat（经度，纬度）， “,”分割，如117.500244, 40.417801 经纬度小数点不超过6位
     *
     * @param projectivePoint 显示坐标的投影点坐标，规则： lon，lat（经度，纬度）， “,”分割，如117.500244, 40.417801 经纬度小数点不超过6位
     * @exclude javadoc中不包含
     */
    r36(s70: LatLonPoint): void;
    /**
     * 获取POIID
     *
     * @return POIID
     * @exclude javadoc中不包含
     */
    getPoiId(): string;
    /**
     * 设置POIID
     *
     * @param poiId
     * @exclude javadoc中不包含
     */
    setPoiId(r70: string): void;
    /**
     * 获取充电站名称
     *
     * @return 充电站名称
     * @exclude javadoc中不包含
     */
    getName(): string;
    /**
     * 设置充电站名称
     *
     * @param name 充电站名称
     * @exclude javadoc中不包含
     */
    setName(name: string): void;
    /**
     * 获取充电站品牌名称
     *
     * @return 充电站品牌名称
     * @exclude javadoc中不包含
     */
    f71(): string;
    /**
     * 设置充电站品牌名称
     *
     * @param brandName 充电站品牌名称
     * @exclude javadoc中不包含
     */
    p36(q70: string): void;
    /**
     * 获取快充桩最大功率，单位：千瓦
     *
     * @return 快充桩最大功率，单位：千瓦
     * @exclude javadoc中不包含
     */
    g71(): number;
    /**
     * 设置快充桩最大功率，单位：千瓦
     *
     * @param maxPower 快充桩最大功率，单位：千瓦
     * @exclude javadoc中不包含
     */
    s36(maxPower: number): void;
    /**
     * 获取建议充电百分比，百分比*100后的整数，如60
     *
     * @return 建议充电百分比，百分比*100后的整数，如60
     * @exclude javadoc中不包含
     */
    h71(): number;
    /**
     * 设置建议充电百分比，百分比*100后的整数，如60
     *
     * @param chargePercent 建议充电百分比，百分比*100后的整数，如60
     * @exclude javadoc中不包含
     */
    t36(p70: number): void;
    /**
     * 获取预计充电时长，单位秒，注意：当电量不可达时，这个值不可用
     *
     * @return 预计充电时长，单位秒，注意：当电量不可达时，这个值不可用
     * @exclude javadoc中不包含
     */
    i71(): number;
    /**
     *
     * 设置预计充电时长，单位秒，注意：当电量不可达时，这个值不可用
     *
     * @param chargeTime 预计充电时长，单位秒，注意：当电量不可达时，这个值不可用
     * @exclude javadoc中不包含
     */
    u36(o70: number): void;
    /**
     * 获取预计到达充电桩剩余电量，单位：百分之一瓦时，注意：当这个值小于0时，表示该站电量不可达
     *
     * @return 预计到达充电桩剩余电量，单位：百分之一瓦时，注意：当这个值小于0时，表示该站电量不可达
     * @exclude javadoc中不包含
     */
    j71(): number;
    /**
     * 设置预计到达充电桩剩余电量，单位：百分之一瓦时，注意：当这个值小于0时，表示该站电量不可达
     *
     * @param remainingCapacity 预计到达充电桩剩余电量，单位：百分之一瓦时，注意：当这个值小于0时，表示该站电量不可达
     * @exclude javadoc中不包含
     */
    v36(n70: number): void;
    /**
     * 获取充电桩的电压
     *
     * @return 充电桩的电压
     * @exclude javadoc中不包含
     */
    k71(): number;
    /**
     * 设置充电桩的电压
     *
     * @param voltage 充电桩的电压
     * @exclude javadoc中不包含
     */
    w36(voltage: number): void;
    /**
     * 获取充电桩的电流，单位：安培
     *
     * @return 充电桩的电流，单位：安培
     * @exclude javadoc中不包含
     */
    l71(): number;
    /**
     * 设置充电桩的电流，单位：安培
     *
     * @param amperage 充电桩的电流，单位：安培
     * @exclude javadoc中不包含
     */
    x36(m70: number): void;
}
