// @keepTs
// @ts-nocheck
import { AMapLocationClientOption } from "../location/AMapLocationClientOption";
import { DPoint } from "../location/DPoint";
import { t1 } from "./core/GeoFenceManager";
import { GeoFenceListener } from "./GeoFenceListener";
import ArrayList from "@ohos.util.ArrayList";
import { GeoFence } from "./GeoFence";
import { AMapLocation } from "../location/AMapLocation";
/**
 * 地理围栏客户端
 *
 * @项目名称： AMapLocationSDK
 * @文件名称：GeoFenceClient
 * @类型名称：GeoFenceClient
 * @since 3.2.0
 */
export declare class GeoFenceClient {
    private mContext?;
    /**
     * 触发围栏行为-进入围栏
     * @since 3.2.0
     */
    static readonly GEOFENCE_IN = 1;
    /**
     * 触发围栏行为-离开围栏
     * @since 3.2.0
     */
    static readonly GEOFENCE_OUT = 2;
    /**
     * 触发围栏行为-停留在围栏内（在围栏内停留10分钟以上）
     * @since 3.2.0
     */
    static readonly GEOFENCE_STAYED = 4;
    private s18?;
    /**
     * 构造方法
     * @param context
     */
    constructor(context: Context);
    /**
     * 获取地理围栏管理类
     *
     * @param context
     * @return
     * @since 3.2.0
     * @author hongming.wang
     * @exclude
     */
    t18(context: Context): t1;
    /**
     * 设置触发地理围栏的条件
     * <p>
     * <b>注意：重复设置不同的触发行为会重复触发围栏</b>
     * </p>
     *
     * @param action
     *            触发围栏的条件
     *            <p>
     *            目前支持的条件有：
     *            <dl>
     *            <dt>{@link #GEOFENCE_IN} 进入</dt>
     *            <dt>{@link #GEOFENCE_OUT} 离开</dt>
     *            <dt>{@link #GEOFENCE_STAYED} 停留</dt>
     *            </dl>
     *            三种条件可以通过|进行组合使用，例如： setActivatesAction(GEOFENCE_IN)为进入提醒<br>
     *            setActivatesAction(GEOFENCE_IN|GEOFENCE_OUT)为进入和离开都提醒<br>
     *            setActivatesAction(GEOFENCE_IN|GEOFENCE_OUT|GEOFENCE_STAYED)
     *            为全部提醒（进入、离开、停留)<br>
     *            </p>
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    setActivateAction(action: number): void;
    /**
     * 设置地理围栏的回调接口
     * @param geoFenceListener
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    setGeoFenceListener(r18: GeoFenceListener): void;
    setLocationClientOption(option: AMapLocationClientOption): void;
    /**
     * 创建自定义围栏
     * <p>
     * 圆形围栏
     * </p>
     *
     * @param point
     *            围栏中心点坐标, 必填项
     * @param radius
     *            围栏半径, 必填项
     * @param customId
     *            自定义的围栏标识， 选填，<b>建议必填并且保证唯一性</b>
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    addRoundGeoFence(point: DPoint, radius: number, customId: string): void;
    /**
     * 创建自定义围栏
     * <p>
     * 多边形围栏
     * </p>
     *
     * @param points
     *            多边形的边界点, 必须大于2个点, 必填项
     * @param customId
     *            自定义的围栏标识， 选填，<b>建议必填并且保证唯一性</b>
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    addPolygonGeoFence(points: ArrayList<DPoint>, customId: string): void;
    /**
     * 创建高德POI地理围栏
     * <p>
     * 根据周边创建围栏
     * <br>
     *     <font color="red"><b>注意：</b>通过此方法创建的围栏半径全部为200米，暂时不支持自定位围栏半径</font>
     * </p>
     *
     * @param keyword
     *            关键字， 例如：肯德基， 必填项
     * @param poiType
     *            poi类型，例如：餐饮， 选填项
     * @param point
     *            中心点坐标， 必填项
     * @param aroundRadius
     *            周边半径,取值范围[1-50000]
     * @param size
     *            最多创建的围栏数目, 最大25个
     * @param customId
     *            自定义的围栏标识， 选填，<b>建议必填并且保证唯一性</b>
     * @since 3.2.0
     * @author hongming.wang
     * @see <a href="http://lbs.amap.com/api/android-location-sdk/download/" target="_blank">POI分类编码表和城市编码表</a>
     */
    addNearbyGeoFence(p18: string, poiType: string, point: DPoint, q18: number, size: number, customId: string): void;
    /**
     * 创建高德POI地理围栏
     * <p>
     * 根据关键字创建围栏<br>
     *     <font color="red"><b>注意：</b>通过此方法创建的围栏半径全部为1000米，暂时不支持自定义围栏半径</font>
     * </p>
     * @param keyword POI关键字， 例如：首开广场, 必填项（keyword和poiType必须至少填一项）
     * @param poiType POI类型，例如：写字楼， 必填项（keyword和poiType必须至少填一项）
     * @param city POI所在的城市名称， 例如：北京, 选填
     * @param size 最大创建的围栏数目，取值范围[1-25]
     * @param customId 自定义的围栏标识， 选填，<b>建议必填并且保证唯一性</b>
     * @since 3.2.0
     * @author hongming.wang
     * @see <a href="http://lbs.amap.com/api/android-location-sdk/download/" target="_blank">POI分类编码表和城市编码表</a>
     */
    addKeywordGeoFence(o18: string, poiType: string, city: string, size: number, customId: string): void;
    /**
     * 创建行政区划围栏
     *
     * @param keyword
     *            关键字 必填项
     * @param customId
     *            自定义的围栏标识， 选填，<b>建议必填并且保证唯一性</b>
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    addDistrictGeoFence(n18: string, customId: string): void;
    /**
     * 移除所有地理围栏
     *
     * @since 3.2.0
     * @author hongming.wang
     *
     */
    removeGeoFence(): void;
    /**
     * 移除指定的geofence
     * <p>
     * 当要移除所有围栏时可以使用{@link #removeGeoFence()}方法 当要销毁GeoFneceClient时，需要调用一次
     * {@link #removeGeoFence()}方法，确保所有围栏已移除
     * </p>
     *
     * @param geoFence
     *            要移除的geofence
     * @return 是否移除成功
     * @since 3.3.0
     */
    removeSpecifyGeoFence(l18: GeoFence): boolean;
    /**
     * 获取所有已经创建的地理围栏
     * @return 所有已经创建的地理围栏
     * @since 3.3.0
     * @author hongming.wang
     *
     */
    getAllGeoFence(): ArrayList<GeoFence> | undefined;
    /**
     * 设置围栏是否生效，
     * @param fenceId 需要改变的地理围栏的fenceId
     * @param able 是否生效，true:生效；false:不生效, 默认：true
     * @since 3.6.0
     * @author hongming.wang
     */
    setGeoFenceAble(i18: string, j18: boolean): void;
    /**
     * 暂停地理围栏
     * <p>
     *     暂停地理围栏的监听、同时地理围栏内部的定位也会停止
     * </p>
     * @since 3.6.0
     * @author hongming.wang
     */
    pauseGeoFence(): void;
    /**
     * 恢复地理围栏
     * <p>
     *     恢复地理围栏的监听、同时地理围栏内部的定位也会重新开始定位<br>
     *     <font color="red"><b>注意：</b>通过setGeoFenceAble接口设置为false的围栏不会重新生效</font>
     * </p>
     * @since 3.6.0
     * @author hongming.wang
     */
    resumeGeoFence(): void;
    /**
     * 地理围栏是否已经暂停
     *
     * @return 地理围栏是否处于暂停状态
     * @author hongming.wang
     * @since 3.6.0
     */
    isPause(): boolean;
    /**
     * 检查围栏
     * @param loc
     */
    doCheckFence(g18: AMapLocation | undefined): void;
}
