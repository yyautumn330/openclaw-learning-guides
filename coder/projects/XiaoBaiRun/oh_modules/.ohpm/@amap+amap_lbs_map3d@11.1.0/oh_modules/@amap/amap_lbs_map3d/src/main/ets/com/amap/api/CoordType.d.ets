// @keepTs
// @ts-nocheck
export declare enum CoordType {
    /**
     * 百度坐标
     * @since 2.2.5
     */
    BAIDU = 0,
    /**
     * 图吧坐标
     * @since 2.2.5
     */
    MAPBAR = 1,
    /**
     * GPS坐标
     * @since 2.2.5
     */
    GPS = 2,
    /**
     * MapABC坐标
     * @since 2.2.5
     */
    MAPABC = 3,
    /**
     * SoSo地图坐标
     * @since 2.2.5
     */
    SOSOMAP = 4,
    /**
     * 阿里云地图坐标
     * @since 2.2.5
     */
    ALIYUN = 5,
    /**
     * 谷歌坐标
     * @since 2.2.5
     */
    GOOGLE = 6
}
/**
 * 返回带有指定名称的该类型的枚举常量。
 * @param coordString
 * @returns
 */
export declare function valueOfCoordType(z7: string): CoordType;
/**
 * 返回带有指定名称的该类型的枚举常量。
 * @param coordString
 * @returns
 */
export declare function getValuesOfCoordType(): CoordType[];
