// @keepTs
// @ts-nocheck
/**
 * 点击地图Poi点时，该兴趣点的描述信息
 * Poi 是指底图上的一个自带Poi点。
 * <p>一个Poi点有如下属性：</p>
 * <ul>
 * <li>名称：Poi点在底图上显示的名称</li>
 * <li>坐标：Poi点在底图上的经纬度坐标</li>
 * </ul>
 *
 * @since V2.0.0
 */
import { LatLng } from './LatLng';
export declare class Poi {
    private readonly name;
    private readonly coordinate;
    private readonly poiid;
    private readonly z41;
    constructor(name: string, coordinate: LatLng | undefined, x41: string, y41?: LatLng | undefined);
    /**
     * 获取点击兴趣点时的坐标
     *
     * @return 名称。
     * @since V2.4.1
     */
    getClickedCoordinate(): LatLng | undefined;
    /**
     * 获取兴趣点的名称。
     *
     * @return 名称。
     * @since V2.4.1
     */
    getName(): string;
    /**
     * 获取兴趣点的地理坐标。
     *
     * @return 地理坐标。
     * @since V2.4.1
     */
    getCoordinate(): LatLng | undefined;
    /**
     * 获取兴趣点的Id，它是兴趣点的唯一标识
     *
     * @return 兴趣点Id。
     * @since V3.1.0
     */
    getPoiId(): string;
    /**
     * @param o
     * @return
     * @exclude javadoc中不显示
     */
    equals(w41: object): boolean;
    /**
     * @return
     * @exclude javadoc中不显示
     */
    toString(): string;
}
