// @keepTs
// @ts-nocheck
import { LatLonPoint } from "../core/LatLonPoint";
/**
 * POI导航类
 * @since V1.0.0
 * */
export declare class PoiNavi {
    private h62;
    private q54;
    private r54;
    private i62;
    /**
     * 根据给定的参数来构造一个 PoiNavi 的对象。
     * @param naviPoiID poi对应的导航引导点ID。
     * @param enterPoint POI入口经纬度。
     * @param exitPoint POI出口经纬度。
     * @param gridCode poi的地理格id。
     * @since V1.0.0
     */
    constructor(d62: string | undefined, e62: LatLonPoint | undefined, f62: LatLonPoint | undefined, g62: string | undefined);
    /**
     * 获取POI导航的ID。
     * @return POI导航的ID。
     */
    getNaviPoiID(): string | undefined;
    /**
     * 设置POI导航的ID。
     * @param naviPoiID POI导航的ID。
     * @since V1.0.0
     */
    setNaviPoiID(c62: string | undefined): void;
    /**
     * 返回POI入口经纬度。<br>
     * POI入口一般指商场、停车场等的POI兴趣点入口。<br>
     * 导航时，如果目的地为该POI且POI存在入口，建议使用入口经纬度作为导航终点。
     * @return POI入口经纬度。
     * @since V1.0.0
     */
    getEnter(): LatLonPoint | undefined;
    /**
     * 设置POI入口经纬度。
     * POI入口一般指商场、停车场等的POI兴趣点入口。
     * @param enterPoint POI入口经纬度。
     * @since V1.0.0
     */
    setEnter(b62: LatLonPoint | undefined): void;
    /**
     * 返回POI出口经纬度。<br>
     * POI出口一般指商场、停车场等POI兴趣点的出口。<br>
     * 导航时，如果出发点为该POI且POI存在出口，建议使用出口经纬度作为导航起点。
     * @return POI出口经纬度。 <br></>
     */
    getExit(): LatLonPoint | undefined;
    /**
     * 设置POI出口经纬度。
     * POI出口一般指商场、停车场等POI兴趣点的出口。
     * @param exitPoint POI出口经纬度。
     * @since V1.0.0
     */
    setExit(a62: LatLonPoint | undefined): void;
    /**
     * 返回POI的地理格ID。
     * @return POI的地理格ID。
     * @since V1.0.0
     */
    getGridCode(): string | undefined;
    /**
     * 设置POI的地理格ID。
     * @param gridCode POI的地理格ID。
     * @since V1.0.0
     */
    setGridCode(z61: string | undefined): void;
}
