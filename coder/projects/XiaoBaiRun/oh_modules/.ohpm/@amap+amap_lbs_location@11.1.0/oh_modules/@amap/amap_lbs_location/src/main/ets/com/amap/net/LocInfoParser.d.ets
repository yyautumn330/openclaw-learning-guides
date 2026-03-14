// @keepTs
// @ts-nocheck
import { AMapLocationReGeo, l19 } from '../interface/AMapLocationReGeocode';
import { AMapLocationOption } from '../location/AMapLocationOption';
export declare class k30 {
    locationOptions?: AMapLocationOption;
    constructor(options?: AMapLocationOption);
    e31(b31: string): AMapLocationReGeo;
    g31(y30: ArrayBuffer): AMapLocationReGeo;
    f31(r30: l19): AMapLocationReGeo;
    i31(p30: AMapLocationReGeo): void;
    k31(m30: string, n30: string, desc: string[], o30: AMapLocationReGeo): void;
    j31(l30: string, city: string, desc: string[]): void;
    h31(str: string): string;
}
