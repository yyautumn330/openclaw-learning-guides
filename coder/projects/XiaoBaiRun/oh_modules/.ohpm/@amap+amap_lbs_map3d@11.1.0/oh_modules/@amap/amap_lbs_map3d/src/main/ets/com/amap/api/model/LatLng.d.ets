// @keepTs
// @ts-nocheck
/**
 * 存储经纬度坐标值的类，单位角度。
 *
 * @since 1.0.0
 */
@Sendable
export declare class LatLng {
    /**
     * 纬度 (垂直方向)
     * @since 1.0.0
     */
    readonly latitude: number;
    /**
     * 经度 (水平方向)
     * @since 1.0.0
     */
    readonly longitude: number;
    /**
     * 使用传入的经纬度构造LatLng 对象，一对经纬度值代表地球上一个地点。<br>
     * 如果传入的经纬度不合理，会打印错误日志进行提示，然后转换为接近的合理的经纬度。
     * @param latitude  地点的纬度，在-90 与90 之间的double 型数值。
     * @param longitude 地点的经度，在-180 与180 之间的double 型数值。
     * @since 1.0.0
     */
    constructor(latitude: number, longitude: number);
    /**
     * 使用传入的经纬度构造LatLng 对象，一对经纬度值代表地球上一个地点。
     * 注：如果构造的LatLng数量大于2000，建议将isCheck设为false关闭检查功能。
     * @param latitude  地点的纬度，在-90 与90 之间的double 型数值。
     * @param longitude 地点的经度，在-180 与180 之间的double 型数值。
     * @param isCheck   是否需要检查经纬度的合法性，建议填写true
     *                  如果设为true，传入的经纬度不合理，会打印错误日志进行提示，然后转换为接近的合理的经纬度。
     * @see LatLng#LatLng(number, number)
     * @since 1.0.0
     */
    constructor(latitude: number, longitude: number, isCheck: boolean);
    /**
     * @return
     * @exclude javadoc中不显示
     */
    toString(): string;
    equals(other: LatLng): boolean;
    equalsZero(): boolean;
}
