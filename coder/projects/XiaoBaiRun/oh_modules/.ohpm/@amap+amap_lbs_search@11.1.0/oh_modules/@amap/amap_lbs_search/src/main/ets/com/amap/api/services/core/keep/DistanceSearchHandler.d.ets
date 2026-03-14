// @keepTs
// @ts-nocheck
import { DistanceResult } from "../../route/DistanceResult";
import { DistanceQuery } from "../../route/DistanceSearch";
import { b7 } from "./BasicLBSRestHandler";
/**
 * Created by zxy on 2018/3/5.
 * 距离测量请求实现
 * 【需求描述】目前部分用户会拿路径规划当测距接口使，频繁调用，造成流量消耗巨大。
 * 为解决此问题，可封装测距API为单独接口，供只有无路径规划但有测距需求的用户调用。
 * 测距API服务地址：http://restsdk.amap.com/v3/distance?parameters
 * 相关文档地址：http://lbs.amap.com/api/webservice/guide/api/direction#distance
 */
export declare class o12 extends b7<DistanceQuery, DistanceResult> {
    private static r12;
    private static s12;
    private static t12;
    constructor(context: Context, task: DistanceQuery);
    protected m6(): string;
    protected n6(p12: string): DistanceResult | undefined;
    k6(): string;
}
