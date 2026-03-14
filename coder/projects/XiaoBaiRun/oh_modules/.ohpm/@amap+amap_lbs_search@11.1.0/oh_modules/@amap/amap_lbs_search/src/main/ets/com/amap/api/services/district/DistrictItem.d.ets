// @keepTs
// @ts-nocheck
import ArrayList from "@ohos.util.ArrayList";
import { LatLonPoint } from "../core/LatLonPoint";
/**
 * 行政区信息类。
 * @since 1.0.1
 */
export declare class DistrictItem {
    /**
     * 城市编码
     */
    private cityCode;
    /**
     * 区域编码
     */
    private x3;
    /**
     * 行政区名称
     */
    private name;
    /**
     * 中心点
     */
    private center;
    /**
     * 行政区划级别
     */
    private level;
    /**
     * 下一级行政区划的结果
     */
    private districts;
    /**
     * 行政区划边界值
     */
    private r56;
    /**
     * 行政区划类的构造函数
     * @since 1.0.1
     * @internal javadoc中不显示
     */
    constructor();
    /**
     * 设置行政区划边界值
     * @param districtBounds 行政区划边界字符串数组
     * @since 1.0.1
     * @internal javadoc中不显示
     */
    k36(q56: Array<string>): void;
    /**
     * 以字符串数组形式返回行政区划边界值。
     * 字符串拆分规则：
     * 经纬度，经度和纬度之间用","分隔，坐标点之间用""分隔。例如：116.076498,40.115153116.076603,40.115071116.076333,40.115257116.076498,40.115153。
     * 字符串数组由来：
     * 如果行政区包括的是群岛，则坐标点是各个岛屿的边界，各个岛屿之间的经纬度使用"|"分隔。一个字符串数组可包含多个封闭区域，一个字符串表示一个封闭区域。
     * @return String []– 行政区划边界字符串数组
     * @since 1.0.1
     */
    districtBoundary(): Array<string>;
    /**
     * 返回城市编码，如果行政区为省或者国家，此字段无返回值。
     * @return 城市编码。
     * @since 1.0.1
     */
    getCityCode(): string | undefined;
    /**
     * 设置城市编码
     * @param cityCode 城市编码
     * @since 1.0.1
     * @internal javadoc中不显示
     */
    setCityCode(cityCode: string): void;
    /**
     * 返回区域编码。
     * @return 区域编码。
     * @since 1.0.1
     */
    getAdCode(): string | undefined;
    /**
     * 设置区域编码
     * @param adCode 区域编码
     * @since 1.0.1
     * @internal javadoc中不显示
     */
    setAdCode(p56: string): void;
    /**
     * 返回行政区域的名称。
     * @return 行政区域的名称。
     * @since 1.0.1
     */
    getName(): string | undefined;
    /**
     * 设置行政区域的名称
     * @param name 行政区域的名称
     * @since 1.0.1
     * @internal javadoc中不显示
     */
    setName(name: string): void;
    /**
     * 返回行政区域规划中心点的经纬度坐标。
     * @return 行政区域规划中心点的经纬度坐标。
     * @since 1.0.1
     */
    getCenter(): LatLonPoint | undefined;
    /**
     * 设置行政区划中心点的经纬度坐标。
     * @param center 行政区域规划中心点的经纬度坐标。
     * @since 1.0.1
     * @internal javadoc中不显示
     */
    setCenter(center: LatLonPoint | undefined): void;
    /**
     * 返回当前行政区划的级别。匹配级别共有五个级别。
     * @return 当前行政区划的级别。
     * @since 1.0.1
     */
    getLevel(): string | undefined;
    /**
     * 设置当前行政区划的级别，匹配级别共有五个级别。
     * @param level 当前行政区划的级别。
     * @since 1.0.1
     * @internal javadoc中不显示
     */
    j36(level: string): void;
    /**
     * 返回下一级行政区划的结果，如果无下级行政区划，返回null。
     * @return 下一级行政区划的结果，如果无下级行政区划，返回null。
     * @since 1.0.1
     */
    getSubDistrict(): ArrayList<DistrictItem>;
    /**
     * 设置下一级行政区划的结果
     * @param districts 下一级行政区划
     * @since 1.0.1
     * @internal javadoc中不显示
     */
    setSubDistrict(districts: ArrayList<DistrictItem>): void;
    /**
     * 比较两个行政区划是否相同
     * @param obj 待比较的对象
     * @return 相等返回true，不相等返回false。
     * @since 1.0.1
     */
    equals(obj: object): boolean;
    toString(): string;
}
