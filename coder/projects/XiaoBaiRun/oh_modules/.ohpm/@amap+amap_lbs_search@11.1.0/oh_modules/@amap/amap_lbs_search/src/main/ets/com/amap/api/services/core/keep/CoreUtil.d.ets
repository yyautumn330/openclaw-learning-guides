// @keepTs
// @ts-nocheck
import { LatLonPoint } from '../LatLonPoint';
import ArrayList from "@ohos.util.ArrayList";
import HashMap from "@ohos.util.HashMap";
export declare class o {
    static s11(d: number): number;
    static t11(o11: string): Date;
    static x7(point: LatLonPoint | undefined): string;
    static u11(list: ArrayList<LatLonPoint> | undefined): string;
    static v11(list: ArrayList<LatLonPoint> | undefined, j11: string): string;
    static i4(s: string | undefined): boolean;
    static p6(e: Error, h11: string, i11: string): void;
    static w11(g11: number): number;
    /**
     * 返回结果的鉴权错误码
     */
    static readonly x11 = "errcode";
    /**
     * 返回结果的鉴权信息
     */
    static readonly y11 = "errmsg";
    /**
     * 云图返回结果的鉴权错误码
     */
    static readonly z11 = "code";
    /**
     * 云图返回结果的鉴权信息
     */
    static readonly a12 = "message";
    /**
     * 云图鉴权成功的错误码
     */
    static readonly b12 = 0;
    /**
     * 鉴权失败的status
     */
    static readonly c12 = 0;
    /**
     * 鉴权字段status
     */
    static readonly d12 = "status";
    /**
     * 鉴权字段infocode
     */
    static readonly e12 = "infocode";
    static q6(str: string): void;
    private static f12;
    static h8(y10: number): string;
    static o2(time: Date): string;
    /** 弧度 PI/180 **/
    private static readonly R;
    private static readonly i12;
    private static readonly j12;
    private static readonly k12;
    /**
     * 根据用户的起点和终点经纬度计算两点间距离，单位米。
     *
     * @param startLatlng 起点的坐标。
     * @param endLatlng   终点的坐标。
     * @return 返回两点间的距离，单位米。
     * @since V2.0.2
     */
    static l12(l10: LatLonPoint, m10: LatLonPoint | undefined): number;
    static n12(i10: HashMap<string, string> | undefined, j10: HashMap<string, string> | undefined): boolean;
}
