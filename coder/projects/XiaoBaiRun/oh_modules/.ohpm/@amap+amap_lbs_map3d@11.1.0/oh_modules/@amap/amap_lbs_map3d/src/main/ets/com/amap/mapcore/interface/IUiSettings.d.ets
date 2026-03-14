// @keepTs
// @ts-nocheck
/**
 * 为了云控提取出对外的IUiSettings接口，供 {@link com.amap.api.maps.UiSettings} 使用
 * @since 1.0.0
 */
export interface n49 {
    /**
     * 设置比例尺控件是否可见
     *
     * @param enabled true表示可见，false表示不可见。
     * @since V2.0.0
     */
    setScaleControlsEnabled(enabled: boolean): void;
    /**
     * 设置缩放按钮是否可见。
     *
     * @param enabled true表示可见，false表示不可见。
     * @since V2.0.0
     */
    setZoomControlsEnabled(enabled: boolean): void;
    /**
     * 设置指南针是否可见。
     *
     * @param enabled true表示可见，false表示不可见。
     * @since V2.0.0
     */
    setCompassEnabled(enabled: boolean): void;
    /**
     * 设置定位按钮是否可见。
     *
     * @param enabled true表示可见，false表示不可见。
     * @since V2.0
     */
    setMyLocationButtonEnabled(enabled: boolean): void;
    /**
     * 设置拖拽手势是否可用。
     *
     * @param enabled true为可用； false 为不可用。
     * @throws RemoteException
     */
    setScrollGesturesEnabled(enabled: boolean): void;
    /**
     * 设置双指缩放手势是否可用。
     *
     * @param enabled true为可用； false 为不可用。
     * @throws RemoteException
     */
    setZoomGesturesEnabled(enabled: boolean): void;
    /**
     * 设置倾斜手势是否可用。
     *
     * @param enabled true为可用； false 为不可用。
     * @throws RemoteException
     */
    setTiltGesturesEnabled(enabled: boolean): void;
    /**
     * 设置旋转手势是否可用。
     *
     * @param enabled true为可用； false 为不可用。
     * @throws RemoteException
     */
    setRotateGesturesEnabled(enabled: boolean): void;
    /**
     * 设置所有手势是否可用
     *
     * @param enabled true为可用； false 为不可用。
     * @throws RemoteException
     */
    setAllGesturesEnabled(enabled: boolean): void;
    /**
     * 设置“高德地图”Logo的位置。
     * @param position 位置参数。屏幕左下角：{@link AMapOptions#LOGO_POSITION_BOTTOM_LEFT} 底部居中：{@link AMapOptions#LOGO_POSITION_BOTTOM_CENTER} 右下：{@link AMapOptions#LOGO_MARGIN_RIGHT}
     * @since V2.0.0
     */
    setLogoPosition(position: number): void;
    /**
     * 设置缩放按钮的位置。
     *
     * @param position 右边界中部：{@link AMapOptions#ZOOM_POSITION_RIGHT_CENTER AMapOptions.ZOOM_POSITION_RIGHT_CENTER} 右下：{@link AMapOptions#ZOOM_POSITION_RIGHT_BUTTOM AMapOptions.ZOOM_POSITION_RIGHT_BUTTOM}。
     * @since V2.0.0
     */
    setZoomPosition(position: number): void;
    /**
     * 获取缩放按钮的位置。
     *
     * @return 缩放按钮的位置常量。右边界中部：{@link AMapOptions#ZOOM_POSITION_RIGHT_CENTER AMapOptions.ZOOM_POSITION_RIGHT_CENTER} 右下：{@link AMapOptions#ZOOM_POSITION_RIGHT_BUTTOM AMapOptions.ZOOM_POSITION_RIGHT_BUTTOM}。
     * @since V2.0.0
     */
    getZoomPosition(): number;
    /**
     * 获取“高德地图”Logo的位置。
     *
     * @return “高德地图”Logo的位置常量。屏幕左下角：{@link AMapOptions#LOGO_POSITION_BOTTOM_LEFT} 底部居中：{@link AMapOptions#LOGO_POSITION_BOTTOM_CENTER} 右下：{@link AMapOptions#LOGO_MARGIN_RIGHT}
     *
     * @throws RemoteException
     */
    getLogoPosition(): number;
    /**
     * 返回比例尺控件是否可见。
     *
     * @return 是否可见。
     * @since V2.0.0
     */
    isScaleControlsEnabled(): boolean;
    /**
     * 返回缩放按钮是否可见。
     *
     * @return 是否可见。
     * @since V2.0.0
     */
    isZoomControlsEnabled(): boolean;
    /**
     * 返回指南针控件是否可见。
     *
     * @return 是否可见。
     * @since V2.0.0
     */
    isCompassEnabled(): boolean;
    /**
     * 返回定位按钮是否可见。
     *
     * @return 是否可见。
     * @since V2.0.0
     */
    isMyLocationButtonEnabled(): boolean;
    /**
     * 返回拖拽手势是否可用。
     *
     * @return 是否可用。
     * @throws RemoteException
     */
    isScrollGesturesEnabled(): boolean;
    /**
     * 返回缩放手势是否可用。
     *
     * @return true 是否可用。
     * @throws RemoteException
     */
    isZoomGesturesEnabled(): boolean;
    /**
     * 返回倾斜手势是否可用。
     *
     * @return 是否可用。
     * @throws RemoteException
     */
    isTiltGesturesEnabled(): boolean;
    /**
     * 返回旋转手势是否可用。
     *
     * @return 是否可用。
     * @throws RemoteException
     */
    isRotateGesturesEnabled(): boolean;
    /**
     * 设置双击时,是否以屏幕中心点缩放，改接口只针对单指双击事件
     * 注：优先级低于{@link AMap#setPointToCenter(int, int)}
     *
     * @param isZoomInByScreenCenter true:以屏幕中心的进行缩放,false:不以屏幕中心的进行缩放
     *
     * @throws RemoteException
     */
    /**
     * 设置是否以地图中心点缩放 <br>
     * 注：优先级低于{@link AMap#setPointToCenter(int, int)}
     *
     * @param isGestureScaleByMapCenter true:以地图中心的进行缩放,false:不以地图中心的进行缩放
     *@throws RemoteException
     */
    setGestureScaleByMapCenter(isGestureScaleByMapCenter: boolean): void;
    /**
     * 返回是否以地图中心点缩放
     *
     * @return true  以地图中心点缩放；false 不以地图中心点缩放
     * @throws RemoteException
     */
    isGestureScaleByMapCenter(): boolean;
    /**
     * 设置是否显示logo
     * @param enable true 显示
     */
    s49(enable: boolean): void;
    /**
     * 请求刷新logo，因为logo view需要在主线程执行，所有增加刷新方法
     */
    v167(): void;
    /**
     * 是否显示logo
     * @return true 显示
     */
    isLogoEnable(): boolean;
    /**
     * 返回室内地图楼层切换控件是否显示。
     *
     * @return 是否显示。
     * @since V2.0.0
     */
    r49(): boolean;
    /**
     * 设置室内地图楼层切换控件是否可见。
     *
     * @param isIndoorSwitchEnabled true 为可见；false 不可见。
     * @since V2.0.0
     */
    setIndoorSwitchEnabled(isIndoorSwitchEnabled: boolean): void;
    /**
     * 设置logo到左边，右边，底边的比例
     * @param type <br>{@link AMapOptions#LOGO_MARGIN_LEFT} 表示左边距比例<br>
     *             {@link AMapOptions#LOGO_MARGIN_RIGHT} 表示右边距比例<br>
     *             {@link AMapOptions#LOGO_MARGIN_BOTTOM} 表示到底边距比例<br>
     * @param rate 比如0.5表示logo左边缘宽度占x轴的50%
     * @since V4.0.0
     * @exclude javadoc中不显示 滴滴使用
     */
    setLogoMarginRate(type: number, rate: number): void;
    /**
     * 获取Logo到左边，右边，底边的比例
     * @param type <br>{@link AMapOptions#LOGO_MARGIN_LEFT} 表示左边距比例<br>
     *             {@link AMapOptions#LOGO_MARGIN_RIGHT} 表示右边距比例<br>
     *             {@link AMapOptions#LOGO_MARGIN_BOTTOM} 表示到底边距比例<br>
     * @return 比如0.5表示logo左边缘宽度占x轴的50%
     * @see  #setLogoMarginRate(int, float)
     * @since V4.0.0
     * @exclude javadoc中不显示 滴滴使用
     */
    getLogoMarginRate(type: number): number;
    /**
     * 设置Logo左边界距离屏幕左侧的边距
     * @param pixels  像素
     * @since V4.0.0
     */
    setLogoLeftMargin(pixels: number): void;
    /**
     * 设置Logo下边界距离屏幕底部的边距
     * @param pixels 像素
     * @since V4.0.0
     */
    setLogoBottomMargin(pixels: number): void;
    /**
     * 设置双击时,是否以屏幕中心点缩放，改接口只针对单指双击事件
     * 注：优先级低于{@link AMap#setPointToCenter(int, int)}
     *
     * @param isZoomInByScreenCenter true:以屏幕中心的进行缩放,false:不以屏幕中心的进行缩放
     * @since V4.0.0
     * @exclude javadoc中不显示 滴滴使用
     */
    setZoomInByScreenCenter(isZoomInByScreenCenter: boolean): void;
    /**
     * 是否以屏幕中心点缩放
     * @return 是否以屏幕中心点缩放
     * @throws RemoteException
     */
    l93(): boolean;
}
