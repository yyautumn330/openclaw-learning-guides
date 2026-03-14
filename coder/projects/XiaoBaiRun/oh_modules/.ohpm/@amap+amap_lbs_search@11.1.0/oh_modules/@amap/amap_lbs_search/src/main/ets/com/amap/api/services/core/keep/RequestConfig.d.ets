// @keepTs
// @ts-nocheck
import ArrayList from "@ohos.util.ArrayList";
import { LatLonPoint } from "../LatLonPoint";
import { FromAndTo } from "../../route/FromAndTo";
export declare class c50 {
    private static instance;
    private v50;
    private w50;
    private x50;
    private y50;
    private z50;
    a51: boolean;
    b51: boolean;
    c51: boolean;
    d51: number;
    e51: number;
    f51: number;
    g51(u50: boolean): void;
    h51(t50: number): void;
    static getInstance(): c50;
    i51(s50: boolean): void;
    j51(r50: number): void;
    k51(q50: boolean): void;
    /**
     * 检查关键是的长度
     * @param queryString
     * @throws AMapException
     */
    l51(p50: string | undefined): void;
    /**
     * 步行最大距离限制，超出时返回距离过长错误码
     */
    m51(o50: FromAndTo): void;
    /**
     * poi 分页最大页码，错误时纠正为合适参数
     */
    n51(n50: number): number;
    /**
     * poi 每页最大数量，错误时纠正为合适参数
     */
    o51(m50: number): number;
    /**
     * 骑行最大距离限制，超出时返回距离过长错误码
     */
    p51(k50: FromAndTo): void;
    /**
     * 货车最大距离限制，超出时返回距离过长错误码
     */
    q51(f50: FromAndTo, g50: ArrayList<LatLonPoint>): void;
    /**
     *  客户端途经点参数限制 ，超出时返回参数错误
     *
     *  https://aone.alibaba-inc.com/v2/project/853500/req/43881285
     */
    r51(d50: ArrayList<LatLonPoint>): void;
}
