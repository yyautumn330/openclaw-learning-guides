// @keepTs
// @ts-nocheck
/**
 * 定位参数设置，通过这个类可以对定位的相关参数进行设置 <br>
 * 在<link>AMapLocationClient</link>进行定位时需要这些参数
 *
 * @创建时间：2015-9-1 上午9:56:45
 * @项目名称：AMapLocationSDK
 * @author liqi
 * @version 2.0.0
 * @since 2.0.0
 * @文件名称：AMapLocationClientOption.java
 */
export declare class AMapLocationClientOption {
    private static i21;
    private static j21;
    private static k21;
    private static l21;
    /**
     * 定位间隔
     */
    private interval;
    /**
     * 超时时间
     */
    private n21;
    /**
     * 是否只定位一次
     */
    private o21;
    /**
     * 是否允许模拟位置，默认为false，不允许
     */
    private p21;
    /**
     * 是否返回地址信息，默认为false,返回地址信息
     */
    private q21;
    /**
     * 主动刷新还是被动刷新WIFI,默认为true，主动刷新
     * @deprecated
     */
    private r21;
    /**
     * 记录上次 isWifiActiveScan 状态
     */
    private s21;
    /**
     * 定位模式
     */
    private t21;
    /**
     * 定位协议，默认HTTPS
     */
    private u21;
    /**
     * 退出时是否同时退出service，默认:false,不退出
     */
    private v21;
    /**
     * 只在高精度定位模式下的单次定位有效<br>
     * 是否优先等待卫星定位结果，默认为false，不等待
     */
    private w21;
    /**
     * 返回位置坐标是否需要偏转，默认true:偏转
     */
    private isOffset;
    /**
     * 是否使用缓存策略， 默认为true 使用缓存策略
     * @since 2.5.0
     */
    private x21;
    /**
     * 单次定位是否等待设备刷新AP源之后发起定位，提高精度
     * @since 2.6.0
     */
    private y21;
    /**
     * 设置是否开启设备传感器 默认false
     * @since 3.1.0
     */
    private z21;
    /**
     * 是否允许WIFI刷新，停止刷新的同时也会停止主动刷新，停止以后完全依赖于系统刷新，定位精度可能造成误差
     * @since 3.2.0
     */
    private a22;
    /**
     * 跨应用缓存的有效时间，默认30s
     * @since 3.6.0
     */
    private b22;
    /**
     * GpsFirst的超时时间, 默认30s
     * @since 4.5.0
     */
    private c22;
    /**
     * 逆地理的语言
     * @since 3.7.0
     */
    private d22;
    private e22;
    private f22;
    private g22;
    /**
     * 优先北斗定位
     */
    private h22;
    /**
     * 是否允许定位服务自启动
     */
    private i22;
    /**
     * 停止定位时是否允许更新基站信息
     */
    private j22;
    /**
     * 是否开启系统网络定位
     */
    private k22;
    /**
     * 是否开启高德网络定位
     */
    private l22;
    /**
     * 用户设置的KEY
     */
    private static n22;
    /**
     * 仅设备模式的距离控制
     * @since 3.7.0
     */
    private o22;
    private p22?;
    private q22;
    private r22?;
    /**
     * 是否开启始终扫描开关
     * @since 4.3.0
     * @exclude
     */
    static s22: boolean;
    /**
     * wifi扫描间隔
     * @since 4.4.0
     * @exclude
     */
    static t22: number;
    constructor();
    /**
     * 是否开启高德网络定位<br>
     * 默认值：true
     *
     * @return true:是<br>
     *         false:否
     * @since 6.4.6
     */
    u22(): boolean;
    /**
     * 设置是否开启高德网络定位<br>
     * 默认值：true
     *
     * @param isLBSLocationEnable
     *            是否开启高德网络定位 <br>
     *            true:是 <br>
     *            false:否
     * @since 6.4.6
     */
    v22(h21: boolean): void;
    /**
     * 是否开启系统网络定位<br>
     * 默认值：true
     *
     * @return true:是<br>
     *         false:否
     * @since 6.4.4
     */
    w22(): boolean;
    /**
     * 设置开启系统网络定位<br>
     * 默认值：true
     *
     * @param sysNetworkLocEnable
     *            是否开启系统网络定位 <br>
     *            true:是 <br>
     *            false:否
     * @since 6.4.4
     */
    x22(g21: boolean): void;
    /**
     * 停止定位时是否允许更新基站信息<br>
     * 默认值：true
     *
     * @return true:是<br>
     *         false:否
     * @since 6.4.4
     */
    y22(): boolean;
    /**
     * 设置停止定位时是否允许更新基站信息<br>
     * 默认值：true
     *
     * @param noLocReqCgiEnable
     *            停止定位时是否允许更新基站信息 <br>
     *            true:是 <br>
     *            false:否
     * @since 6.4.4
     */
    z22(f21: boolean): void;
    /**
     * 是否允许定位服务自启动<br>
     * 默认值：true
     *
     * @return true:是<br>
     *         false:否
     * @since 6.4.0
     */
    a23(): boolean;
    /**
     * 设置是否允许定位服务自启动<br>
     * 默认值：true
     *
     * @param selfStartServiceEnable
     *            是否允许定位服务自启动 <br>
     *            true:是 <br>
     *            false:否
     * @since 6.4.0
     */
    b23(e21: boolean): void;
    /**
     * 设置是否打开缓存提速开关
     * @param fastCallBack
     * @since 5.3.0
     * @exclude
     */
    c23(d21: boolean): void;
    /**
     * 获取是否打开2分钟缓存提速开关
     * @since 5.3.0
     * @exclude
     */
    d23(): boolean;
    /**
     * 设置缓存提速超时时间
     * @param fastCallBackTime
     * @since 5.3.0
     * @exclude
     */
    e23(c21: number): void;
    /**
     * 获取缓存提速超时时间
     * @since 5.3.0
     * @exclude
     */
    f23(): number;
    /**
     * 设置提速功能缓存最大时间
     * @param timeOut
     * @since 5.3.0
     * @exclude
     */
    g23(timeOut: number): void;
    /**
     * 获取提速功能缓存最大时间
     * @since 5.3.0
     * @exclude
     */
    h23(): number;
    /**
     * 获取通过client的setApikey接口设置的key
     * @return
     * @since 2.6.0
     * @exclude
     */
    static i23(): string;
    /**
     * 获取是否允许模拟位置</br>
     * <p>
     *     从<b>3.4.0</b>开始，默认值为true，允许模拟;<br>
     *     <b>3.4.0</b>之前的版本，默认值为false，不允许模拟
     * </p>
     * @return true:允许模拟位置<br>
     *         false:不允许模拟位置
     * @since 2.0.0
     */
    getMockEnable(): boolean;
    /**
     * 设置是否允许模拟位置 <br>
     * <p>
     *     从<b>3.4.0</b>开始，默认值为true，允许模拟;<br>
     *     <b>3.4.0</b>之前的版本，默认值为false，不允许模拟
     * </p>
     * @param isMockEnable
     *            是否允许模拟位置<br>
     *            true:允许模拟位置<br>
     *            false：不允许模拟位置
     * @since 2.0.0
     */
    setMockEnable(b21: boolean): AMapLocationClientOption;
    /**
     * 获取发起定位请求的时间间隔 <br>
     * 默认值：2000毫秒
     *
     * @return 时间间隔<br>
     *         单位：毫秒
     * @since 2.0.0
     */
    getInterval(): number;
    /**
     * 设置发起定位请求的时间间隔<br>
     * 单位：毫秒<br>
     * 默认值：2000毫秒
     *
     * @param interval
     *            时间间隔 <br>
     *            单位：毫秒<br>
     *            <b>小于1000毫秒时，按照1000毫秒计算</b>
     * @return 包含新的定位间隔的AMapLocationClientOption对象
     * @since 2.0.0
     */
    setInterval(interval: number): AMapLocationClientOption;
    /**
     * 是否单次单次定位<br>
     * 默认值：false
     *
     * @return true:是<br>
     *         false:否
     * @since 2.0.0
     */
    getOnceLocation(): boolean;
    /**
     * 设置是否单次定位<br>
     * 默认值：false
     *
     * @param isOnceLocation
     *            是否单次定位 <br>
     *            true:是 <br>
     *            false:否
     * @return 包含是否单次定位标识的AMapLocationClientOption对象
     * @since 2.0.0
     */
    setOnceLocation(a21: boolean): AMapLocationClientOption;
    /**
     * 获取是否需要地址信息 <br>
     * 默认值：false 不返回地址信息<br>
     * <b>2.9.0</b>之前的版本定位类型为{@link AMapLocation#LOCATION_TYPE_GPS}时不会返回地址信息<br>
     * 自<b>2.9.0</b>版本开始，当类型为{@link AMapLocation#LOCATION_TYPE_GPS}时也可以返回地址信息(需要网络通畅，第一次有可能没有地址信息返回）
     *
     * @return true:需要<br>
     * false:不需要
     * @since 2.0.0
     */
    getNeedAddress(): boolean;
    /**
     * 设置是否返回地址信息，默认返回地址信息 <br>
     * 默认值：true, 返回地址信息
     * <p>
     * <b>2.9.0</b>之前的版本定位类型为{@link AMapLocation#LOCATION_TYPE_GPS}时不会返回地址信息<br>
     * 自<b>2.9.0</b>版本开始，当类型为{@link AMapLocation#LOCATION_TYPE_GPS}时也可以返回地址信息(需要网络通畅，第一次有可能没有地址信息返回）
     * </p>
     *
     * @param isNeedAddress 是否返回地址信息<br>
     *                      true:需要<br>
     *                      false:不需要
     * @return 包含是否返回地址信息标识的AMapLocationClientOption对象
     * @since 2.0.0
     */
    setNeedAddress(z20: boolean): AMapLocationClientOption;
    /**
     * 是否主动刷新WIFI <br>
     * 默认值：true 主动刷新<br>
     * 模式为<b>仅设备定位(Device_Sensors)</b>时无效
     * @deprecated
     * @return true:主动刷新<br>
     *         false:被动刷新
     * @since 2.0.0
     */
    getWifiActiveScan(): boolean;
    /**
     * 设置是否主动刷新WIFI <br>
     * 默认值：true 主动刷新<br>
     * 模式为<b>仅设备模式(Device_Sensors)</b>时无效
     * @deprecated
     * @param isWifiActiveScan
     *            是否主动刷新WIFI true:主动刷新<br>
     *            false:被动刷新
     * @since 2.0.0
     */
    setWifiActiveScan(y20: boolean): AMapLocationClientOption;
    /**
     * 获取是否允许主动调用WIFI刷新
     * @return 是否允许WIFI刷新
     * @since 3.2.0
     */
    getWifiScan(): boolean;
    /**
     * 设置是否允许调用WIFI刷新
     * <p>
     * 默认值为true，当设置为false时会停止主动调用WIFI刷新，将会极大程度影响定位精度，但可以有效的降低定位耗电<br>
     * </p>
     *
     * @param isWifiPassiveScan
     *            是否允许wifi刷新，默认为：true
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    setWifiScan(x20: boolean): AMapLocationClientOption;
    /**
     * 获取定位模式 默认值：Hight_Accuracy 高精度模式<br>
     *
     * @return 定位模式
     * @since 2.0.0
     */
    getLocationMode(): AMapLocationMode;
    /**
     * 设置定位模式
     *
     * @param locationMode
     *            定位模式<br>
     *            默认值：Hight_Accuracy 高精度模式<br>
     *            模式参见AMapLocationOption.AMapLocationMode
     * @return 包含最新定位模式的LocationManagerOption对象
     * @since 2.0.0
     */
    setLocationMode(w20: AMapLocationMode): AMapLocationClientOption;
    /**
     * 获取定位协议 默认值：HTTPS https协议<br>
     *
     * @return 定位协议
     * @since 2.9.0
     */
    getLocationProtocol(): AMapLocationProtocol;
    /**
     * 设置定位协议
     * @param amapLocationProtocol
     *         协议类型<br>
     *         默认值：HTTPS https协议<br>
     *         模式参见AMapLocationOption.AMapLocationProtocol
     * @since 2.9.0
     */
    setLocationProtocol(v20: AMapLocationProtocol): void;
    /**
     * 获取退出时是否杀死进程<br>
     * 默认值:false, 不杀死 <br>
     * <p>
     * <font color="red"><b>注意：如果设置为true，并且配置的service不是remote的则会杀死当前页面进程，请慎重使用
     * </b> </font>
     * </p>
     * @return true:退出时杀死<br>
     *         false:退出时不杀死
     * @since 2.0.0
     */
    k23(): boolean;
    /**
     * 设置退出时是否杀死进程<br>
     * 默认值:false, 不杀死 <br>
     * <p>
     * <font color="red"><b>注意：如果设置为true，并且配置的service不是remote的则会杀死当前页面进程，请慎重使用
     * </b> </font>
     * </p>
     *
     * @param isKillProcess
     *            退出时是否杀死进程<br>
     *            true:退出时杀死<br>
     *            false:退出时不杀死
     * @return 包含退出时是否杀死进程标识的AMapLocationClientOption对象
     * @since 2.0.0
     */
    l23(u20: boolean): AMapLocationClientOption;
    /**
     * 获取高精度模式下单次定位是否优先返回卫星定位信息<br>
     * 默认值：false <br>
     * <p>
     * <b>只有在单次定位高精度定位模式下有效<br>
     * 为true时，会等待卫星定位结果返回，最多等待30秒，若30秒后仍无卫星定位结果返回，返回网络定位结果</b>
     *
     * @return 是否优先返回卫星定位信息
     *         </p>
     *
     * @return 是否优先返回卫星定位信息<br>
     * @since 2.0.0
     */
    n23(): boolean;
    /**
     * 设置首次定位是否等待卫星定位结果<br>
     * 默认值：false <br>
     * <p><b>只有在单次定位高精度定位模式下有效</b><br>
     * 设置为true时，会等待卫星定位结果返回，最多等待30秒，若30秒后仍无卫星定位结果返回，返回网络定位结果<br>
     * 从<b>4.5.0</b>版本开始等待卫星定位结果返回的时间可以通过 {@link #setGpsFirstTimeout(long)}进行设置
     * </p>
     *
     * @param isGpsFirst
     *            是否优先返回卫星定位信息<br>
     * @return 包含是否优先返回卫星定位信息标识的AMapLocationClientOption对象
     * @since 2.0.0
     * @see #setGpsFirstTimeout(long)
     */
    o23(t20: boolean): AMapLocationClientOption;
    /**
     * 设置优先返回卫星定位信息时等待卫星定位结果的超时时间，单位：毫秒
     * <p>
     *     只有在{@link #setGpsFirst(boolean)}设置为true时才有效。
     *     最小间隔5s, 最大间隔30s
     * </p>
     * @param timeout 优先返回卫星定位信息时等待卫星定位结果的超时时间， 范围[5000-30000]， 单位：毫秒
     * @return 包含优先返回卫星定位信息时等待卫星定位结果的超时时间AMapLocationClientOption对象
     * @see #setGpsFirst(boolean)
     * @since 4.5.0
     */
    p23(timeout: number): AMapLocationClientOption;
    /**
     * 获取优先返回定位信息时等待GPS结果的超时时间
     * @return 优先返回定位信息时等待GPS结果的超时时间
     * @since 4.5.0
     */
    s23(): number;
    /**
     * 优先使用北斗定位
     * @return
     */
    t23(): boolean;
    /**
     * 设置是否优先使用北斗定位
     * 默认值 false
     * @param isBeidouFirst
     * @return
     */
    u23(s20: boolean): AMapLocationClientOption;
    /**
     * 获取AMapLocationClientOption对象的拷贝
     * @since 2.0.0
     */
    /**
     * 获取联网超时时间<br>
     * 单位：毫秒<br>
     * 默认值：30000毫秒 <br>
     *
     * @return 超时时间
     * @since 2.0.0
     */
    v23(): number;
    /**
     * 设置联网超时时间<br>
     * 单位：毫秒<br>
     * 默认值：30000毫秒 <br>
     *
     * @param httpTimeOut
     *            联网超时时间<br>
     *            单位：毫秒
     * @since 2.0.0
     */
    w23(r20: number): AMapLocationClientOption;
    /**
     * 获取是否需要偏转<br>
     * 默认值：true 偏转
     *
     * @return 是否需要偏转<br>
     *         true:偏转<br>
     *         false:不偏转
     * @since 2.3.0
     * @exclude
     */
    getOffset(): boolean;
    /**
     * 设置是否偏转, 默认为true 偏转
     * @param isOffset 是否偏转
     * @return 包含新设置是否偏转的AMapLocationClientOption对象
     * @since 2.3.0
     * @exclude
     */
    x23(q20: boolean): AMapLocationClientOption;
    /**
     * 获取是否使用缓存策略， 默认为true 使用缓存策略
     * @return 是否使用缓存策略
     * @since 2.5.0
     * @exclude
     */
    getLocationCacheEnable(): boolean;
    /**
     * 设置是否使用缓存策略, 默认为true 使用缓存策略
     * @param isLocationCacheEnable 是否使用缓存策略
     * @since 2.5.0
     *
     */
    setLocationCacheEnable(p20: boolean): AMapLocationClientOption;
    /**
     * 获取首次定位是否等待WIFI列表刷新
     * @return 首次定位否等待WIFI列表刷新
     * @since 2.6.0
     * @exclude
     */
    getOnceLocationLatest(): boolean;
    /**
     * 设置定位是否等待WIFI列表刷新
     * <p>定位精度会更高，但是定位速度会变慢1-3秒</p>
     * <p>
     *     <b>从3.7.0版本开始，支持连续定位（连续定位时首次会等待刷新）</b>
     *     3.7.0之前的版本，仅适用于单次定位，当设置为true时，连续定位会自动变为单次定位,
     </p>
     * @param isOnceLocationLatest 是否等待WIFI列表刷新
     * @since 2.6.0
     *
     */
    setOnceLocationLatest(o20: boolean): AMapLocationClientOption;
    /**
     * 获取是否使用设备传感器
     * @return
     * @since 3.1.0
     * @exclude
     */
    y23(): boolean;
    /**
     * 设置是否使用设备传感器
     * <p>
     *     默认值：false 不使用设备传感器
     * </p>
     * @since 3.1.0
     * @param sensorEnable 是否开启设备传感器，当设置为true时，网络定位可以返回海拔、角度和速度。
     */
    z23(n20: boolean): AMapLocationClientOption;
    /**
     * 设置跨应用缓存的有效时间 单位：毫秒（ms)
     * @param lifeCycle 跨应用缓存的有效时间， 默认30s
     * @return
     * @since 3.6.0
     * @exclude
     */
    a24(m20: number): AMapLocationClientOption;
    /**
     * 获取跨应用缓存的有效时间， 默认30s
     * @return 跨应用缓存的有效时间 单位：毫秒（ms)
     * @since 3.6.0
     * @exclude
     */
    b24(): number;
    /**
     * 获取逆地理的语言
     * @since 3.7.0
     * @return
     * @exclude
     */
    c24(): f20;
    /**
     * 设置逆地理信息的语言,目前之中中文和英文
     * <p>
     *     默认值：{@link GeoLanguage#DEFAULT }
     * </p>
     * @since 3.7.0
     * @param geoLanguage
     * @return 包含逆地理语言信息的AMapLocationClientOption对象
     */
    d24(l20: f20): AMapLocationClientOption;
    /**
     * 设置是否下载集团偏转so，如果要一开始就不下载，需要保证在所有的Client初始化之前设置为false，文档中不体现
     * @param isDownload
     * @since 3.7.0
     * @exclude
     */
    static e24(k20: boolean): void;
    /**
     * 获取是否下载集团偏转so，文档中不体现
     * @return 是否下载集团偏转so
     * @since 3.7.0
     * @exclude
     */
    static f24(): boolean;
    /**
     * 获取仅设备模式/高精度模式的系统定位自动回调最少间隔距离值 <br>
     * 默认值：0米
     * <p>
     *     只有当定位模式为{@link AMapLocationMode#Device_Sensors}（仅设备模式）或 {@link AMapLocationMode#Hight_Accuracy}（高精度模式）有效
     * </p>
     * @return
     * @since 3.7.0
     */
    g24(): number;
    /**
     * 设置仅设备模式/高精度模式的系统定位自动回调最少间隔距离值 <br>
     * 单位：米 <br>
     * 默认值：0米
     * <p>
     *     只有当定位模式为{@link AMapLocationMode#Device_Sensors}（仅设备模式）或 {@link AMapLocationMode#Hight_Accuracy}（高精度模式）有效，值小于0时无效
     * </p>
     * @param distanceFilter
     * @since 3.7.0
     * @return 包含新设置最少距离值的AMapLocationClientOption对象
     */
    h24(j20: number): AMapLocationClientOption;
    /**
     * 设置定位场景，根据场景快速修改option，不支持动态改变，修改后需要调用{@link AMapLocationClient#startLocation()}使其生效<br>
     * <p>
     *     当不需要场景时，可以设置为NULL，
     * </p>
     * <b>注意：
     * <li><font color="red">不建议设置场景和自定义option混合使用</font></li>
     * <li>设置场景后，如果已经开始定位了，建议调用一次{@link AMapLocationClient#stopLocation()},然后主动调用一次{@link AMapLocationClient#startLocation()}以保证option正确生效</li>
     * <li>当主动设置的option和场景中的option有冲突时，以后设置的为准，
     * 比如：签到场景中默认的为单次定位，当主动设置option为连续定位时，
     * 如果先设置的场景，后改变的option，这时如果不调用startLocation不会变为连续定位，如果调用了startLocation则会变为连续定位，
     * 如果先改变option，后设置场景为签到场景，则会变为单次定位</li></b>
     * @param locationPurpose 定位场景, 默认值 :NULL(无场景设置）
     * @since 3.7.0
     * @return AMapLocationClientOption
     */
    j24(i20: g20): AMapLocationClientOption;
    /**
     * 获取定位场景
     * @since 3.7.0
     * @return 定位场景
     */
    k24(): g20 | undefined;
    /**
     * 是否开启始终wifi扫描
     * <p>
     *     <li>只有设置了android.permission.WRITE_SECURE_SETTINGS权限后才会开启</li>
     *     <li>开启后，即使关闭wifi开关的情况下也会扫描wifi</li>
     *     <li>默认值为：true, 开启wifi始终扫描</li>
     * </p>
     * @return 是否开启始终wifi扫描
     * @since 4.3.0
     */
    static isOpenAlwaysScanWifi(): boolean;
    /**
     * 设置是否开启wifi始终扫描
     * <p>
     *     <li>只有设置了android.permission.WRITE_SECURE_SETTINGS权限后才会开启</li>
     *     <li>开启后，即使关闭wifi开关的情况下也会扫描wifi</li>
     *     <li>默认值为：true, 开启wifi始终扫描</li>
     *     <li>此方法为静态方法，设置一次后其他定位Client也会生效</li>
     * </p>
     * @param openAlwaysScanWifi 是否开启
     * @since 4.3.0
     */
    static setOpenAlwaysScanWifi(h20: boolean): void;
    /**
     * 设置Android P上wifi扫描间隔
     * @param interval
     * @exclude
     * @since 4.4.0
     */
    static l24(interval: number): void;
    /**
     * 获取Android P上wifi扫描间隔
     * @return
     * @exclude
     * @since 4.4.0
     */
    n24(): number;
}
/**
 * 定位模式，目前支持三种定位模式<br>
 * <li>
 * <p>
 * 高精度定位模式：
 * </p>
 * 在这种定位模式下，将同时使用高德网络定位和卫星定位,优先返回精度高的定位
 * <li>
 * <p>
 * 低功耗定位模式：
 * </p>
 * 在这种模式下，将只使用高德网络定位
 * <li>
 * <p>
 * 仅设备定位模式：
 * </p>
 * 在这种模式下，将只使用卫星定位。
 *
 * @创建时间： 2015年10月22日 下午8:56:26
 * @项目名称： AMapLocationSDK
 * @author hongming.wang
 * @version 2.0.0
 * @since 2.0.0
 * @文件名称: LocationManagerOption.java
 * @类型名称: LocationMode
 */
