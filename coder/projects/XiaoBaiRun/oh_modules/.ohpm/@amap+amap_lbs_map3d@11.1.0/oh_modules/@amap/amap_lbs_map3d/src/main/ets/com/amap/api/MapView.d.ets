// @keepTs
// @ts-nocheck
import { s11 } from '../mapcore/interface/IMapFragmentDelegate';
import { AMap } from './AMap';
/**
 * 地图view相关
 */
export declare class MapView {
    private mapFragmentDelegate;
    private mapViewName;
    private engineId;
    /**
     * 构造方法，不建议外部使用，sdk内部创建实例使用
     *
     * @param mapFragmentDelegate
     */
    constructor(u11: number, v11: string, w11: s11);
    getMapViewName(): string;
    /**
     * 异步获取地图操作实例AMap
     *
     * @param callback
     */
    getMapAsync(callback: (map: AMap) => void): void;
    /**
     * 地图生命周期方法，创建时调用，创建地图
     */
    onCreate(): void;
    /**
     * 地图生命周期方法，恢复时调用，目前无具体调用要求
     */
    onResume(): void;
    /**
     * 地图生命周期方法，暂停时调用，目前无具体调用要求
     */
    onPause(): void;
    /**
     * 地图生命周期方法，销毁是调用，销毁地图
     */
    onDestroy(): void;
    protected y11(): s11;
}
