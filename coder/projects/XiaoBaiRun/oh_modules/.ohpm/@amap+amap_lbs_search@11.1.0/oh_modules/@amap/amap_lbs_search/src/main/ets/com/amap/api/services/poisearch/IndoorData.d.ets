// @keepTs
// @ts-nocheck
/**
 * 室内地图相关数据
 */
export declare class IndoorData {
    l61: string;
    m61: number | undefined;
    n61: string | undefined;
    /**
     * 根据给定的参数构造一个IndoorData 的新对象。
     * @param poiId  该POI所在POI的ID标识。如果当前POI为建筑物类POI，则cpid为自身POI ID；如果当前POI为商铺类POI，则cpid为其所在建筑物的POI ID。
     * @param floor 该POI的所在楼层信息，int类型，如。
     * @param floorname 该POI的楼层名称，String类型，如B1、F1。
     */
    constructor(j61: string, floor: number | undefined, k61: string | undefined);
    /**
     * 返回该POI所在建筑物POI的id。如果当前POI为建筑物类POI，则cpid为自身POI ID；如果当前POI为商铺类POI，则cpid为其所在建筑物的POI ID。。
     * @return 所在建筑物POI的id。
     */
    getPoiId(): string;
    /**
     * 设置该POI所在建筑物POI的id。
     * @param poiId 所在建筑物POI的id。
     */
    setPoiId(i61: string): void;
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
