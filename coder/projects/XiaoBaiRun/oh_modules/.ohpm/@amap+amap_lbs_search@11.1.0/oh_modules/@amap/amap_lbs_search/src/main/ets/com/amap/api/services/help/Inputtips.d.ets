// @keepTs
// @ts-nocheck
import ArrayList from "@ohos.util.ArrayList";
import { InputtipsQuery } from "./InputtipsQuery";
import { Tip } from "./Tip";
/**
 * 输入提示类，前提需要联网。
 * @since V1.0.0
 */
export declare class Inputtips {
    private static x59;
    private search;
    /**
     * 根据给定的参数构造一个Inputtips的新对象。
     * @param context 当前 Activity。
     * @param listener 输入提示回调的监听接口
     * @deprecated
     * @since V1.0.0
     */
    constructor(context: Context, listener: InputtipsListener, query: InputtipsQuery);
    /**
     * 返回提示查询条件。
     * @return 提示查询条件。
     * @since V1.0.0
     */
    getQuery(): InputtipsQuery | undefined;
    /**
     * 设置提示查询条件。
     * @param query 提示查询条件。
     * @since V1.0.0
     */
    setQuery(query: InputtipsQuery): void;
    /**
     * 设置提示查询监听。
     * @param listener 提示类查询监听。
     * @since V1.0.0
     */
    setInputtipsListener(listener: InputtipsListener): void;
    /**
     * 查询输入提示的异步接口。
     * @since V1.0.0
     */
    requestInputtipsAsyn(): void;
    /**
     * 查询输入提示的同步接口。
     * @since V1.0.0
     *     在网络连接出现问题的情况下，会抛出{@link AMapException#AMAP_CLIENT_NETWORK_EXCEPTION}。<br>
     *     在Query参数不正确的时候会抛出 {@link AMapException#AMAP_CLIENT_INVALID_PARAMETER}
     */
    requestInputtipsForPromise(): Promise<ArrayList<Tip> | undefined>;
    /**
     * 发送输入提示请求，限定搜索类型。
     * @param keyword 输入的关键字。
     * @param city 查询的城市编码citycode、城市名称（中文或中文全拼）、行政区划代码adcode。设置undefined或“”为全国。
     * @param type 搜索类型的组合，仅支持数字，对照下载页面获取的POI分类表输入。多种类型使用“|”分隔。
     * <p>举例：编码表 “050117 餐饮服务 ;中餐厅 ;火锅店”，输入“05”为餐饮服务、“0501”为中餐厅、“050117”为火锅店类别。/p>
     * @throws AMapException
     * @deprecated 请参考 {@link #requestInputtips()}
     * @since V1.0.0
     */
    requestInputtips(v59: string, city: string | undefined, type: string | undefined): void;
}
/**
 * 输入提示回调的监听接口。
 * @since V1.0.0
 */
export interface InputtipsListener {
    /**
     * 输入提示回调的方法。
     * @param inputTips 输入提示接口回调的提示列表。
     * @param resultID 返回结果成功或者失败的响应码。1000为成功(V3.2.1之后搜索成功响应码为1000，之前版本为0)，其他为失败（详细信息参见网站开发指南-错误码对照表）。
     * @since V1.0.0
     */
    onGetInputtips: (inputTips: ArrayList<Tip>, resultID: number) => void;
}
