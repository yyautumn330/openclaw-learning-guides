// @keepTs
// @ts-nocheck
/**
 * 室内地图相关数据
 */
export declare class IndoorDataV2 {
    private z54;
    private l61;
    private m61;
    private n61;
    /**
     * 根据给定的参数构造一个IndoorData 的新对象。
     * @param hasIndoorMap  是否支持室内地图，支持室内地图为true，否则为false。。
     * @param poiId  该POI所在POI的ID标识。如果当前POI为建筑物类POI，则cpid为自身POI ID；如果当前POI为商铺类POI，则cpid为其所在建筑物的POI ID。
     * @param floor 该POI的所在楼层信息，int类型，如。
     */
    constructor(q61: boolean, r61: string, floor: number | undefined, s61: string | undefined);
    /**
     * 设置是否支持室内地图
     * @param isIndoorMap 支持室内地图为true，否则为false。
     */
    setIndoorMap(p61: boolean): void;
    /**
     * 返回是否支持室内地图 。
     * @return 支持室内地图返回 true，否则返回 false。
     */
    isIndoorMap(): boolean;
    /**
     * 返回该POI所在建筑物POI的id。如果当前POI为建筑物类POI，则cpid为自身POI ID；如果当前POI为商铺类POI，则cpid为其所在建筑物的POI ID。。
     * @return 所在建筑物POI的id。
     */
    getPoiId(): string | undefined;
    /**
     * 设置该POI所在建筑物POI的id。
     * @param poiId 所在建筑物POI的id。
     */
    setPoiId(o61: string | undefined): void;
    /**
     * 返回该POI在建筑物内的楼层。
     * @return 该POI在建筑物内的楼层。
     */
    getFloor(): number | undefined;
    /**
     * 设置该POI在建筑物内的楼层。
     * @param floor 该POI在建筑物内的楼层。
     */
    setFloor(floor: number | undefined): void;
    /**
     * 返回该POI在建筑物内的楼层显示名称。
     * @return 该POI在建筑物内的楼层名称。
     */
    getFloorName(): string | undefined;
    /**
     * 设置该POI在建筑物内的楼层显示名称。如地下一层，返回“B1”。
     * @param floorName 该POI在建筑物内的楼层名称。
     */
    setFloorName(floorName: string | undefined): void;
}
