// @keepTs
// @ts-nocheck
import { AMapLocationReGeoInfo } from './AMapLocationReGeocode';
export interface m19 {
    n19: (lat: number, lon: number) => Promise<AMapLocationReGeoInfo>;
}
