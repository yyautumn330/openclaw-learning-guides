// @keepTs
// @ts-nocheck
import { Marker } from "../../api/model/Marker";
import { MarkerOptions } from "../../api/model/MarkerOptions";
import ArrayList from "@ohos.util.ArrayList";
import drawing from "@ohos.graphics.drawing";
import { DPoint } from "../../api/model/DPoint";
import { BaseOverlay } from "../../api/model/BaseOverlay";
import { Rect } from "../../../../../../../Index";
/**
 * 原生view覆盖物图层
 */
export interface s36 {
    /**
     * 添加原生view覆盖物
     * @param marker 原生view覆盖物
     * @param markerOptions 原生view覆盖物options
     */
    i96(marker: Marker, markerOptions: MarkerOptions): void;
    /**
     * 移除原生view覆盖物
     * @param overlayName 原生view覆盖物名称
     */
    u37(overlayName: string): void;
    /**
     * 更新原生view覆盖物oiptions
     * @param overlayName 原生view覆盖物名称
     * @param markerOptions 原生view覆盖物options
     */
    m167(overlayName: string, markerOptions: MarkerOptions): void;
    /**
     * 更新原生view覆盖物位置
     */
    n167(): void;
    /**
     * 重绘原生view覆盖物
     */
    o167(): void;
    /**
     * 显示原生view覆盖物信息窗
     * @param overlayName
     */
    showInfoWindow(overlayName: string): void;
    /**
     * 隐藏原生view覆盖物信息窗
     * @param overlayName
     */
    hideInfoWindow(overlayName: string): void;
    /**
     * 判断原生view覆盖物信息窗是否显示
     * @param overlayName 原生view覆盖物名称
     * @return
     */
    isInfoWindowShown(overlayName: string): boolean;
    /**
     * 获取原生view覆盖物屏幕位置
     * @param id
     * @param fPointPos
     */
    /**
     * 获取原生view覆盖物信息窗偏移
     * @param overlayName 原生view覆盖物名称
     * @param fPoint 信息窗偏移
     */
    /**
     * 检查原生view覆盖物是否在屏幕内
     * @param overlayName
     * @return
     */
    g8(overlayName: string): boolean;
    /**
     * 获取点击原生view覆盖物
     * @param screenPoint 屏幕坐标
     * @param overlayType 覆盖物类型
     * @return
     */
    p167(screenPoint: DPoint, overlayType: number): BaseOverlay;
    /**
     * 设置原生view覆盖物置顶
     *
     * @param overlayName
     */
    h8(overlayName: string): void;
    /**
     * 获取地图上所有覆盖物
     *
     * @return
     */
    getMapScreenMarkers(): ArrayList<Marker>;
    /**
     * 获取覆盖物边界
     *
     * @param overlayName 覆盖物名称
     * @return
     */
    q167(overlayName: string): Rect;
    /**
     * 清除覆盖物
     */
    clear(): void;
    /**
     * 截屏
     * @param canvas
     */
    r167(canvas: drawing.Canvas): void;
}
