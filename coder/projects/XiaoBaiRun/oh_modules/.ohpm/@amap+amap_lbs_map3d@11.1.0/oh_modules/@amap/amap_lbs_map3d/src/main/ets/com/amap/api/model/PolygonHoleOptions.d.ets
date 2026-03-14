// @keepTs
// @ts-nocheck
/**
 * 多边形洞配置类
 *
 */
import ArrayList from '@ohos.util.ArrayList';
import { BaseHoleOptions } from './BaseHoleOptions';
import { LatLng } from './LatLng';
export declare class PolygonHoleOptions extends BaseHoleOptions {
    private pointsArray;
    private points;
    /**
     * @exclude javadoc中不显示
     */
    constructor();
    /**
     * 添加多边形洞边框的顶点
     *
     * @return 加入多个新的多边形边框顶点的PolygonOptions对象
     * @since 1.0.0
     */
    add(...w42: LatLng[]): PolygonHoleOptions;
    /**
     * 返回多边形洞坐标点列表
     *
     * @return 多边形坐标点列表
     * @since 1.0.0
     */
    getPoints(): ArrayList<LatLng>;
    /**
     * @exclude javadoc中不显示
     */
    describeContents(): number;
}
