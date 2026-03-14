// @keepTs
// @ts-nocheck
import geoLocationManager from '@ohos.geoLocationManager';
import { LocationSource } from '../../api/LocationSource';
import { MyLocationStyle } from '../../api/model/MyLocationStyle';
export interface l60 {
    isMyLocationEnabled(): boolean;
    setLocationSource(locationSource: LocationSource): void;
    setMyLocationEnabled(enabled: boolean): void;
    setMyLocationStyle(style: MyLocationStyle): void;
    getMyLocationStyle(): MyLocationStyle | undefined;
    getMyLocation(): geoLocationManager.Location | undefined;
    d91(location: geoLocationManager.Location): void;
    s64(): string[];
    destroy(): void;
    onPause(): void;
    onResume(): void;
}
