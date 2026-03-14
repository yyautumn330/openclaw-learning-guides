// @keepTs
// @ts-nocheck
import ArrayList from "@ohos.util.ArrayList";
import { e9 } from "./CityObject";
import { OfflineMapCity } from "../../api/maps/offlinemap/OfflineMapCity";
import { OfflineMapProvince } from "../../api/maps/offlinemap/OfflineMapProvince";
/**
 * 下载队列 所有省份（包含城市）列表
 */
export declare class g9 {
    static readonly u206 = 13;
    static readonly v206 = "verify_list_name";
    static readonly w206 = "verify_list_status";
    static readonly x206 = "verify_list_complete";
    /** 以下表示本地已有的城市或省份离线数据 */
    m202: ArrayList<OfflineMapProvince>;
    private b195?;
    private context;
    constructor(context: Context);
    /**
     * 插入数据库，解压进度其实没啥用，可以优化，
     *
     * @param item
     */
    private y206;
    private z206;
    /**
     * 解压进度不用保存,解压不能断点解压
     *
     * @param complete
     * @param state
     * @return
     */
    private a207;
    private b207;
    /**
     * 根据省份名称获取OfflineMapProvince对象 会一次从已下载、下载中、本地以后的离线数据信息<br>
     * 同步方法
     *
     * @param provinceName 省份名称
     * @return 返回对应的OfflineMapProvince对象
     */
    getItemByProvinceName(provinceName: string): OfflineMapProvince | undefined;
    /**
     * 获取所有存在有离线地图的省的列表。<br>
     * 同步方法
     *
     * @return ArrayList<OfflineMapProvince>
     */
    getOfflineMapProvinceList(): ArrayList<OfflineMapProvince>;
    /**
     * 根据城市编码获取OfflneMapCity对象 会一次从已下载、下载中、本地以后的离线数据信息<br>
     * 同步方法
     *
     * @param cityCode 想查找城市编码
     * @return 返回对应的OfflneMapCity对象
     */
    getItemByCityCode(cityCode: string): OfflineMapCity | undefined;
    /**
     * 根据城市名称获取OfflneMapCity对象 会一次从已下载、下载中、本地以后的离线数据信息<br>
     * 同步方法
     *
     * @param cityName 想查找城市名称
     * @return 返回对应的OfflneMapCity对象
     */
    getItemByCityName(cityName: string): OfflineMapCity | undefined;
    /**
     * 获取所有存在有离线地图的城市列表。<br>
     *
     * @return ArrayList<OfflineMapCity>
     */
    getOfflineMapCityList(): ArrayList<OfflineMapCity>;
    /**
     * 所有正在下载或等待下载离线地图的城市列表。<br>
     *
     * @return ArrayList<OfflineMapCity>
     */
    getDownloadingCityList(): ArrayList<OfflineMapCity>;
    /**
     * 所有正在下载或等待下载离线地图的省份列表。<br>
     * 同步方法
     *
     * @return ArrayList<OfflineMapProvince>
     */
    getDownloadingProvinceList(): ArrayList<OfflineMapProvince>;
    /**
     * 返回已经下载完成离线地图的城市列表。<br>
     *
     * @return List<OfflineMapCity>
     */
    getDownloadOfflineMapCityList(): ArrayList<OfflineMapCity>;
    /**
     * 返回已经下载完成离线地图的省份列表。<br>
     *
     * @return ArrayList<OfflineMapProvince>
     */
    getDownloadOfflineMapProvinceList(): ArrayList<OfflineMapProvince>;
    /**
     * 下载，等待，暂停，解压均属于正在下载中
     * 异常和错误也属于
     *
     * @return
     */
    d207(state: number): boolean;
    /**
     * 更新所有城市信息 <br>
     * 1.初始化时直接add；<br>
     * 2.检查更新是更新下载url和version还有state <br>
     * <p>
     * 该方法会在初始化和检查更新的时候调用，检查更新时调用了说明有更新，将下载完成的城市状态修改为有更新
     *
     * @param cityList
     */
    z202(u205: ArrayList<OfflineMapProvince>): void;
    c203(q205: e9): void;
    private g207;
    /**删除旧版本的以adcode命名的离线地图信息文件*/
    private i207;
    /**
     * 城市下载完成时，城市被删除时，需要改变对应省份的状态 直辖市可以不坐修改。。
     *
     * @param item
     * @param mapProvince
     */
    private h207;
    private e207;
    private f207;
    /**
     * 当前省份，有没有下载完毕,如果内部的城市都下载完了，表示下载完毕
     *
     * @param mapProvince 省份
     * @return boolean 返回false 表示没有下载完成，否则表示下载完成
     */
    private l207;
    /**
     * 封装忽略大小写的字符串对比是否相同
     * @param a
     * @param b
     * @returns
     */
    private c207;
    destroy(): void;
    m207(): void;
}
