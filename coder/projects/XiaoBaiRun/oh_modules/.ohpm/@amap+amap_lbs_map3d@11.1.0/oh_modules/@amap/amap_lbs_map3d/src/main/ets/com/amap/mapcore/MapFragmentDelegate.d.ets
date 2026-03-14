// @keepTs
// @ts-nocheck
import { IAMap } from './interface/IAMap';
import { s11 } from './interface/IMapFragmentDelegate';
export declare class x10 implements s11 {
    static context?: Context;
    private r107;
    /**
     * 是否使用mapbox，海外版本默认为true
     * 仅有海外模块被打包进来的时候才生效
     */
    private f172;
    constructor(e172: IAMap);
    x11(): IAMap;
    onCreate(): void;
    onResume(): void;
    onPause(): void;
    onDestroy(): void;
    d65(flag: boolean): void;
}
