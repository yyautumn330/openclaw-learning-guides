// @keepTs
// @ts-nocheck
/**
 * 我的位置图层
 */
import geoLocationManager from '@ohos.geoLocationManager';
import { LocationSource, OnLocationChangedListener } from '../../api/LocationSource';
import { MyLocationStyle } from '../../api/model/MyLocationStyle';
import { a60 } from '../AmapDelegateListenerManager';
import { IAMap } from '../interface/IAMap';
import { l60 } from '../interface/IMyLocationLayer';
export declare class m60 implements l60 {
    private context;
    private r276?;
    private s276?;
    /**
     * 默认不会使用定位小蓝点，所以默认为false
     */
    private isLocationEnabled;
    private readonly t276;
    private readonly g130;
    private u276;
    private v276;
    constructor(context: Context, p276: IAMap, q276: a60);
    onPause(): void;
    onResume(): void;
    destroy(): void;
    isMyLocationEnabled(): boolean;
    setLocationSource(o276: LocationSource): void;
    setMyLocationEnabled(enabled: boolean): void;
    setMyLocationStyle(style: MyLocationStyle): void;
    getMyLocationStyle(): MyLocationStyle | undefined;
    getMyLocation(): geoLocationManager.Location | undefined;
    d91(location: geoLocationManager.Location): void;
    s64(): string[];
}
export declare class l276 implements OnLocationChangedListener {
    private location?;
    private z276;
    constructor(m276: l60);
    getLocation(): geoLocationManager.Location | undefined;
    onLocationChanged(location: geoLocationManager.Location): void;
}
