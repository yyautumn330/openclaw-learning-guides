// @keepTs
// @ts-nocheck
import { AMapLocation } from "./AMapLocation";
import { AMapLocationClientOption } from "./AMapLocationClientOption";
import { j1 } from "./AMapLocationListener";
import { p19 } from "./IReGeoLocationCallback";
import Notification from "@system.notification";
/**
 * 定位服务类。此类提供单次定位、持续定位、最后位置相关功能。
 *
 * @创建时间：2015-10-19 下午3:15:39
 * @项目名称：AMapLocationSDK2.0
 * @author liqi
 * @version 2.0.0
 * @since 2.0.0
 * @文件名称：LocationManagerProxy.java
 */
export declare class n1 {
    private ctx?;
    private u19?;
    constructor(ctx: Context);
    /**
     * 主动合规，当检查设置隐私政策异常的时候，抛出异常
     * @param context
     *
     * @since 5.6.0
     * @exclude
     */
    private v19;
    /**
     * 设置定位参数
     *
     * @param option
     *            定位参数
     * @since 2.0.0
     */
    setLocationOption(option: AMapLocationClientOption): void;
    /**
     * 设置定位回调监听
     * @param listener
     *            定位完成后的回调接口
     * @since 2.0.0
     */
    setLocationListener(listener: j1): void;
    /**
     * 开始定位
     * @since 2.0.0
     */
    startLocation(): void;
    /**
     * 停止定位
     * @since 2.0.0
     */
    n11(): void;
    /**
     * 获取最后位置
     *
     * @return 最后一次定位的位置信息
     * @since 2.0.0
     */
    w19(): AMapLocation | undefined;
    /**
     * 启动H5辅助定位
     * <p>
     *     <li>只适用于Android 4.2及以后版本</li>
     *     <li>该接口只用于配合Web JS API的H5辅助定位，开启后并没有开始定位，开始定位由JS API触发。</li>
     *     <li>建议在WebView控件初始化之后就调用该接口，尽量不要在WebView执行loadUrl之后调用</li>
     * </p>
     * @param webView 自定义的webView
     * @since 3.8.0
     */
    x19(): void;
    /**
     * 停止辅助定位
     * <p>
     *     如果已经调用了startAssistantLocation接口，在destroy时请调用该接口
     * </p>
     * @since 2.0.0
     */
    y19(): void;
    /**
     * 获取定位sdk版本信息
     * @return sdk版本信息
     * @since 2.0.0
     */
    getVersion(): string;
    /**
     * 设置包含隐私政策，并展示用户授权弹窗 <b>必须在AmapLocationClient实例化之前调用</b>
     *
     * @param context
     * @param isContains: 是隐私权政策是否包含高德开平隐私权政策  true是包含
     * @param isShow: 隐私权政策是否弹窗展示告知用户 true是展示
     * @since 5.6.0
     */
    static updatePrivacyShow(context: Context, t19: boolean, isShow: boolean): void;
    /**
     * 设置是否同意用户授权政策 <b>必须在AmapLocationClient实例化之前调用</b>
     * @param context
     * @param isAgree:隐私权政策是否取得用户同意  true是用户同意
     *
     * @since 5.6.0
     */
    static updatePrivacyAgree(context: Context, s19: boolean): void;
    /**
     * 设置apikey <b>必须在AmapLocationClient实例化之前调用</b>
     *
     * @param apiKey
     *            要设置的apikey
     * @since 2.0.0
     */
    static setApiKey(r19: string): void;
    /**
     * 本地定位服务是否已经启动，用于用户检查服务是否已经启动
     *
     * @return true:已经启动
     * @since 2.0.0
     */
    isStarted(): boolean;
    /**
     * 移除定位监听
     *
     * @param listener 要移除的定位监听
     * @since 2.0.0
     */
    z19(listener: j1): void;
    /**
     * 设置获取逆地理信息的定位监听回调
     *
     * @param callback 带有逆地理信息的定位监听
     * @since 6.4.9
     */
    a20(callback: p19): void;
    /**
     * 获取带有逆地理信息的定位
     *
     * @param location 要获取逆地理信息的位置
     * @since 6.4.9
     */
    b20(location: AMapLocation): void;
    /**
     * 销毁定位,释放定位资源, 当不再需要进行定位时调用此方法
     * <p>
     * <b>该方法会释放所有定位资源，调用后再进行定位需要重新实例化AMapLocationClient</b>
     * </p>
     * @since 2.0.0
     */
    onDestroy(): void;
    /**
     * 开启后台定位功能
     * <font color="red"><b>注意:</b></font>
     * 如果您设置了target>=28,需要增加android.permission.FOREGROUND_SERVICE权限,<br/>
     * 如果您的app需要运行在Android Q版本的手机上，需要为ApsService增加android:foregroundServiceType="location"属性，
     * 例：&lt;service
     *             android:name="com.amap.api.location.APSService"
     *             android:foregroundServiceType="location"&#x2F;&gt;
     * <p>
     * 主要是为了解决Android 8.0以上版本对后台定位的限制，开启后会显示通知栏,如果您的应用本身已经存在一个前台服务通知，则无需再开启此接口<br>
     * <font color="red"><b>注意:</b></font>启动后台定位只是代表开启了后台定位的能力，并不代表已经开始定位，开始定位请调用{@link #startLocation()}。<br>
     * 建议：在整个APP中如果存在多个AMapLocationClient，只需要其中一个开启就可以了，无需重复启动，重复启动也只会显示一个通知栏。
     * </p>
     *
     * @param notificationId 通知栏ID,建议这个app唯一; 不能为0
     * @param notification   自定义通知栏，使用者可以根据自己业务需求自定义Notification，将创建好的Notification对象传入；不能为null
     * @since 3.8.0
     */
    c20(notificationId: number, notification: Notification): void;
    /**
     * 关闭后台定位功能
     * <p>
     * 与{@link #enableBackgroundLocation(int, Notification)}配对使用<br>
     * <font color="red"><b>注意:</b></font>关闭后台定位功能只是代表不再提供后台定位的能力，并不是停止定位，停止定位请调用{@link #stopLocation()}。<br>
     * 如果在整个APP中如果有调用{@link #enableBackgroundLocation(int, Notification)}，必须调用该方法。<br>
     * 如果同时有多个AMapLocationClient调用了{@link #enableBackgroundLocation(int, Notification)}，只有全部的client
     * 都调用了disableBackgroundLocation（true),通知栏才会消失。
     * <p>
     * 注意：如果您设置了target>=28,需要增加android.permission.FOREGROUND_SERVICE权限
     *
     * @param removeNotification 是否移除通知栏， true：移除通知栏，false：不移除通知栏，可以手动移除
     */
    d20(q19: boolean): void;
    /**
     * 获取设备号
     * @param context
     * @return 设备号, 如果获取不到返回null
     * @since 4.5.1
     */
    static getDeviceId(context: Context): string;
    /**
     * 设置host 可以让sdk中所有请求都执行设置的地址，其中真实host存放在Header中
     * 设置空表示关闭
     * @exclude javadoc中不显示
     * @since 5.3.0
     */
    static e20(host: string): void;
}
