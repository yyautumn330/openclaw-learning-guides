// @keepTs
// @ts-nocheck
import { Context } from '@ohos.abilityAccessCtrl';
import { LatLng } from '../../api/model/LatLng';
export declare class o103 {
    /**
     * 上传Marker收集的信息开关，默认为false
     */
    private static w245;
    /**
     * 最大存放信息条数
     */
    private static readonly x245;
    /**
     * 如果超过一定数量的Marker的不再继续上传了
     */
    private static readonly y245;
    private static readonly z245;
    private static readonly a246;
    private static readonly b246;
    private static readonly c246;
    private static readonly d246;
    private static readonly e246;
    private f246;
    private mContext;
    private constructor();
    private static instance?;
    static getInstance(): o103;
    static destroy(): void;
    /**
     * 上传Marker收集的信息开关，默认为false
     * @param status
     */
    static u105(status: boolean): void;
    static isEnable(): boolean;
    /**
     * 根据Marker总数量决定是否需要上传marker信息
     * @param markerListSize 地图上marker的总数
     */
    static h246(v245: number): void;
    /**
     * 设置写入文件需要的Context
     * @param context
     */
    w94(context: Context): void;
    /**
     * 添加消息，最终格式如下
     * {
     * "lon": 114,
     * "lat": 39,
     * "title": "肯德基XX店",
     * "snippet": "肯德基XX店，联系电话XXXXXXX"
     * }
     * @param latLng 为空视为无效
     * @param title 为空视为无效
     * @param snippet
     */
    f162(latLng: LatLng, title: string, snippet: string): void;
    /**
     * 添加需要缓存的信息
     * @param message
     */
    private i246;
    /**
     * 写入本地
     */
    private g246;
    /**
     * 判断缓存是否达到一定数量后，便会写入本地
     * @return
     */
    private j246;
}
