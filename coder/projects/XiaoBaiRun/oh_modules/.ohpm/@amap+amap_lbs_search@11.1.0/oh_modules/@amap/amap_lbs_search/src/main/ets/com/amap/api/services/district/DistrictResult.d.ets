// @keepTs
// @ts-nocheck
import { AMapException } from "../core/AMapException";
import { DistrictItem } from "./DistrictItem";
import { DistrictSearchQuery } from "./DistrictSearchQuery";
import ArrayList from "@ohos.util.ArrayList";
/**
 * 行政区域查询结果类。
 * @since 1.0.1
 */
export declare class DistrictResult {
    /**
     * 查询条件
     */
    private query;
    /**
     * 行政区的结果
     */
    private u56;
    /**
     * 请求页数
     */
    private pageCount;
    /**
     *  异常信息
     */
    private exception;
    /**
     * 构造一个行政区划查询结果类
     * @since 1.0.1
     */
    constructor();
    /**
     * 返回查询行政区的结果，只有{@link AMapException#getErrorCode()}返回 {@link AMapException#CODE_AMAP_SUCCESS}时，才有查询结果。
     * @return 查询行政区的结果。
     * @since 1.0.1
     */
    getDistrict(): ArrayList<DistrictItem>;
    /**
     * 设置查询行政区的结果。
     * @param district 查询行政区的结果。
     * @since 1.0.1
     * @internal javadoc中不显示
     */
    d13(t56: ArrayList<DistrictItem>): void;
    /**
     * 返回查询结果对应的查询参数。
     * @return 查询结果对应的查询参数。
     * @since 1.0.1
     */
    getQuery(): DistrictSearchQuery | undefined;
    /**
     * 设置查询结果对应的查询条件
     * @param query 查询结果对应的查询条件
     * @since 1.0.1
     * @internal javadoc中不显示
     */
    setQuery(query: DistrictSearchQuery | undefined): void;
    /**
     * 返回行政区划查询结果的页数。
     * @return 行政区划查询结果的页数。
     * @since 1.0.1
     */
    getPageCount(): number;
    /**
     * 设置行政区划查询结果的页数。
     * @param pageCount 行政区划查询结果的页数。
     * @internal javadoc中不显示
     */
    f13(pageCount: number): void;
    /**
     * 返回服务异常对象。
     * @return 服务异常对象。
     * @since 1.0.1
     */
    getAMapException(): AMapException | undefined;
    /**
     * 设置服务异常。
     * @param e 服务异常对象。
     * @since 1.0.1
     * @internal javadoc中不显示
     */
    v56(s56: AMapException): void;
    /**
     * 比较两个行政区划的查询结果是否相同
     * @param obj 待比较的对象
     * @since 1.0.1
     */
    equals(obj: object): boolean;
    /**
     * 将行政区划查询结果转换为字符串返回。
     * @return 返回查询条件和查询结果的字符串。
     * @since 1.0.1
     */
    toString(): string;
}
