// @keepTs
// @ts-nocheck
/**
 * 此类定义了公交站点搜索的关键字和城市。
 * @since V2.1.0
 */
export declare class BusStationQuery {
    private g4;
    private city;
    private pageSize;
    private w2;
    /**
     * BusStationQuery构造函数。
     * @param query 查询关键字。关键字规则：多个关键字用“|”分割，“空格"表示与，"双引号" 表示不可分割。
     * @param city 可选值：cityname（中文或中文全拼）、citycode、adcode。如传入null或空字符串则为“全国”
     * @since V2.1.0
     */
    constructor(query: string, city: string);
    private h4;
    /**
     * 返回查询关键字。
     * @return 该结果的查询关键字。
     * @since V2.1.0
     */
    getQueryString(): string;
    /**
     * 返回查询城市编码/行政区划代码/城市名称。城市编码参考请在网站“相关下载”处获取。
     * @return 查询城市参数。
     * @since V2.1.0
     */
    getCity(): string;
    /**
     * 获得查询每页的结果数目。
     * @return 查询每页的结果数目。
     * @since V2.1.0
     */
    getPageSize(): number;
    /**
     * 获得查询第几页的数据。
     * @return 查询第几页，从0开始。<font color="red">自 5.2.1后修改成从1开始，和iOS保持一致。</font>
     * @since V2.1.0
     */
    getPageNumber(): number;
    /**
     * 设置查询关键字。
     * @param queryString 查询关键字。
     * @since V2.1.0
     */
    setQueryString(f4: string): void;
    /**
     * 设置查询城市参数。
     * @param city 查询城市参数。参数可以为城市编码/行政区划代码/城市名称。城市编码参考请在网站“相关下载”处获取。
     * @since V2.1.0
     */
    setCity(city: string): void;
    /**
     * 设置查询每页的结果数目。
     * @param pageSize 新的查询条件。默认每页显示20条结果。
     * @since V2.1.0
     */
    setPageSize(pageSize: number): void;
    /**
     * 设置查询第几页。
     * @param pageNumber 查询第几页的数据，从0开始。<font color="red">自 5.2.1后修改成从1开始，和iOS保持一致。</font>
     * @since V2.1.0
     */
    setPageNumber(e4: number): void;
    /**
     * @exclude javadoc中不显示。
     */
    clone(): BusStationQuery;
    /**
     * 比较两个查询条件是否相同。
     * @param obj 查询条件。
     * @return 查询条件是否相同。
     * @since V2.1.0
     */
    equals(other: BusStationQuery): boolean;
    /**
     * @exclude javadoc中不显示。
     */
    a3(d4: BusStationQuery): boolean;
}
