// @keepTs
// @ts-nocheck
import ArrayList from '@ohos.util.ArrayList';
import { BaseHoleOptions } from './BaseHoleOptions';
import { LatLng } from './LatLng';
/**
 * 创建圆洞的选项类
 */
export declare class CircleHoleOptions extends BaseHoleOptions {
    private point;
    private radius;
    private readonly pointsArray;
    /**
     * @exclude javadoc中不显示
     */
    constructor();
    /**
     * 设置洞圆心经纬度坐标。圆心经纬度坐标不能为Null，圆心经纬度坐标无默认值。
     *
     * @return 设置洞圆心经纬度坐标的CircleHoleOptions对象
     * @since 1.0.0
     */
    setCenter(point: LatLng): CircleHoleOptions;
    /**
     * 设置圆洞的半径，单位米。半径必须大于等于0。
     *
     * @param radius
     *            半径，单位米
     * @return 设置新半径的CircleHoleOptions对象。
     * @since 1.0.0
     */
    setRadius(radius: number): CircleHoleOptions;
    private createPoints;
    /**
     * 获取洞圆心经纬度坐标
     *
     * @return 圆点经纬度坐标
     * @since 1.0.0
     */
    getCenter(): LatLng;
    /**
     * 获取圆洞的半径，单位米。
     *
     * @return 圆半径，单位米
     * @since 1.0.0
     */
    getRadius(): number;
    getPoints(): ArrayList<LatLng>;
    /**
     * @exclude javadoc中不显示
     */
    describeContents(): number;
}
