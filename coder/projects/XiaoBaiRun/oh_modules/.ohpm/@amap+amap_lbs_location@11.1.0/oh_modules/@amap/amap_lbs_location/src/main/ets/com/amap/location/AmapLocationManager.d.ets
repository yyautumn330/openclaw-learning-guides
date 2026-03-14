// @keepTs
// @ts-nocheck
/**
 * 从3.1.0开始，采用单线程消息模式
 * @创建时间：2015-9-1 上午10:35:11
 * @项目名称：AMapLocationSDK
 * @author liqi
 * @version 1.0
 * @since JDK 1.6.0_21
 * @文件名称：AMapLocationManager.java
 * @类说明：
 */
export declare class o19 {
    private static readonly s1;
    private t24?;
    /**
     * 高德网络定位成功
     */
    private static readonly u24;
    /**
     * GPS定位成功
     */
    private static readonly v24;
    /**
     * GPS关闭或者不可用
     */
    private static readonly w24;
    /**
     * GPS定位改变，主要用于当GPS定位成功后更新{#gpsFixTime}的值
     */
    private static readonly x24;
    /**
     * gps逆地理成功消息
     * @since 2.9
     */
    private static readonly y24;
    /**
     * ngps是否打开
     * @since 2.9
     */
    private static readonly z24;
    /**
     * 没有足够卫星
     * @since 3.1
     */
    private static readonly a25;
    /**
     * 是否安装了高危位置模拟软件
     * @since 4.6.0
     */
    private static readonly b25;
    /**
     * 主线程回调定位结果到用户
     */
    private static readonly c25;
    /**
     * 定位结果返回到子线程
     */
    private static readonly d25;
    /**
     * GPS结果转发到子线程处理，避免ANR
     */
    private static readonly e25;
    /**
     * 如果2S没有返回时，优先返回缓存
     * */
    private static readonly f25;
    /**
     * Network定位改变，主要用于当Network定位成功后更新{#gpsFixTime}的值
     */
    private static readonly g25;
    /**
     * Network定位成功
     */
    private static readonly h25;
    /**
     * Network结果转发到子线程处理，避免ANR
     */
    private static readonly i25;
    /**
     * 无网络异常
     */
    private static readonly j25;
    /**
     * network逆地理成功消息
     */
    private static readonly k25;
    /**
     * 通用逆地理成功信息
     * @since 6.4.9
     */
    private static readonly l25;
    /**
     * 没有足够卫星 or NLP定位未返回结果
     * @since 6.0.0
     */
    private static readonly m25;
    /**
     * 模糊定位成功
     * @since 6.0.0
     */
    private static readonly n25;
    /**
     * 模糊定位改变
     * @since 6.0.0
     */
    private static readonly o25;
    /**
     * 模糊定位逆地理成功消息
     * @since 6.0.0
     */
    private static readonly p25;
    /**
     * 设置监听
     */
    private static readonly q25;
    /**
     * 开始定位
     */
    private static readonly r25;
    /**
     * 停止定位
     */
    private static readonly s25;
    /**
     * 取消监听
     */
    private static readonly t25;
    /**
     * 添加地理围栏
     * @deprecated 3.4.0
     */
    private static readonly u25;
    /**
     * 移除地理围栏
     * @deprecated
     */
    private static readonly v25;
    /**
     * 移除一个地理围栏
     * @deprecated
     */
    private static readonly w25;
    /**
     * 销毁
     */
    private static readonly k6;
    /**
     * 保存最后位置
     * @since 3.1
     */
    private static readonly x25;
    /**
     * 开始GPS定位
     * @since 3.1
     */
    private static readonly y25;
    /**
     * 高德NETWORK定位
     * @since 3.1
     */
    private static readonly z25;
    /**
     * 停止GPS定位
     * @since 3.1
     */
    private static readonly a26;
    /**
     * 设置setoption
     * @since 3.1
     */
    private static readonly b26;
    /**
     * 启动设备传感器， 当gps定位成功一次后启动设备传感器，获取地面气压值
     * @since 3.1.0
     * @deprecated
     */
    private static readonly c26;
    /**
     * 从传感器中获取气压信息
     * @since 3.1.0
     * @deprecated
     */
    private static readonly d26;
    /**
     * 停止设备传感器
     * @since 3.1.0
     * @deprecated
     */
    private static readonly e26;
    /**
     * 保存gps定位的高度和对应的气压信息
     * @since 3.1.0
     * @deprecated
     */
    private static readonly f26;
    /**
     * 开启前台service
     * @since 3.8.0
     */
    private static readonly g26;
    /**
     * 关闭前台service
     * @since 3.8.0
     */
    private static readonly h26;
    /**
     * 检查GPS是否需要重启
     */
    private static readonly i26;
    /**
     * 开始模糊定位
     * @since 6.0.0
     */
    private static readonly j26;
    /**
     * 停止模糊定位
     * @since 6.0.0
     */
    private static readonly k26;
    /**
     * 模糊位置结果转发到子线程处理
     * @since 6.0.0
     */
    private static readonly l26;
    /**
     * 发送是否处于定位中状态
     */
    private static readonly m26;
    private static readonly n26;
    /**
     * 开始系统network定位
     * @since 3.1
     */
    private static readonly o26;
    /**
     * 停止系统network定位
     * @since 3.1
     */
    private static readonly p26;
    /**
     * 检查系统network定位是否需要重启
     */
    private static readonly q26;
    /**
     * 透出lbs定位的定位失败信息
     */
    private static readonly r26;
    private ctx?;
    private s26;
    private t26?;
    private u26?;
    private v26?;
    /**
     * 定位服务是否已经启动
     */
    private w26;
    /**
     * 是否已经开始定位
     */
    private isStartLocation;
    /**
     * 回调函数列表
     */
    private x26;
    /**
     * 用于标记是否已经bind高德地图服务
     */
    private y26;
    /**
     * 标记是否第一次lbs定位
     * @since 3.1
     */
    private static z26;
    /**
     * 标记是否已经进行过首次定位补偿逻辑, 防止多个client同时请求时，每个都会走一次补偿逻辑
     * @since 5.2.0
     */
    static a27: boolean;
    /**
     * 标记是否第一次gps定位
     * @since 3.1
     */
    b27: boolean;
    /**
     * 标记是否第一次模糊定位
     * @since 6.0.0
     */
    c27: boolean;
    /**
     * 标记是否第一次系统网络定位
     * @since 6.0.0
     */
    d27: boolean;
    /**
     * 标记是否第一次后台定位推送初始化
     */
    e27: boolean;
    /**
     * 最后位置的操作类
     */
    private f27?;
    /**
     * 向service发送消息的Messenger
     */
    /**
     * 接收service发送过来的消息,发送给本地Handler
     */
    /**
     * 如果service绑定失败尝试次数等待service绑定
     */
    private g27;
    /**
     * NGPS云控开关
     * @since 2.9
     */
    private h27;
    /**
     * 是否已经执行过destroy
     * @since 3.3.0
     */
    private i27;
    private j27;
    private q7;
    /**
     * add 3.3.0
     */
    /**
     * 是否安装了高危位置模拟软件
     * @since 4.6.0
     */
    private static k27;
    /**
     * APSService是否已经连接成功过
     * @since 3.6.0
     */
    private l27;
    private static readonly m27;
    /**
     * @since 3.4.0
     */
    /**
     * 是否允许直接透出network定位信息
     */
    private n27;
    /**
     * 定位回调信息中-相关权限是否已初始化
     */
    private o27;
    /**
     * ACCESS_WIFI、CHANGE_WIFI 等 权限是否已授权（定位回调信息携带，线上排查定位失败相关问题使用）
     */
    private p27?;
    private q27?;
    private r27?;
    private s27?;
    private t27?;
    private u27?;
    /**
     * @since 5.6.1 定位参数是否已初始化
     */
    /**
     * 逆地理信息回调
     * @since 6.4.9
     */
    private v27?;
    private w27;
    /**
     * 通过Messenger向service发送消息
     * @param message 需要发送的消息代码
     * @since 2.5.0
     */
    private x27?;
    private y27;
    /**
     * 是否已经重新绑定service
     * @since 3.6.0
     */
    private z27;
    private a28;
    private static readonly b28;
    private c28?;
    /**
     * 是否调用前台service相关的接口（调用了startService)
     */
    private d28;
}
