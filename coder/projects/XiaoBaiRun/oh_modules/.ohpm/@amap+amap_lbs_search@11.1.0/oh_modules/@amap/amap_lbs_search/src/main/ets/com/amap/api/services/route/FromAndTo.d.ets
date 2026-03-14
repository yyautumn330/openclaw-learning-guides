// @keepTs
// @ts-nocheck
import { LatLonPoint } from '../core/LatLonPoint';
/**
 * 构造路径规划的起点和终点坐标。
 *
 * @since 1.0.0
 */
export declare class FromAndTo {
    private v79;
    private w79;
    private x79?;
    private y79?;
    private z79?;
    private a80?;
    /**
     * 车牌省份 用汉字填入车牌省份缩写。用于判断是否限行
     */
    private b80?;
    /**
     * 车牌详情 填入除省份及标点之外的字母和数字（需大写）。用于判断限行相关。
     */
    private c80?;
    /**
     * FromAndTo的构造函数。
     *
     * @since 1.0.0
     */
    constructor(from: LatLonPoint, to: LatLonPoint);
    /**
     * 返回路径规划的起点坐标。
     *
     * @return 路径规划的起点坐标。
     * @since 1.0.0
     */
    getFrom(): LatLonPoint;
    /**
     * 返回路径规划的终点坐标。
     *
     * @return 路径规划的终点坐标。
     * @since 1.0.0
     */
    getTo(): LatLonPoint;
    /**
     * 返回路径规划起点POI的ID。
     *
     * @return 路径规划的起点POI的ID。
     * @since 1.0.0
     */
    getStartPoiID(): string;
    /**
     * 设置路径规划起点POI的ID。<br>
     * 仅驾车、货车支持<br>
     * 填充此值以后，会影响路径规划的结果，举例来说，当起点的经纬度在高架桥上面，<br>
     * 若填充了此值我们会以此POI的经纬度作为更高优的处理。<br>
     *
     * @param mStartPoiID 路径规划的起点POI的ID。
     * @since 1.0.0
     */
    setStartPoiID(u79: string): void;
    /**
     * 返回路径规划目的地POI的ID。
     *
     * @return 路径规划的目的地POI的ID。
     * @since 1.0.0
     */
    getDestinationPoiID(): string;
    /**
     * 设置路径规划目的地POI的ID。<br>
     * 仅驾车、货车支持<br>
     * 填充此值以后，会影响路径规划的结果，举例来说，当终点的经纬度在高架桥上面，<br>
     * 若填充了此值我们会以此POI的经纬度作为更高优的处理。<br>
     *
     * @param mDestinationPoiID 路径规划的目的地POI的ID。
     * @since 1.0.0
     */
    setDestinationPoiID(t79: string): void;
    /**
     * 返回路径规划起点的类型。
     *
     * @return 路径规划起点类型。
     * @since 1.0.0
     */
    getOriginType(): string;
    /**
     * 设置路径规划起点类型。
     *
     * @param origintype 路径规划起点类型。
     * @since 1.0.0
     */
    setOriginType(s79: string): void;
    /**
     * 返回路径规划目的地类型。
     *
     * @return 路径规划目的地类型。
     * @since 1.0.0
     */
    getDestinationType(): string;
    /**
     * 设置路径规划目的地类型。
     *
     * @param destinationtype 路径规划目的地类型。
     * @since 1.0.0
     */
    setDestinationType(r79: string): void;
    /**
     * 获取车牌省份
     *
     * @return 车牌省份
     * @since 1.0.0
     */
    getPlateProvince(): string;
    /**
     * 设置车牌省份
     *
     * @param plateProvince 车牌省份  用汉字填入车牌省份缩写。用于判断是否限行
     * @since 1.0.0
     */
    setPlateProvince(q79: string): void;
    /**
     * 获取车牌号
     *
     * @return 车牌号
     * @since 1.0.0
     */
    getPlateNumber(): string;
    /**
     * 设置车牌号
     *
     * @param plateNumber 车牌详情 填入除省份及标点之外的字母和数字（需大写）。用于判断限行相关。
     * @since 1.0.0
     */
    setPlateNumber(p79: string): void;
}
