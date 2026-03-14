// @keepTs
// @ts-nocheck
import ArrayList from "@ohos.util.ArrayList";
import { LatLng } from "../../api/model/LatLng";
export declare class q282 {
    /**
     * 返回结果的鉴权错误码
     */
    static readonly t284 = "errcode";
    /**
     * 返回结果的鉴权信息
     */
    static readonly u284 = "errmsg";
    static readonly v284 = "status";
    static readonly w284 = "infocode";
    static readonly x284 = "1";
    static readonly y284 = "0";
    static w283(str: string, url: string): void;
    protected static z284(m284: number, n284: string, url: string): void;
    static a285(j284: ArrayList<LatLng>): number;
}
