// @keepTs
// @ts-nocheck
import { LatLonPoint } from "../core/LatLonPoint";
/**
 * 此类定义了输入提示搜索的参数。
 * @since V1.0.0
 */
export declare class InputtipsQuery {
    private static v44;
    private a60;
    private b60;
    private c60;
    private d60;
    /**
     * location 坐标 格式：“X,Y”（经度,纬度），不可以包含空格 建议使用location参数，可在此location附近优先返回搜索关键词信息 选填 无
     */
    private location;
    /**
     * 根据给定的参数来构造一个InputtipsQuery的对象
     * @param keyword 输入的关键字
     * @param city 查询的城市编码 citycode、城市名称（中文或中文全拼）、行政区划代码adcode。设置null或者undefined或“”为全国。
     * @since V1.0.0
     */
    constructor(z59: string, city: string | undefined);
    /**
     * 返回查询关键字。
     * @return 查询关键字。
     * @since V1.0.0
     */
    getKeyword(): string;
    /**
     * 返回查询城市。
     * @return 查询城市。
     * @since V1.0.0
     */
    getCity(): string | undefined;
    /**
     * 限定搜索类型。
     * @param type 搜索类型的组合，仅支持数字，对照下载页面获取的POI分类表输入。多种类型使用“|”分隔。
     * <p>举例：编码表 “050117 餐饮服务 ;中餐厅 ;火锅店”，输入“05”为餐饮服务、“0501”为中餐厅、“050117”为火锅店类别。/p>
     * @since V1.0.0
     */
    setType(type: string | undefined): void;
    /**
     * 返回搜索的类型。
     * @return 搜索类型。
     * @since V1.0.0
     */
    getType(): string | undefined;
    /**
     * 对获取结果进行严格城市限制。
     * @param isLimit true，城市限制；false，输入文字是权重词汇时，全国搜索。默认为false。
     * @since V1.0.0
     */
    setCityLimit(y59: boolean): void;
    /**
     * 返回是否严重按照设定城市返回结果。
     * @return true，限制；false，不限制。
     * @since V1.0.0
     */
    getCityLimit(): boolean;
    /**
     * 对获取结果进行经纬度位置限制
     * @since V1.0.0
     */
    setLocation(location: LatLonPoint | undefined): void;
    /**
     * 返回对结果进行位置限制的经纬度点
     * @return 限制点经纬度坐标。
     * @since V1.0.0
     */
    getLocation(): LatLonPoint | undefined;
}
