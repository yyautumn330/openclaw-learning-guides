// @keepTs
// @ts-nocheck
/**
 * 模块控制开关类,用于控制功能模块是否可用
 */
export declare class o1 {
    /**
     * 缓存开关
     */
    static readonly s33 = true;
    /**
     * 采集开关
     */
    static readonly t33 = true;
    /**
     * gps定位开关
     */
    static readonly u33 = true;
    /**
     * 获取最后位置开关
     */
    static readonly v33 = true;
    /**
     * 地理围栏开关
     */
    static readonly v9 = true;
    /**
     * H5辅助定位(Socket)开关
     */
    static readonly w33 = true;
    /**
     * 唤起高德地图服务开关
     */
    static readonly x33 = false;
    /**
     * 融合定位开关（3逻辑）
     */
    static readonly y33 = false;
    /**
     * 日志模块开关
     * @since 2.4.0
     */
    static readonly z33 = true;
    /**
     * 坐标转换工具
     * @since 2.4.0
     */
    static readonly x29 = true;
    /**
     * 滤波器开关(防抖)
     * @since 2.4.0
     */
    static readonly a34 = true;
    /**
     * dns加速开关
     * @since 2.6.0
     */
    static readonly b34 = true;
    /**
     * 渠道信息<p>
     * 0：渠道定位SDK专用，由第三方server发起<p>
     * 1：渠道定位SDK专用，本地发起<p>
     * 2：跨平台H5封装定位(APICloud)<p>
     * 3：公版定位SDK发起
     * @since 2.5.0
     */
    static readonly c34 = 3;
    /**
     * 是否使用service
     * @since 3.4
     */
    static readonly d34 = true;
}
