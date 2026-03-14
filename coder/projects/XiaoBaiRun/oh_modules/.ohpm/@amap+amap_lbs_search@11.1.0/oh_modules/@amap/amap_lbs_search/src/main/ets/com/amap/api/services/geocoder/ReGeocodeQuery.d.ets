// @keepTs
// @ts-nocheck
import { LatLonPoint } from "../core/LatLonPoint";
/**
 * 此类定义了逆地理编码查询的地理坐标点、查询范围、坐标类型。
 * @since V1.0.0
 */
export declare class ReGeocodeQuery {
    /**
     * 要进行逆地理编码的地理坐标点。
     */
    private point;
    /**
     * 查找范围。默认值为1000，取值范围1-3000，单位米。
     */
    private radius;
    /**
     * 输入参数坐标类型。包含GPS坐标和高德坐标。 可以参考{@link #setLatLonType(String)}
     */
    private j59;
    /**
     * 附近POI类型
     */
    private poiType;
    /**
     * 返回策略，如传入无效mode值，则走默认策略
     * distance 按距离返回
     * score 按权重返回
     */
    private mode;
    /**
     * 扩展字段 base表示只返回基础数据，all表示所有数据 ，默认 base
     */
    private extensions;
    /**
     * ReGeocodeQuery构造函数。
     * @param point 要进行逆地理编码的地理坐标点。
     * @param radius 查找范围。默认值为1000，取值范围1-3000，单位米。
     * @param latLonType 输入参数坐标类型。包含GPS坐标和高德坐标。 可以参考{@link #setLatLonType(String)}
     * @since V1.0.0
     */
    constructor(point: LatLonPoint | undefined, radius: number, i59: string);
    /**
     * 返回逆地理编码的地理坐标点。
     * @return 该结果的逆地理编码的地理坐标点。
     * @since V1.0.0
     */
    getPoint(): LatLonPoint | undefined;
    /**
     * 设置逆地理编码的地理坐标点。
     * @param point 逆地理编码的地理坐标点。
     * @since V1.0.0
     */
    setPoint(point: LatLonPoint | undefined): void;
    /**
     * 返回查找范围。
     * @return 查找的范围。
     * @since V1.0.0
     */
    getRadius(): number;
    /**
     * 设置查找范围。
     * @param radius 设置查找的范围。
     * @since V1.0.0
     */
    setRadius(radius: number): void;
    /**
     * 返回参数坐标类型。
     * @return 参数坐标类型。包含GPS坐标和高德坐标。
     * @since V1.0.0
     */
    getLatLonType(): string;
    /**
     * 设置参数坐标类型。
     * @param latLonType 参数坐标类型。包含GPS坐标和高德坐标。
     *                    可选 {@link GeocodeSearch#AMAP} 、{@link GeocodeSearch#GPS}
     * @since V1.0.0
     */
    setLatLonType(h59: string): void;
    /**
     * 返回设置的附近POI类型。
     * @return 附近POI类型。
     * @since V1.0.0
     */
    getPoiType(): string;
    /**
     * 设置附近POI类型，结果将会围绕这些类型进行返回。
     * 支持传入多个POI类型，多值间用“|”分隔。<br>
     * @since V1.0.0
     */
    setPoiType(poiType: string): void;
    /**
     * 海外生效
     * 返回策略，如传入无效mode值，则走默认策略
     * distance 按距离返回
     * score 按权重返回
     * @since 1.0.0
     */
    getMode(): string;
    /**
     * 海外生效
     * 返回策略，如传入无效mode值，则走默认策略
     * distance 按距离返回
     * score 按权重返回
     * @since 1.0.0
     */
    setMode(mode: string): void;
    /**
     * 扩展字段 base表示只返回基础数据，all表示所有数据 ，默认 base
     * @since 1.0.0
     */
    getExtensions(): string;
    /**
     * 扩展字段 base表示只返回基础数据，all表示所有数据 ，默认 base
     * @since 1.0.0
     */
    setExtensions(extensions: string): void;
    /**
     * 比较两个查询条件是否相同。
     * @param obj 查询条件。
     * @return 查询条件是否相同。
     * @since V1.0.0
     */
    equals(obj: Object): boolean;
}
