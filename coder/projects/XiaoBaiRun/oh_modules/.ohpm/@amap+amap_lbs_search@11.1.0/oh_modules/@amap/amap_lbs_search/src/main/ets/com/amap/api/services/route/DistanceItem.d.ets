// @keepTs
// @ts-nocheck
/**
 * 距离测量返回结果中某一个结果的具体信息
 * @since V1.0.0
 */
export declare class DistanceItem {
    /**
     * 指定地点之间没有可以行车的道路
     * @since V1.0.0
     */
    ERROR_CODE_NO_DRIVE: number;
    /**
     * 起点/终点 距离所有道路均距离过远（例如在海洋/矿业）
     * @since V1.0.0
     */
    ERROR_CODE_TOO_FAR: number;
    /**
     * 起点/终点不在中国境内
     * @since V1.0.0
     */
    ERROR_CODE_NOT_IN_CHINA: number;
    /**
     * 起点坐标，起点坐标序列号（从１开始）
     * @since V1.0.0
     */
    private w73;
    /**
     * 终点坐标，终点坐标序列号（从１开始）
     * @since V1.0.0
     */
    private x73;
    /**
     * 路径距离，单位：米
     * @since V1.0.0
     */
    private distance;
    /**
     * 预计行驶时间，单位：秒
     * @since V1.0.0
     */
    private duration;
    /**
     *  仅在出错的时候显示该字段。大部分显示“未知错误”
     *  由于此接口支持批量请求，建议不论批量与否用此字段判断请求是否成功
     *  @since V1.0.0
     */
    private errorInfo;
    /**
     *仅在出错的时候显示此字段。
     * 在驾车模式下：
     * 1，指定地点之间没有可以行车的道路
     * 2，起点/终点 距离所有道路均距离过远（例如在海洋/矿业）
     * 3，起点/终点不在中国境内
     * @since V1.0.0
     */
    private errorCode;
    /**
     * 起点坐标，起点坐标序列号（从１开始）<br>
     *     如传入4个起点，originId为1则表示第一个点对应的结果
     * @since V1.0.0
     */
    getOriginId(): number;
    /**
     * 终点坐标，终点坐标序列号（从１开始）<br>
     *     虽然终点仅支持一个坐标，但为了和起点统一也按照坐标序列号方式返回
     * @since V1.0.0
     */
    getDestId(): number;
    /**
     * 路径距离，单位：米
     * @since V1.0.0
     */
    getDistance(): number;
    /**
     * 预计行驶时间，单位：秒
     * @since V1.0.0
     */
    getDuration(): number;
    /**
     * 仅在出错的时候显示该字段。大部分显示“未知错误”<br>
     * 由于此接口支持批量请求，建议不论批量与否用此字段判断请求是否成功
     * @since V1.0.0
     */
    getErrorInfo(): string;
    /**
     * 仅在出错的时候显示此字段。
     * 错误码，在驾车模式下：<br>
     * {@link #ERROR_CODE_NO_DRIVE} 1，指定地点之间没有可以行车的道<br>
     * {@link #ERROR_CODE_TOO_FAR} 2，起点/终点 距离所有道路均距离过远（例如在海洋/矿业）<br>
     * {@link #ERROR_CODE_NOT_IN_CHINA} 3，起点/终点不在中国境内<br>
     * @since V1.0.0
     *
     */
    getErrorCode(): number | null;
    /**
     * 起点坐标，起点坐标序列号（从１开始）
     * @param originId 起点坐标，起点坐标序列号（从１开始）
     * @since V1.0.0
     */
    setOriginId(v73: number): void;
    /**
     * 终点坐标，终点坐标序列号（从１开始）
     * @param destId 终点坐标，终点坐标序列号（从１开始）
     * @since V1.0.0
     */
    setDestId(u73: number): void;
    /**
     * 路径距离，单位：米
     * @param distance 路径距离，单位：米
     * @since V1.0.0
     */
    setDistance(distance: number): void;
    /**
     * 预计行驶时间，单位：秒
     * @param duration 预计行驶时间，单位：秒
     * @exclude javadoc中不显示
     * @since V1.0.0
     */
    setDuration(duration: number): void;
    /**
     * 仅在出错的时候显示该字段。大部分显示“未知错误”<br>
     * 由于此接口支持批量请求，建议不论批量与否用此字段判断请求是否成功<br>
     * @since V1.0.0
     */
    setErrorInfo(errorInfo: string): void;
    /**
     * 仅在出错的时候显示此字段。
     * @param errorCode 错误码，在驾车模式下：
     *                  {@link #ERROR_CODE_NO_DRIVE} 1，指定地点之间没有可以行车的道<br>
     *                  {@link #ERROR_CODE_TOO_FAR} 2，起点/终点 距离所有道路均距离过远（例如在海洋/矿业）<br>
     *                  {@link #ERROR_CODE_NOT_IN_CHINA} 3，起点/终点不在中国境内<br>
     * @since V1.0.0
     */
    setErrorCode(errorCode: number): void;
}