export declare enum AMapLocationMode {
    /**
     * 低功耗模式
     */
    Battery_Saving = 0,
    /**
     * 仅设备模式,不支持室内环境的定位
     */
    Device_Sensors = 1,
    /**
     * 高精度模式
     */
    Hight_Accuracy = 2
}
/**
 * 定位协议，目前支持二种定位协议<br>
 * <li>
 * <p>
 * http协议：
 * </p>
 * 在这种定位协议下，会使用http请求定位
 * <li>
 * <p>
 * https协议：
 * </p>
 * 在这种定位协议下，会使用https请求定位
 * @since 2.9.0
 */
export declare enum AMapLocationProtocol {
    /**
     * http协议
     */
    HTTP = 0,
    /**
     * https协议
     */
    HTTPS = 1
}
/**
 * 设置返回逆地理使用的语言，目前有三种选择<br>
 * <li>
 * <p>
 * 默认：
 * </p>
 * 选择这种模式，会根据位置按照相应的语言返回逆地理信息，在国外按英语返回，在国内按中文返回 <li>
 * <p>
 * 中文：
 * </p>
 * 设置只中文后，无论在国外还是国内都为返回中文的逆地理信息 <li>
 * <p>
 * 英文：
 * </p>
 * 设置英文后，无论在国外还是国内都为返回英文的逆地理信息
 * @since 3.7.0
 */
