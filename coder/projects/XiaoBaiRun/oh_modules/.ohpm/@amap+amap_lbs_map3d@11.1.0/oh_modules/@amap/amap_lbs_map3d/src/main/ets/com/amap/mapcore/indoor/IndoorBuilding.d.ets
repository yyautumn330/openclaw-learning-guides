// @keepTs
// @ts-nocheck
import { IndoorBuildingInfo } from '../../api/model/IndoorBuildingInfo';
import { Point } from '../../api/model/Point';
export declare class IndoorBuilding extends IndoorBuildingInfo {
    nameCn: string;
    nameEn: string;
    numberofFloor: number;
    floorNonas: Array<string>;
    numberofParkFloor: number;
    parkFloorIndexs: Int32Array;
    geoCenter?: Point;
    mIndoorBuildType: string;
    constructor(i165: string, j165: number, k165: string, l165: Int32Array, m165: Array<string>, n165: Array<string>, o165: Int32Array, p165: Point);
    reverse(): void;
}
