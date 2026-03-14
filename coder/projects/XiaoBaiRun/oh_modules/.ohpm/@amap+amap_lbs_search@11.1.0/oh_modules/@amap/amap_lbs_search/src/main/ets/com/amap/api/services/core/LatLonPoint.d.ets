// @keepTs
// @ts-nocheck
export declare class LatLonPoint {
    private n53;
    private o53;
    /**
     * 用给定的经度和纬度构造一个LatLonPoint。
     * @param latitude 纬度(垂直方向)。为保持Mercator 投影精确度，其取值范围是[-80,80]。
     * @param longitude 经度(水平方向)，可被规范化到(-180,180]。
     * @since 1.0.0
     */
    constructor(latitude: number, longitude: number);
    /**
     * 判断经纬度是否和原对象相等。
     * @return 相等返回true，不相等返回false。
     */
    equals(obj: LatLonPoint): boolean;
    /**
     * 获取该点经度。
     * @return 该点的经度。
     * @since 1.0.0
     */
    getLongitude(): number;
    /**
     * 设置该点经度。
     * @param lon 经度值。
     * @since 1.0.0
     */
    setLongitude(m53: number): void;
    /**
     * 获取该点纬度。
     * @return 该点的纬度。
     * @since 1.0.0
     */
    getLatitude(): number;
    /**
     * 设置该点纬度。
     * @param lat 纬度值。
     * @since 1.0.0
     */
    setLatitude(l53: number): void;
    /**
     * 复制一个经纬度点对象。
     * @return 返回一个和原经纬度相同的经纬度坐标对象。
     * @since 1.0.0
     */
    copy(): LatLonPoint;
    /**
     * 将经纬度转换为字符串输出。
     * @return 返回纬度和经度的字符串。
     */
    toString(): string;
}
