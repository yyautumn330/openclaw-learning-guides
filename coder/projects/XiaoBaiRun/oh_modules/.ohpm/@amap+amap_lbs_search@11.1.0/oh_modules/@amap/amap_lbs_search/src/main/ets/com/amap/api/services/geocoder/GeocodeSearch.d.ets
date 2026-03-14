// @keepTs
// @ts-nocheck
import { GeocodeAddress } from "./GeocodeAddress";
import { GeocodeQuery } from "./GeocodeQuery";
import ArrayList from "@ohos.util.ArrayList";
import { OnGeocodeSearchListener } from "./OnGeocodeSearchListener";
import { ReGeocodeQuery } from "./ReGeocodeQuery";
import { ReGeocodeAddress } from "./ReGeocodeAddress";
/**
 * 地理编码与逆地理编码类。
 *
 * 地理编码又称地址匹配，指的是从已知的地址描述到对应的经纬 度坐标的转换，即根据地址信息，获取地址所对应的点坐标等。
 *
 * 逆地理编码即地址解析服务，具体是指从已知的经纬度坐标到对 应的地址描述（如省市、街区、楼层、房间等）的转换。
 *
 * 通过该类提供的方法可获取对应位置的地理描述，分为3种地物 类型：交叉路口、兴趣点、道路。
 *
 * @since V1.0.0
 *
 */
export declare class GeocodeSearch {
    /**
     * 输入参数坐标为GPS类型。
     * @since V1.0.0
     */
    static readonly GPS = "gps";
    /**
     * 输入参数坐标为高德类型。
     * @since V1.0.0
     */
    static readonly AMAP = "autonavi";
    /**
     * 扩展字段all，会返回完整参数
     * @since 1.0.0
     */
    static readonly EXTENSIONS_ALL = "all";
    /**
     * 扩展字段base，会返回部分参数
     * @since 1.0.0
     */
    static readonly EXTENSIONS_BASE = "base";
    private search?;
    /**
     * 根据给定的参数来构造一个GeocodeSearch 新对象。
     * @param context 一个Context，Context 指的是一个全局变量，程序的运行环境。
     * @since V1.0.0
     */
    constructor(context: Context);
    /**
     * 根据给定的经纬度和最大结果数返回逆地理编码的结果列表。逆地理编码兴趣点返回结果最大返回数目为10，道路和交叉路口返回最大数目为3。
     * @param reGeocodeQuery 要进行逆地理编码查询的条件。
     * @return 逆地理编码的结果列表。
     * @throws AMapException
     * @since V1.0.0
     */
    getFromLocation(w58: ReGeocodeQuery): Promise<ReGeocodeAddress | undefined> | undefined;
    /**
     * 根据给定的地理名称和查询城市，返回地理编码的结果列表。地理编码返回结果集默认最大返回数目为10。
     * @param geocodeQuery 地理编码的查询条件。
     * @return 地理编码的结果列表。
     * @throws AMapException
     * @since V1.0.0
     */
    getFromLocationName(v58: GeocodeQuery): Promise<ArrayList<GeocodeAddress> | undefined> | undefined;
    /**
     * 地理编码查询结果监听接口设置。
     * @param onGeocodeSearchListener 地理编码查询结果监听接口。
     * @since V1.0.0
     */
    setOnGeocodeSearchListener(u58: OnGeocodeSearchListener): void;
    /**
     * 逆地理编码查询的异步处理调用。
     * 根据给定的经纬度和最大结果数返回逆地理编码的结果列表。逆地理编码兴趣点返回结果最大返回数目为10，道路和交叉路口返回最大数目为3。
     * @param reGeocodeQuery 要进行逆地理编码查询的条件。
     * @throws AMapException
     * @since V1.0.0
     */
    getFromLocationAsyn(t58: ReGeocodeQuery): void;
    /**
     * 地理编码查询的异步处理调用。
     * 根据给定的地理名称和查询城市返回地理编码的结果列表。地理编码返回结果集默认最大返回数目为10。
     * @param geocodeQuery 地理编码的查询条件。
     * @throws AMapException
     * @since V1.0.0
     */
    getFromLocationNameAsyn(s58: GeocodeQuery): void;
}
