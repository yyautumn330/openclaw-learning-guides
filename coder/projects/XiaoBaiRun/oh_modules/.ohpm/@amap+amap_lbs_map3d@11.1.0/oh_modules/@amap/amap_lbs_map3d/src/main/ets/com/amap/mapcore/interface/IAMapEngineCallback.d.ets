// @keepTs
// @ts-nocheck
import { BitmapDescriptor } from '../../api/model/BitmapDescriptor';
import { e16 } from '../../api/model/TileProviderInner';
import { w52 } from '../AMapAppRequestParam';
import { o66 } from '../MapPoi';
import { InitStorageParam } from '../../api/model/InitStorageParam';
export interface n66 {
    /**
     * 加载地图资源
     * @param engineId
     * @param fileName
     * @returns
     */
    requireMapResource(engineId: number, fileName: string): Uint8Array;
    /**
     * 生成请求ID
     * @returns
     */
    generateRequestId(): number;
    /**
     * 取消加载地图资源
     * @param instance
     */
    cancelRequireMapData(instance: bigint): void;
    /**
     * 加载字体
     * @param engineId
     * @param c
     * @param fontSize
     * @returns
     */
    requireCharBitmap(engineId: number, c: number, fontSize: number): Int8Array;
    /**
     * 加载字体
     * @param engineId
     * @param charBuffer
     * @param charSize
     * @param fontSize
     * @returns
     */
    requireCharsWidths(engineId: number, charBuffer: Int32Array, charSize: number, fontSize: number): Int8Array;
    /**
     * 渲染状态回调
     * @param engineId
     * @param renderState
     */
    onMapRender(engineId: number, renderState: number): void;
    /**
     * 室内地图数据回调
     * @param engineId
     * @param buffer
     */
    OnIndoorBuildingActivity(engineId: number, buffer: Uint8Array): void;
    /**
     * 底图poid点击回调
     *
     * @param mapPoi
     */
    onMapPOIClick(mapPoi: o66): void;
    /**
     * 底图空白区域点击回调
     *
     * @param x
     * @param y
     */
    onMapBlandClick(x: number, y: number): void;
    /**
     * amap resource loader加载回调
     *
     * @param param
     */
    onAMapAppResourceRequest(param: w52): void;
    getTerrainTileProvider(): e16;
    getSkyBoxImages(): BitmapDescriptor[];
    getStorageInitParam(): InitStorageParam;
    getDefaultTerrainImage(): BitmapDescriptor;
}
