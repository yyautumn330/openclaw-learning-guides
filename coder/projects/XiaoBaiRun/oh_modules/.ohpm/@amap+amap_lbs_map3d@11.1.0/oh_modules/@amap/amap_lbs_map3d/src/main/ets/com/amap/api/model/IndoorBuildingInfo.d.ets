// @keepTs
// @ts-nocheck
/**
 * 室内地图属性类，包含室内地图的POIID、楼层总数和当前显示楼层等。
 */
export declare class IndoorBuildingInfo {
    /**
     * 当前显示楼层的名称，如 F1
     */
    activeFloorName: string;
    /**
     * 当显示楼层,如 1
     */
    activeFloorIndex: number;
    /**
     * 室内地图的poiid，是室内地图的唯一标识。
     */
    poiid: string;
    /**
     * 室内地图楼层数组，如[-2,-1,1,2]
     */
    floor_indexs: Int32Array;
    /**
     * 室内地图楼层名称数组，如['B2','B1','F1','F2']
     */
    floor_names: Array<string>;
    constructor(j34: string, k34: number, l34: string, m34: Int32Array, n34: Array<string>);
    isValid(): boolean;
}
