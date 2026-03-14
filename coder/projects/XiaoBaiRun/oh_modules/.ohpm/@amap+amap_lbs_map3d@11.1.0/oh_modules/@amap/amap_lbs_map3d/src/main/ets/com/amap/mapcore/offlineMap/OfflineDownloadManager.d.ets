// @keepTs
// @ts-nocheck
import { e9 } from "./CityObject";
import { g9 } from "./OfflineMapDownloadList";
import { OfflineMapProvince } from "../../api/maps/offlinemap/OfflineMapProvince";
import { a25 } from "./UpdateItem";
import ArrayList from "@ohos.util.ArrayList";
import { Context as Context } from "@ohos.abilityAccessCtrl";
import { b201 } from "./OfflineMapDataVerify";
import { c201 } from "./OfflineMapRemoveTask";
export declare class f9 {
    private context;
    x192: boolean;
    static c185: string;
    /**
     * 处理调用destroy方法之后，如果这个时候有正在下载中的城市，会调用stopAllTask方法
     * 但是stop的回调是在子线程中，状态回调回来的时候destroy已经执行完毕，
     * 但是回到中有调用getInstance，所有会再次创建OfflineDownloadManager
     * 为了避免这种情况，特地加上这个判断标识，这个值会在OfflineMapManager中设置为false，在destroy中设置为true
     */
    static x9: boolean;
    private l202;
    private static instance?;
    /** 以下表示本地已有的城市或省份离线数据 */
    m202: OfflineMapProvince[];
    private listener?;
    /**
     * 下载管理
     */
    private n202?;
    /**
     * 离线地图版本
     */
    static y192: string;
    /**
     * 数据库操作
     */
    private b195?;
    /**
     * 检查更新线程管理
     */
    private o202?;
    /**
     * 删除城市线程管理
     */
    private p202?;
    private q202?;
    /**
     * 下载 更新 删除回调的handler
     */
    private r202?;
    u9?: g9;
    /**
     * 删除城市
     */
    s202?: c201;
    /**
     * 数据完整性校验
     */
    t202?: b201;
    constructor(context: Context);
    static getInstance(context: Context): f9 | undefined;
    w9(): void;
    /**
     * 读取本地的以准备好好的离线地图数据信息<br>
     * 1.如果SD卡中有更新的offlinemap3.png那就读取SD卡中这个<br>
     * 2.assets目录下有一个offlinemap3.png文件，里面就是离线数据<br>
     * 3.如果是拆分包会从SD卡中的AMapResource.jar中读取。<br>
     */
    private x202;
    /**
     * 本地文件中读取出来的是json文件, 此时城市下载状态都是默认的未下载, 把城市添加到缓存列表
     *
     * @param json
     * @throws JSONException
     */
    private y202;
    /**
     * 从数据库中查找对应的城市状态
     */
    private v202;
    /**
     * 如果发现数据库中有adcode为000001将其修改为100000
     */
    private u202;
    /**
     * 注册下载监听
     *
     * @param listener
     */
    y9(listener: OfflineMapDownloadListener): void;
    /**
     * 如果没有取消监听的话，有可能出现内存泄露
     */
    k10(): void;
    /**
     * 回调给UI，这个方法会在CityObject中调用
     *
     * @param cityObject 调用者
     */
    e184(c202: e9): void;
    /**
     * 由cityObject回调  当一个任务结束的时候，包括，暂停，删除，完成和Error
     *
     * @param cityObject 调用者
     */
    f184(b202: e9): void;
    j184(z201: e9, a202: boolean): void;
    q184(y201: e9): void;
    /**
     * TODO: 2015/12/19 需要把解压模块单独出来
     *
     * @param cityObject
     */
    r184(x201: e9): void;
    /**
     * 供外部调用  开始下载暂停下载 都只是一个操作
     *
     * @param cityCode 城市编码
     */
    c10(cityCode: string): void;
    /**
     * 供外部调用  开始下载暂停下载 都只是一个操作
     *
     * @param cityName
     */
    startDownload(object: string | e9): void;
    private f203;
    private a203;
    /**
     * 删除城市操作
     * todo 这里应该调用状态机的delete方法，以满足其他的结构
     *
     * @param cityName 城市名称
     */
    remove(cityName: string): void;
    /**
     * 针对省份做处理，判断一个名字是不是城市，不是城市有可能就是省份。
     *
     * @param cityName 城市名称
     * @return true 是一个城市
     */
    e10(cityName: string): boolean;
    /**
     * 绘制完整性检查中调用
     *
     * @param changedItems，发现变动的城市
     */
    g203(p201: ArrayList<a25> | undefined): void;
    private h203;
    /**
     * 检查更新的时候会调用
     *
     * @param cityName
     */
    g10(cityName: string): void;
    destroy(): void;
    i107(): void;
    /**
     * 供外部调用
     *
     * @param object
     */
    j10(object?: string | e9): void;
    /**
     * 供外部调用，暂停所有正在下载和等待中的
     */
    i10(): void;
    /**
     * 检查网络状态
     *
     * @throws AMapException
     */
    d10(): void;
    /**
     * 更新本地保存的含有离线城市信息 再更新里面的数据 mAllProvinceList,mAllCityQueue
     *
     * @throws AMapException
     */
    z192(): void;
    private b203;
    /**
     * 通过名称获取城市adcode，在新的校验方法中调用，原本地信息文件用adcode命名。
     *
     * @param cityName
     * @return
     */
    j203(cityName: string): string;
    static w202(dir: string): void;
}
export interface OfflineMapDownloadListener {
    /**
     * 下载状态回调，在调用downloadByCityName 等下载方法的时候会启动
     *
     * @param city         当前所下载的城市的名字
     * @since V2.0.1
     */
    onDownload: (city: e9) => void;
    /**
     * 当调用updateOfflineMapCity 等检查更新函数的时候会被调用
     *
     * @param city   被检测更新的城市的名字
     * @since V2.0.1
     */
    onCheckUpdate: (city: e9 | undefined) => void;
    /**
     * 当调用remove(String)方法时，如果有设置监听，会回调此方法<br>
     * 当删除省份时，该方法会被调用多次，返回省份内城市删除情况。
     *
     * @param city     所删除的城市的名字
     * @since V2.0.1
     */
    onRemove: (city: e9 | undefined) => void;
    /**
     * 本地校验结束回调
     */
    onVerifyComplete: () => void;
}
