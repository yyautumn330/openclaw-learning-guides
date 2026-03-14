// @keepTs
// @ts-nocheck
import { LatLonPoint } from "../core/LatLonPoint";
/**
 * 逆地理编码返回的商圈信息。
 * @since V1.0.0
 */
export declare class BusinessArea {
    private centerPoint;
    private name;
    /**
     * 构造BusinessArea对象
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    constructor();
    /**
     * 返回当前商圈的中心点坐标。
     * @return 商圈中心点坐标。详见搜索服务模块的核心基础包（com.amap.api.services.core）中的类 <strong><a href="../../../../../../Search/com/amap/api/services/core/LatLonPoint.html" title="com.amap.api.services.core中的类">LatLonPoint</a></strong>。
     * @since V1.0.0
     */
    getCenterPoint(): LatLonPoint | undefined;
    /**
     * 设置当前商圈的中心点坐标。
     * @param centerPoint 商圈中心点坐标。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    setCenterPoint(centerPoint: LatLonPoint | undefined): void;
    /**
     * 获取当前商圈的名字。
     * @return 返回商圈名字。
     * @since V1.0.0
     */
    getName(): string | undefined;
    /**
     * 设置当前商圈的名称。
     * @param name 商圈的名称。
     * @since V1.0.0
     * @exclude javadoc中不显示。
     */
    setName(name: string): void;
}
