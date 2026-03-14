// @keepTs
// @ts-nocheck
import { LatLonPoint } from "../LatLonPoint";
import { d48, e5 } from "./RequestCacheControl";
import { b48 } from "./RequestCacheWorker";
import HashMap from "@ohos.util.HashMap";
/**
 * 请求缓存,逆地理编码专用
 * @author zxy
 * @data 2020/9/14
 */
export declare class z44 extends b48 {
    private r48;
    constructor(pathList: Array<string>);
    protected n49(map: HashMap<e5, object | undefined>, y49: e5): boolean;
    protected o49(map: HashMap<e5, object | undefined>, x49: e5): object | undefined;
    protected p49(map: HashMap<e5, object | undefined>, v49: e5): object | undefined;
    o46(): number;
    z48(item: d48): void;
}
export declare class y44 {
    w3: LatLonPoint | undefined;
    b50: number;
    constructor(latitude: number, longitude: number, u49: number);
    a50(t49: object): boolean;
}
