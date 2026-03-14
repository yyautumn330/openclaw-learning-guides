// @keepTs
// @ts-nocheck
import { InputtipsListener } from "../help/Inputtips";
import { InputtipsQuery } from "../help/InputtipsQuery";
import ArrayList from "@ohos.util.ArrayList";
import { Tip } from "../help/Tip";
export interface t59 {
    /**
     * 返回提示查询条件。
     * @return 提示查询条件。
     */
    getQuery(): InputtipsQuery;
    /**
     * 设置提示查询条件。
     * @param query 提示查询条件。
     */
    setQuery(query: InputtipsQuery): void;
    /**
     * 设置提示查询监听。
     * @param listener 提示类查询监听。
     */
    setInputtipsListener(listener: InputtipsListener): void;
    /**
     * 查询输入提示的异步接口。
     */
    requestInputtipsAsyn(): void;
    /**
     * 查询输入提示的接口。
     */
    requestInputtipsForPromise(): Promise<ArrayList<Tip> | undefined>;
    /**
     * 发送输入提示请求，限定搜索类型。
     * @param keyword 输入的关键字。
     * @param city 查询的城市编码citycode、城市名称（中文或中文全拼）、行政区划代码adcode。设置null或“”为全国。
     * @param type 搜索类型的组合，仅支持数字，对照下载页面获取的POI分类表输入。多种类型使用“|”分隔。
     * <p>举例：编码表 “050117 餐饮服务 ;中餐厅 ;火锅店”，输入“05”为餐饮服务、“0501”为中餐厅、“050117”为火锅店类别。/p>
     * @deprecated
     */
    requestInputtips(keyword: string, city: string | undefined, type: string | undefined): void;
}
