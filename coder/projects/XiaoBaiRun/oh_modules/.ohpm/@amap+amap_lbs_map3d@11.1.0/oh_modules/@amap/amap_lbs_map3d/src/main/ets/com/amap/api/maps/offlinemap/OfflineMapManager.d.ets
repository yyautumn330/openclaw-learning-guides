// @keepTs
// @ts-nocheck
import { OfflineMapCity } from "./OfflineMapCity";
import { OfflineMapProvince } from "./OfflineMapProvince";
import ArrayList from "@ohos.util.ArrayList";
/**
 * 离线地图下载管理类，支持3D矢量地图下载。
 *
 * @since V2.0.1
 */
export declare class OfflineMapManager {
    private static readonly r9;
    private static readonly s9;
    private context?;
    private listener?;
    private t9?;
    /** 下载 更新 删除回调的handler */
    private u9?;
    private v9?;
    /**
     * 根据给定的参数来构造OfflineMapManager对象。
     *
     * @param context  Context对象。
     * @param listener 下载事件监听。
     * @since V2.0.1
     */
    constructor(context: Context, listener: OfflineMapDownloadListener);
    private w9;
    /**
     * 根据给定的城市编码下载该城市的离线地图包<br>
     * 异步方法，如果有注册OfflineMapDownloadListener监听，下载状态会回调onDownload方法
     *
     * @param citycode 城市编码
     * @throws AMapException
     * @since V2.5.1
     */
    downloadByCityCode(q9: string): void;
    /**
     * 根据给定的城市名称下载该城市的离线地图包<br>
     * 异步方法，如果有注册OfflineMapDownloadListener监听，下载状态会回调onDownload方法
     *
     * @param cityname 城市名称
     * @throws AMapException
     * @since V2.5.1
     */
    downloadByCityName(p9: string): void;
    /**
     * 异步方法，如果有注册OfflineMapDownloadListener监听，下载状态会回调onDownload方法。<br>
     * 根据省份名称下载一个省份的离线地图包。<br>
     * 省份离线地图包为改省下各个城市离线数据的合集
     *
     * @param name 省份名称
     * @throws AMapException
     * @since V2.5.1
     */
    downloadByProvinceName(name: string): void;
    /**
     * 根据给定的城市名称删除该城市的离线地图包。<br>
     * 可以删除通过OfflineManager下载的数据;<br>
     * 如果传入参数是省份，则会删除该省份以下的所有城市<br>
     * 异步方法，删除操作会比较耗时，删除状态会在
     * {@link OfflineMapDownloadListener#onRemove(boolean, String, String)} (boolean, String)} 中进行回调返回
     *
     * @param name 城市或省份的名称
     * @since V2.1.0
     */
    remove(name: string): void;
    /**
     * 获取所有存在有离线地图的城市列表。<br>
     *
     * @return ArrayList<OfflineMapCity>
     * @since V2.1.0
     */
    getOfflineMapCityList(): ArrayList<OfflineMapCity> | undefined;
    /**
     * 获取所有存在有离线地图的省的列表。<br>
     * 同步方法
     *
     * @return ArrayList<OfflineMapProvince>
     * @since V2.1.0
     */
    getOfflineMapProvinceList(): ArrayList<OfflineMapProvince> | undefined;
    /**
     * 根据城市编码获取OfflineMapCity对象<br>
     * 同步方法
     *
     * @param cityCode 想查找城市编码
     * @return 返回对应的OfflineMapCity对象
     * @since V2.1.0
     */
    getItemByCityCode(cityCode: string): OfflineMapCity | undefined;
    /**
     * 根据城市名称获取OfflneMapCity对象<br>
     * 同步方法
     *
     * @param cityName 想查找城市名称
     * @return 返回对应的OfflneMapCity对象
     * @since V2.1.0
     */
    getItemByCityName(cityName: string): OfflineMapCity | undefined;
    /**
     * 根据省份名称获取OfflineMapProvince对象<br>
     * 同步方法
     *
     * @param provinceName 省份名称
     * @return 返回对应的OfflineMapProvince对象
     * @since V2.1.0
     */
    getItemByProvinceName(provinceName: string): OfflineMapProvince | undefined;
    /**
     * 所有正在下载或等待下载离线地图的城市列表。<br>
     *
     * @return ArrayList<OfflineMapCity>
     * @since V2.1.0
     */
    getDownloadingCityList(): ArrayList<OfflineMapCity> | undefined;
    /**
     * 所有正在下载或等待下载离线地图的省份列表。<br>
     * 同步方法
     *
     * @return ArrayList<OfflineMapProvince>
     * @since V2.1.0
     */
    getDownloadingProvinceList(): ArrayList<OfflineMapProvince> | undefined;
    /**
     * 返回已经下载完成离线地图的城市列表。<br>
     *
     * @return List<OfflineMapCity>
     * @since V2.1.0
     */
    getDownloadOfflineMapCityList(): ArrayList<OfflineMapCity> | undefined;
    /**
     * 返回已经下载完成离线地图的省份列表。<br>
     *
     * @return ArrayList<OfflineMapProvince>
     * @since V2.1.0
     */
    getDownloadOfflineMapProvinceList(): ArrayList<OfflineMapProvince> | undefined;
    /**
     * 判断该城市或省份是否需要更新，此方法最后使用到了网络操作 异步方法
     *
     * @param city 城市省份的名称
     * @param type 名称或adcode 在此方法中暂时未用到
     * @throws AMapException
     */
    private f10;
    /**
     * 判断传入的城市（城市编码）是否有更新的离线数据包。<br>
     * 异步方法，会回调{@link OfflineMapDownloadListener#onCheckUpdate(boolean, String)}
     * 方法
     *
     * @param citycode 城市编码
     * @throws AMapException 会根据cityCode去找城市，如果找不到就就会抛异常
     * @since V2.5.1
     */
    updateOfflineCityByCode(i9: string): void;
    /**
     * 判断传入的城市（城市名称）是否有更新的离线数据包。 异步方法，会回调
     * {@link OfflineMapDownloadListener#onCheckUpdate(boolean, String)}方法
     *
     * @param cityname 城市名称
     * @throws AMapException 如果名称错误，不存在该城市，会返回无效的参数异常
     * @since V2.5.1
     */
    updateOfflineCityByName(h9: string): void;
    /**
     * 判断传入的省份名称是否有更新的离线数据包。<br>
     * 异步方法，会回调{@link OfflineMapDownloadListener#onCheckUpdate(boolean, String)}
     * 方法
     *
     * @param name 省份名称
     * @throws AMapException 如果名称错误，不存在该省份，会返回无效的参数异常
     * @since V2.5.1
     */
    updateOfflineMapProvinceByName(name: string): void;
    /**
     * 检查网络状态
     *
     * @throws AMapException
     */
    private d10;
    /**
     * 重新开始任务,开始下载队列中的第一个为等待中的任务
     *
     * @since V2.0.1
     */
    restart(): void;
    /**
     * 停止离线地图下载。<br>
     * 暂停所有下载城市或省份，包括队列中的。
     *
     * @since V2.0.1
     */
    stop(): void;
    /**
     * 暂停离线地图下载。<br>
     * 暂停正在下载城市或省份，不包括队列中。<br>
     * 每次开启下载任务，都会存放在队列中，且只能同时下载一个城市或省份的离线数据
     *
     * @since V2.0.1
     */
    pause(): void;
    pauseByName(name: string): void;
    /**
     * 设置离线地图城市列表初始化回调。
     * @param listener 监听
     * @since V4.1.3
     */
    setOnOfflineLoadedListener(listener: OfflineLoadedListener): void;
    /**
     * 销毁offlineManager中的资源
     *
     * @author zxy94400
     * @since 2.5.1
     */
    destroy(): void;
    /**
     * 注册下载监听
     *
     * @param listener
     */
    private y9;
    /**
     * 如果没有取消监听的话，有可能出现内存泄露
     */
    private k10;
}
/**
 *  离线地图下载过程中状态回调
 * @since V2.0.1
 */
