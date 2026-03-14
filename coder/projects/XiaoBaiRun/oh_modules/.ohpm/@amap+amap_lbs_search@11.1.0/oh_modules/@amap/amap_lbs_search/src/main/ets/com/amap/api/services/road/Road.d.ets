// @keepTs
// @ts-nocheck
import { LatLonPoint } from "../core/LatLonPoint";
/**
 * 定义道路Road的类。
 * @since V1.0.0
 */
export declare class Road {
    /**
     * // 道路ID
     */
    private id;
    /**
     * // 道路名称
     */
    private name;
    /**
     *
     * // 城市代码
     */
    private cityCode;
    /**
     * // 道路宽度
     */
    private n66;
    /**
     *  // 道路分类
     */
    private type;
    /**
     * // 道路中心点
     */
    private centerPoint;
    constructor();
    /**
     * 设置道路ID。
     * @param id 道路ID。
     * @since V1.0.0
     */
    setId(id: string): void;
    /**
     * 返回结果的道路ID。
     * @return 结果的道路ID。
     * @since V1.0.0
     */
    getId(): string | undefined;
    /**
     * 设置道路名称。
     * @param name 道路名称。
     * @since V1.0.0
     */
    setName(name: string): void;
    /**
     * 返回结果的道路名称。
     * @return 结果的道路名称。
     * @since V1.0.0
     */
    getName(): string | undefined;
    /**
     * 设置结果的城市编码。
     * @param cityCode 城市编码。
     * @since V1.0.0
     */
    setCityCode(cityCode: string): void;
    /**
     * 返回结果的城市编码。
     * @return 结果的城市编码。
     * @since V1.0.0
     */
    getCityCode(): string | undefined;
    /**
     * 设置道路宽度。
     * @param roadWidth 道路宽度，单位米。
     * @since V1.0.0
     */
    setRoadWidth(m66: number): void;
    /**
     * 返回结果的道路宽度，单位米。
     * @return 结果的道路宽度。
     * @since V1.0.0
     */
    getRoadWidth(): number;
    /**
     * 设置道路类型。
     * 道路的类型有41000（高速公路）、42000（国道）、43000（城市环路/城市快速路）、51000（省道）、44000（主要道路（城市主干道））、45000（次要道路（城市次干道））、52000（县道）、53000（乡村道路）、54000（区县内部道路）、47000（一般道路）、49（非导航道路）。
     * @param type 道路类型。
     * @since V1.0.0
     */
    setType(type: string): void;
    /**
     * 返回结果的道路类型。
     * 道路的类型有41000（高速公路）、42000（国道）、43000（城市环路/城市快速路）、51000（省道）、44000（主要道路（城市主干道））、45000（次要道路（城市次干道））、52000（县道）、53000（乡村道路）、54000（区县内部道路）、47000（一般道路）、49（非导航道路）。
     * @return 结果的道路类型。
     * @since V1.0.0
     */
    getType(): string | undefined;
    /**
     * 设置道路中心点的坐标。
     * @param centerPoint 道路中心点的坐标。
     * @since V1.0.0
     */
    setCenterPoint(centerPoint: LatLonPoint | undefined): void;
    /**
     * 返回结果的道路中心点坐标。
     * @return 结果的道路中心点坐标。
     * @since V1.0.0
     */
    getCenterPoint(): LatLonPoint | undefined;
}
