// @keepTs
// @ts-nocheck
import { NetManager } from '@amap/amap_lbs_common';
import { m19 } from '../interface/ILocNetManager';
import { AMapLocationOption } from '../location/AMapLocationOption';
import { AMapLocationReGeoInfo } from '../interface/AMapLocationReGeocode';
export declare class e28 implements m19 {
    j13: NetManager;
    locationOptions?: AMapLocationOption;
    context: Context;
    constructor(ctx: Context, options?: AMapLocationOption);
    n19(lat: number, lon: number): Promise<AMapLocationReGeoInfo>;
}