interface OfflineMapDownloadListener {
    /**
     * 下载状态回调，在调用downloadByCityName 等下载方法的时候会启动
     *
     * @param status       参照{@link OfflineMapStatus}
     * @param completeCode 下载进度，下载完成之后为解压进度
     * @param name         当前所下载的城市的名字
     * @since V2.0.1
     */
    onDownload: (status: number, completeCode: number, name: string) => void;
    /**
     * 当调用updateOfflineMapCity 等检查更新函数的时候会被调用
     *
     * @param hasNew true表示有更新，说明官方有新版或者本地未下载
     * @param name   被检测更新的城市的名字
     * @since V2.0.1
     */
    onCheckUpdate: (hasNew: boolean, name: string) => void;
    /**
     * 当调用{@link OfflineMapManager#remove(String)}方法时，如果有设置监听，会回调此方法<br>
     * 当删除省份时，该方法会被调用多次，返回省份内城市删除情况。
     *
     * @param success  ture：删除成功
     * @param name     所删除的城市的名字
     * @param describe 删除描述，如 删除成功 "本地无数据"
     * @since V2.0.1
     */
    onRemove: (success: boolean, name: string, describe: string) => void;
}
/**
 *  离线地图初始化完成回调
 * @since V4.1.3
 */
interface OfflineLoadedListener {
    /**
     * 当调用{@link OfflineMapManager}初始化方法时，如果有设置监听，离线地图列表初始化完成会回调此方法<br>
     * @since V4.1.3
     */
    onVerifyComplete: () => void;
}
export {};
