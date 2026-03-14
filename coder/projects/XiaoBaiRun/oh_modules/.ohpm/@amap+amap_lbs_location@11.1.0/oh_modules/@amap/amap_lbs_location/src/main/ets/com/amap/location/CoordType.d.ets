// @keepTs
// @ts-nocheck
/**
 * 坐标类型
 *
 * @创建时间： 2015年11月23日 下午5:43:08
 * @项目名称： AMapLocationSDK
 * @version 2.1.0
 * @since 2.1.0
 * @文件名称: CoordinateConverter.java
 * @类型名称: CoordType
 */
export declare enum CoordType {
    /**
     * 百度坐标
     *
     * @since 2.1.0
     */
    BAIDU = 0,
    /**
     * 图吧坐标
     *
     * @since 2.1.0
     */
    MAPBAR = 1,
    /**
     * 图盟坐标
     *
     * @since 2.1.0
     */
    MAPABC = 2,
    /**
     * 搜搜坐标
     *
     * @since 2.1.0
     */
    SOSOMAP = 3,
    /**
     * 阿里云
     *
     * @since 2.1.0
     */
    ALIYUN = 4,
    /**
     * 谷歌坐标
     *
     * @since 2.1.0
     */
    GOOGLE = 5,
    /**
     * GPS原始坐标
     *
     * @since 2.1.0
     */
    GPS = 6
}
export declare enum b30 {
    LOADING = 0,
    NET_ERROR = 1,
    SUCCESS = 2
}
/**
 * 返回带有指定名称的该类型的枚举常量。
 * @param coordString
 * @returns
 */
export declare function valueOfCoordType(c30: string): CoordType;
/**
 * 返回带有指定名称的该类型的枚举常量。
 * @param coordString
 * @returns
 */
export declare function getValuesOfCoordType(): CoordType[];
