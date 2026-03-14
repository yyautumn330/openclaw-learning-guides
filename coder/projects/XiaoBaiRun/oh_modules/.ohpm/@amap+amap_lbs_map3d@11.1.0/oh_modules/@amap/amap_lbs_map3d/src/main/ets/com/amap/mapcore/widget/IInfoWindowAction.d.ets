// @keepTs
// @ts-nocheck
import { BasePointOverlay } from '../../api/model/BasePointOverlay';
import { n60 } from './IInfoWindow';
/**
 * infowindow接口
 */
export interface o60 {
    showInfoWindow(marker: BasePointOverlay): void;
    /**
     * 隐藏Infowindow
     *
     */
    hideInfoWindow(): void;
    /**
     * 判断InfoWindow是否显示
     * @return true 显示
     *
     */
    isInfoWindowShown(): boolean;
    /**
     * 重新绘制InfoWindow<br>
     * 重新绘制时机<br>
     * 1.InfoWindow内容修改(会调用setInfoWindowAdpter和showInfoWindow)<br>
     * 2.地图位置发生变化
     */
    redrawInfoWindow(): void;
    /**
     * InfoWindow 点击事件
     * @param event 事件
     * @return true 表示消费掉
     */
    o97(event: GestureEvent): boolean;
    /**
     * 设置InfoWindow甘丽丽对象
     * @param infoWindowAdapterManager 统一管理对外的InfoWindow
     */
    i167(infoWindowAdapterManager: n60): void;
}
