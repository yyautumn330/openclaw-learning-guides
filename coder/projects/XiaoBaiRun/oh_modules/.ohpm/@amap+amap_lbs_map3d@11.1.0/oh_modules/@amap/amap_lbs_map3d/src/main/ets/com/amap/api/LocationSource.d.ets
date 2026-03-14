// @keepTs
// @ts-nocheck
import geoLocationManager from '@ohos.geoLocationManager';
/**
 * 定义了一个定位源，为地图提供定位数据。
 *
 * @since 1.0.0
 */
export interface LocationSource {
    /**
     * 激活定位源。
     *
     * @param locationChangedListener 位置改变的监听接口。
     * @since 1.0.0
     */
    activate(locationChangedListener: OnLocationChangedListener): void;
    /**
     * 停止定位。
     *
     * @since 1.0.0
     */
    deactivate(): void;
}
/**
 * 位置改变的监听接口。
 *
 * @since 1.0.0
 */
export interface OnLocationChangedListener {
    /**
     * 当定位源获取的位置信息发生变化时回调此接口。
     *
     * @param location 新的位置信息。
     * @since 1.0.0
     */
    onLocationChanged(location: geoLocationManager.Location): void;
}
