// @keepTs
// @ts-nocheck
import { LocalWeatherForecast } from "../../weather/LocalWeatherForecast";
import { LocalWeatherLive } from "../../weather/LocalWeatherLive";
import { DriveRouteResult } from "../../route/DriveRouteResult";
import { LatLonPoint } from '../LatLonPoint';
import { DriveStep } from "../../route/DriveStep";
import { RouteSearchCity } from "../../route/RouteSearchCity";
import { Path } from "../../route/Path";
import ArrayList from "@ohos.util.ArrayList";
import { DriveRouteResultV2 } from '../../route/DriveRouteResultV2';
import { DriveRoutePlanResult } from "../../route/DriveRoutePlanResult";
import { GeocodeAddress } from "../../geocoder/GeocodeAddress";
import { ReGeocodeAddress } from "../../geocoder/ReGeocodeAddress";
import { BusinessArea } from "../../geocoder/BusinessArea";
import { RideRouteResult } from "../../route/RideRouteResult";
import { RideStep } from "../../route/RideStep";
import { WalkRouteResult } from "../../route/WalkRouteResult";
import { WalkStep } from "../../route/WalkStep";
import { PoiItem } from "../PoiItem";
import { SuggestionCity } from "../SuggestionCity";
import { WalkRouteResultV2 } from "../../route/WalkRouteResultV2";
import { RideRouteResultV2 } from "../../route/RideRouteResultV2";
import { PoiItemV2 } from "../PoiItemV2";
import { SubPoiItemV2 } from "../../poisearch/SubPoiItemV2";
import { Tip } from "../../help/Tip";
import { RoutePOIItem } from "../../routepoisearch/RoutePOIItem";
import { BusRouteResult } from "../../route/BusRouteResult";
import { BusPath } from "../../route/BusPath";
import { BusStep } from "../../route/BusStep";
import { RouteBusWalkItem } from "../../route/RouteBusWalkItem";
import { RouteBusLineItem } from "../../route/RouteBusLineItem";
import { BusStationItem } from "../../busline/BusStationItem";
import { Doorway } from "../../route/Doorway";
import { DistrictItem } from "../../district/DistrictItem";
import { DistanceResult } from "../../route/DistanceResult";
import { TruckRouteRestult } from "../../route/TruckRouteRestult";
import { TruckStep } from "../../route/TruckStep";
import { BusRouteResultV2 } from "../../route/BusRouteResultV2";
import { BusPathV2 } from "../../route/BusPathV2";
import { BusStepV2 } from "../../route/BusStepV2";
import { BusLineItem } from "../../busline/BusLineItem";
export declare class r7 {
    /**
     * 返回结果都会放在data下~
     */
    static readonly l32: string;
    /**
     * 返回结果放在route下~
     */
    static readonly n32: string;
    /**
     * 返回结果的路线信息
     */
    static readonly o32: string;
    /**
     * 返回结果的起始点
     */
    static readonly p32: string;
    /**
     * 返回结果的目的点
     */
    static readonly q32: string;
    static r32(y31: string): WalkRouteResultV2;
    /**
     * 根据step生成path中点信息
     */
    private static b33;
    static c33(step: object): WalkStep;
    static d33(q31: object): RouteBusWalkItem;
    /**
     * 解析公交路线规划结果
     *
     * @param jsonStr
     * @return
     * @throws AMapException
     */
    static i8(k31: string): BusRouteResultV2;
    /**
     *
     * @param transits
     * @return
     * @throws JSONException
     */
    static g33(a31: object[]): ArrayList<BusPathV2>;
    static k33(step: object): BusStepV2;
    /**
     * 解析出租车信息
     * @param jsonOBJ
     * @return
     */
    private static w33;
    static q33(p30: object): ArrayList<RouteBusLineItem>;
    static z33(d30: object): RouteBusLineItem;
    static o33(x29: object): RouteBusWalkItem;
    static g34(step: object): WalkStep;
    static a34(c: object): BusStationItem;
    static e34(p29: object): ArrayList<BusStationItem>;
    static h34(f29: object): RouteBusLineItem;
    static s33(d29: object): Doorway;
    /**
     * 解析火车站信息
     * @param c
     * @return
     */
    private static i34;
    /**
     * 解析途径站点列表
     * @param jsonOBJ
     * @return
     * @throws JSONException
     */
    private static o34;
    /**
     * 解析火车备选方案
     * @param jsonOBJ
     * @return
     * @throws JSONException
     */
    private static p34;
    /**
     * 解析舱位及价格
     * @param c
     * @return
     * @throws JSONException
     */
    private static q34;
    /**
     * 解析舱位及价格信息列表
     * @param jsonOBJ
     * @return
     * @throws JSONException
     */
    private static r34;
    /**
     * 解析火车乘坐信息
     * @param jsonOBJ
     * @return
     * @throws JSONException
     */
    private static u33;
    static y34(z27: object): ArrayList<RouteBusLineItem>;
    /**
     * 解析出租车信息
     * @param jsonOBJ
     * @return
     */
    private static z34;
    static a35(step: object): BusStep;
    /**
     *
     * @param transits
     * @return
     * @throws JSONException
     */
    static b35(l27: object[]): ArrayList<BusPath>;
    /**
     * 解析公交路线规划结果
     *
     * @param jsonStr
     * @return
     * @throws AMapException
     */
    static z7(g27: string): BusRouteResult;
    static c35(w26: string): WalkRouteResult;
    static l13(e26: string): DriveRoutePlanResult | undefined;
    static t32(c26: object, key: string): LatLonPoint | undefined;
    static h35(a26: string): LatLonPoint | undefined;
    static i33(str: string): boolean;
    static x32(str: string): number;
    static a33(y25: object, key: string): ArrayList<LatLonPoint> | undefined;
    static i35(t25: string): ArrayList<LatLonPoint>;
    static j35(o25: RouteSearchCity, step: object): void;
    static m35(j25: DriveStep, step: object): void;
    private static o35;
    private static p35;
    static c14(k24: string): DriveRouteResultV2 | undefined;
    static u13(b24: string): DriveRouteResult | undefined;
    static isNull(str: string): boolean;
    static y7(str: string | undefined): boolean;
    static w32(obj: object, key: string): string;
    static e13(obj: object, key: string): number;
    static b36(v23: string): LocalWeatherLive | undefined;
    static h36(n23: string): LocalWeatherForecast | undefined;
    static g13(i23: object[] | undefined, j23: ArrayList<DistrictItem>, districts: DistrictItem | undefined): void;
    /**
     * 解析行政区划
     * @param disJSONObject
     * @returns
     */
    static i36(c23: object): DistrictItem;
    private static r35;
    private static t35;
    private static v35;
    private static w35;
    static x35(p22: object[]): ArrayList<RouteSearchCity>;
    private static y35;
    private static z35;
    static z36(z21: string): RideRouteResult | undefined;
    private static a37;
    static b37(path: Path, s21: ArrayList<RideStep>): void;
    /**
     * 解析poi
     *
     * @param c
     * @return
     * @throws JSONException
     */
    static c37(t20: object): PoiItem;
    /**
     * 解析poi
     *
     * @param c
     * @return
     * @throws JSONException
     */
    static f37(c: object): PoiItemV2;
    private static h37;
    private static e37;
    private static d37;
    static g37(c: object): SubPoiItemV2;
    /**
     * 解析poi list
     *
     * @param jobj
     * @return
     * @throws JSONException
     */
    static i37(a19: object | undefined): ArrayList<PoiItem>;
    /**
     * 解析poi list
     *
     * @param jobj
     * @return
     * @throws JSONException
     */
    static j37(u18: object | undefined): ArrayList<PoiItemV2>;
    /**
     * 解析建议城市列表
     *
     * @param suggestionObj
     * @return
     * @throws JSONException
     * @throws NumberFormatException
     */
    static v8(p18: object): ArrayList<SuggestionCity>;
    /**
     * 解析tip list
     *
     * @param jObj
     * @return
     * @throws JSONException
     */
    static r14(i18: object): ArrayList<Tip>;
    static i14(jsonObject: object): ArrayList<GeocodeAddress>;
    static o37(x17: object, address: ReGeocodeAddress): void;
    static r37(u17: object): ArrayList<BusinessArea>;
    private static t37;
    private static v37;
    private static u37;
    static v32(str: string): number;
    static w37(o17: object[], address: ReGeocodeAddress): void;
    static z37(j17: object[], address: ReGeocodeAddress): void;
    static b38(f17: object[], address: ReGeocodeAddress): void;
    static e38(y16: string): RideRouteResultV2;
    private static f38;
    static g38(m16: object): ArrayList<RoutePOIItem>;
    static h38(c: object): RoutePOIItem;
    static u12(g16: string): DistanceResult | undefined;
    static i38(y15: string): TruckRouteRestult | undefined;
    static j38(t15: TruckStep, step: object): void;
    private static k38;
    /**
     * 解析公交线路基础数据
     *
     * @param c
     * @return
     * @throws JSONException
     */
    static l38(c: object): BusLineItem;
    /**
     * 解析建议关键字列表
     *
     * @param suggestionObj
     * @return
     * @throws JSONException
     */
    static w8(k15: object): ArrayList<string>;
    /**
     * 解析公交线路列表
     *
     * @param jObj
     * @return
     * @throws JSONException
     */
    static x8(h15: object): ArrayList<BusLineItem>;
    /**
     * 解析公交站点基础数据
     *
     * @param c
     * @return
     * @throws JSONException
     */
    static n38(c: object): BusStationItem;
    /**
     * 解析公交线路详情
     *
     * @param c
     * @return
     * @throws JSONException
     */
    static m38(c: object): BusLineItem;
    /**
     * 解析公交站点详情
     *
     * @param c
     * @return
     * @throws JSONException
     */
    static o38(c: object): BusStationItem;
    /**
     * 解析公交站点列表
     *
     * @param jObj
     * @return
     * @throws JSONException
     */
    static y8(u14: object): ArrayList<BusStationItem>;
}
