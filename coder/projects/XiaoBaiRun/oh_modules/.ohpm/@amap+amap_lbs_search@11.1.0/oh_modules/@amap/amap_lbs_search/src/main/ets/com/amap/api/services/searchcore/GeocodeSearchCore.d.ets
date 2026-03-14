// @keepTs
// @ts-nocheck
import { GeocodeAddress } from "../geocoder/GeocodeAddress";
import { GeocodeQuery } from "../geocoder/GeocodeQuery";
import { OnGeocodeSearchListener } from "../geocoder/OnGeocodeSearchListener";
import { q58 } from "../interfaces/IGeocodeSearch";
import ArrayList from "@ohos.util.ArrayList";
import { ReGeocodeQuery } from "../geocoder/ReGeocodeQuery";
import { ReGeocodeAddress } from "../geocoder/ReGeocodeAddress";
/**
 * 地理编码与逆地理编码类。
 *
 * 地理编码又称地址匹配，指的是从已知的地址描述到对应的经纬 度坐标的转换，即根据地址信息，获取地址所对应的点坐标等。
 *
 * 逆地理编码即地址解析服务，具体是指从已知的经纬度坐标到对 应的地址描述（如省市、街区、楼层、房间等）的转换。
 *
 * 通过该类提供的方法可获取对应位置的地理描述，分为3种地物 类型：交叉路口、兴趣点、道路。
 *
 * @since V2.1.0
 *
 */
export declare class r58 implements q58 {
    private context;
    private y89;
    private l91;
    constructor(context: Context);
    /**
     * 根据给定的经纬度和最大结果数返回逆地理编码的结果列表。逆地理编码兴趣点返回结果最大返回数目为10，道路和交叉路口返回最大数目为3。
     * @param reGeoCodeQuery 要进行逆地理编码查询的条件。
     * @return 逆地理编码的结果列表。
     * @throws AMapException
     * @since V2.1.0
     */
    getFromLocation(j91: ReGeocodeQuery): Promise<ReGeocodeAddress | undefined>;
    /**
     * 根据给定的地理名称和查询城市，返回地理编码的结果列表。地理编码返回结果集默认最大返回数目为10。
     * @param geocodeQuery 地理编码的查询条件。
     * @return 地理编码的结果列表。
     * @throws AMapException
     * @since V2.1.0
     */
    getFromLocationName(i91: GeocodeQuery): Promise<ArrayList<GeocodeAddress> | undefined>;
    /**
     * 地理编码查询结果监听接口设置。
     * @param onGeocodeSearchListener 地理编码查询结果监听接口。
     * @since V2.1.0
     */
    setOnGeocodeSearchListener(h91: OnGeocodeSearchListener): void;
    /**
     * 异步处理。根据给定的经纬度和最大结果数返回逆地理编码的结果列表。逆地理编码兴趣点返回结果最大返回数目为10，道路和交叉路口返回最大数目为3。
     * @param reGeoCodeQuery 要进行逆地理编码查询的条件。
     * @throws AMapException
     * @since V2.1.0
     */
    getFromLocationAsyn(f91: ReGeocodeQuery): void;
    /**
     * 异步处理。根据给定的地理名称和查询城市返回地理编码的结果列表。地理编码返回结果集默认最大返回数目为10。
     * @param geocodeQuery 地理编码的查询条件。
     * @throws AMapException
     * @since V2.1.0
     */
    getFromLocationNameAsyn(d91: GeocodeQuery): void;
    private h4;
}