export declare enum f20 {
    /**
     * 默认，国外返回英文，国内返回中文
     * @since 3.7.0
     */
    DEFAULT = 0,
    /**
     * 汉语，无论在国内还是国外都返回英文
     * @since 3.7.0
     */
    ZH = 1,
    /**
     * 英语，无论在国内还是国外都返回中文
     * @since 3.7.0
     */
    EN = 2
}
/**
 * 定位场景
 * @since 3.7.0
 * @author hongming.wang
 */
export declare enum g20 {
    /**
     * 签到场景
     * <p>
     *     只进行一次定位返回最接近真实位置的定位结果（定位速度可能会延迟1-3s）
     * </p>
     */
    SignIn = 0,
    /**
     * 出行场景
     * <p>
     *    高精度连续定位，适用于有户内外切换的场景，卫星定位和网络定位相互切换，卫星定位成功之后网络定位不再返回，卫星信号断开之后一段时间才会返回网络结果
     * </p>
     */
    Transport = 1,
    /**
     * 运动场景
     * <p>
     *    高精度连续定位，适用于有户内外切换的场景，卫星定位和网络定位相互切换，卫星定位成功之后网络定位不再返回，卫星信号断开之后一段时间才会返回网络结果
     * </p>
     */
    Sport = 2
}
