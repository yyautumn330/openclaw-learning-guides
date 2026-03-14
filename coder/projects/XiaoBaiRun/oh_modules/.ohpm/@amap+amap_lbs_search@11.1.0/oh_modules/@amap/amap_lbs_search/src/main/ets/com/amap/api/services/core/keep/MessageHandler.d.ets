// @keepTs
// @ts-nocheck
import { j39, k39 } from "../../util/SearchHandler";
import { LocalWeatherForecastResult } from "../../weather/LocalWeatherForecastResult";
import { LocalWeatherLiveResult } from "../../weather/LocalWeatherLiveResult";
import { OnWeatherSearchListener } from "../../weather/WeatherSearch";
import ArrayList from "@ohos.util.ArrayList";
import { OnPoiSearchListener } from "../../poisearch/PoiSearch";
import { OnGeocodeSearchListener } from "../../geocoder/OnGeocodeSearchListener";
import { ReGeocodeResult } from "../../geocoder/ReGeocodeResult";
import { GeocodeResult } from "../../geocoder/GeocodeResult";
import { PoiResult } from "../../poisearch/PoiResult";
import { PoiItem } from "../PoiItem";
import { PoiResultV2 } from "../../poisearch/PoiResultV2";
import { OnPoiSearchListenerV2 } from "../../poisearch/PoiSearchV2";
import { PoiItemV2 } from "../PoiItemV2";
import { Tip } from "../../help/Tip";
import { InputtipsListener } from "../../help/Inputtips";
import { RoutePOISearchResult } from "../../routepoisearch/RoutePOISearchResult";
import { OnRoutePOISearchListener } from "../../routepoisearch/RoutePOISearch";
import { DistanceResult } from "../../route/DistanceResult";
import { OnDistanceSearchListener } from "../../route/DistanceSearch";
import { BusStationResult } from "../../busline/BusStationResult";
import { OnBusStationSearchListener } from "../../interfaces/OnBusStationSearchListener";
import { BusLineResult } from "../../busline/BusLineResult";
import { OnBusLineSearchListener } from "../../interfaces/OnBusLineSearchListener";
export declare class MessageHandler extends j39 {
    static readonly SHARE_URL_KEY = "shareurlkey";
    static readonly o40 = 1;
    static readonly p40 = 2;
    static readonly q40 = 3;
    static readonly r40 = 4;
    static readonly s40 = 5;
    static readonly t40 = 6;
    static readonly u40 = 7;
    static readonly v40 = 8;
    static readonly w40 = 9;
    static readonly x40 = 10;
    static readonly y40 = 11;
    static readonly z40 = 12;
    static readonly a41 = 13;
    static readonly b41 = 14;
    static readonly c41 = 15;
    static readonly d41 = 16;
    static readonly e41 = 17;
    static readonly f41 = 18;
    static readonly g41 = 19;
    static readonly h41 = 20;
    static readonly i41 = 101;
    static readonly j41 = 100;
    static readonly k41 = 101;
    static readonly l41 = 102;
    static readonly n41 = 103;
    static readonly o41 = 104;
    static readonly p41 = 105;
    static readonly q41 = 200;
    static readonly r41 = 201;
    static readonly s41 = 300;
    static readonly t41 = 301;
    static readonly u41 = 302;
    static readonly v41 = 400;
    static readonly w41 = 600;
    static readonly x41 = 602;
    static readonly y41 = 603;
    static readonly z41 = 604;
    static readonly a42 = 700;
    static readonly b42 = 701;
    static readonly c42 = 1100;
    static readonly d42 = 1101;
    static readonly e42 = 1102;
    static readonly f42 = 1103;
    static readonly g42 = 1104;
    static readonly h42 = 1105;
    static readonly i42 = 1301;
    static readonly j42 = 1302;
    static readonly k42 = "result";
    private static l42;
    static getInstance(): MessageHandler;
    n42: (message: k39) => void;
    private x42;
    private w42;
    private b43;
    private r42;
    private p42;
    private s42;
    private q42;
    private t42;
    private v42;
    private u42;
    private y42;
    private z42;
    private a43;
    private c43;
}
export declare class l39 {
    j43: LocalWeatherLiveResult | undefined;
    i43: OnWeatherSearchListener | undefined;
}
export declare class m39 {
    k43: LocalWeatherForecastResult | undefined;
    i43: OnWeatherSearchListener | undefined;
}
export declare class n39 {
    s43: GeocodeResult | undefined;
    p43: OnGeocodeSearchListener | undefined;
}
export declare class o39 {
    r43: ReGeocodeResult | undefined;
    p43: OnGeocodeSearchListener | undefined;
}
export declare class p39 {
    n43: PoiResult | undefined;
    l43: OnPoiSearchListener | undefined;
}
export declare class q39 {
    o43: PoiItem | undefined;
    l43: OnPoiSearchListener | undefined;
}
export declare class r39 {
    n43: PoiResultV2 | undefined;
    l43: OnPoiSearchListenerV2 | undefined;
}
export declare class s39 {
    o43: PoiItemV2 | undefined;
    l43: OnPoiSearchListenerV2 | undefined;
}
export declare class t39 {
    tips: ArrayList<Tip>;
    t43: InputtipsListener | undefined;
}
export declare class u39 {
    v43: RoutePOISearchResult | undefined;
    u43: OnRoutePOISearchListener | undefined;
}
export declare class v39 {
    x43: DistanceResult | undefined;
    w43: OnDistanceSearchListener | undefined;
}
export declare class w39 {
    h43?: BusStationResult | undefined;
    g43?: OnBusStationSearchListener | undefined;
}
export declare class x39 {
    f43?: BusLineResult | undefined;
    d43?: OnBusLineSearchListener | undefined;
}
