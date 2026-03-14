// @keepTs
// @ts-nocheck
import { w52 } from './AMapAppRequestParam';
import { n66 } from './interface/IAMapEngineCallback';
import { o66 } from './MapPoi';
import { p66 } from './interface/IAMapNativeDelegate';
import { q66 } from './interface/AMapRenderStateListener';
import { e16 } from '../api/model/TileProviderInner';
import { BitmapDescriptor } from '../api/model/BitmapDescriptor';
import { InitStorageParam } from '../api/model/InitStorageParam';
export declare class s66 implements n66 {
    private static readonly TAG;
    private l67;
    private m51;
    private m67;
    private n67;
    private mContext;
    constructor(j67: p66, k67: q66, context: Context);
    requireMapResource(c67: number, fileName: string): Uint8Array;
    generateRequestId(): number;
    cancelRequireMapData(instance: bigint): void;
    requireCharBitmap(b67: number, c: number, fontSize: number): Int8Array;
    requireCharsWidths(y66: number, z66: Int32Array, a67: number, fontSize: number): Int8Array;
    onMapRender(w66: number, x66: number): void;
    OnIndoorBuildingActivity(v66: number, buffer: Uint8Array): void;
    onMapPOIClick(u66: o66): void;
    onMapBlandClick(x: number, y: number): void;
    onAMapAppResourceRequest(param: w52): void;
    getTerrainTileProvider(): e16;
    getSkyBoxImages(): BitmapDescriptor[];
    getDefaultTerrainImage(): BitmapDescriptor;
    getStorageInitParam(): InitStorageParam;
}
